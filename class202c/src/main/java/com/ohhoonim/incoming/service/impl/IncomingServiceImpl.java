package com.ohhoonim.incoming.service.impl;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.ohhoonim.dao.IncomingDao;
import com.ohhoonim.dao.PurchaseDao;
import com.ohhoonim.incoming.service.IncomingService;
import com.ohhoonim.purchase.service.PurchaseService;
import com.ohhoonim.stock.service.StockService;
import com.ohhoonim.vo.IncomingVo;
import com.ohhoonim.vo.PurchaseVo;
import com.ohhoonim.vo.StockVo;
import com.ohhoonim.common.Code999;

@Service("incomingService")
public class IncomingServiceImpl implements IncomingService{
	private static final Logger LOGGER = Logger.getLogger(IncomingService.class);
	@Resource(name="incomingDao")
	IncomingDao incomingDao;
	@Resource(name = "purchaseDao")
	PurchaseDao purchaseDao;	
	@Resource(name = "purchaseService")
	PurchaseService purchaseService;
	@Resource(name = "stockService")
	StockService stockService;
	
	
	@Override
	public String insertIncoming(IncomingVo incomingVo) {
		
		String result = null;
		String purchaseId = incomingVo.getPurchaseId();		
		//맥시멈 값을 구해서 amnt 검증해야한다.
		
		PurchaseVo purchaseVo = new PurchaseVo();
		purchaseVo.setPurchaseId(purchaseId);

		LOGGER.debug("//////////////////// purchaseId : "+ purchaseId + " ////////////////////");

		purchaseVo = purchaseService.Purchase_getAmnt_getSum(purchaseVo);		
		LOGGER.debug("//////////////////// purchaseAmnt 값들 구해옴 ////////////////////");
		int icAmnt = Integer.parseInt(incomingVo.getAmnt());
		int amntLo = Integer.parseInt(purchaseVo.getAmntLo());
		

		
		if (amntLo==0) {
			//이미 입고완료된 제품이다.
			
			return Code999.INCOMING_DONE_ALRADY;
		}else if(icAmnt>amntLo) {
			// 수량이 오버되서 들어왔다.
			
			return Code999.INCOMING_OVER_VALUE;		
		}else {		
			
			//여기부터 입력시작
			//count 컬럼 생성	

			int count = incomingCounter(incomingVo);
			incomingVo.setCount(String.valueOf(count+1));		
			//입력시간은 sysdate 사용한다		
			
			LOGGER.debug("//////////////////// 입력시작 ////////////////////");
			incomingDao.insertIncoming(incomingVo);
			
			LOGGER.debug("//////////////////// 발주 총합, 수량, 입고수량으로 입고수량의 icSum계산 ////////////////////");
			
//			단가 계산방식 
//			1. 	현재 재고의 양 stock 합 total 가져온다. ->> PRODUCT ID
//
//			2.  입고되는 재고의 양 icAmnt 가져온다. ->> 
//			3.  주문되는 재고의 양 purchaseAmnt,purchaseAmntLo 
//				합 purchaseSum,purchseSumLo 가져온다.
//
//			4.	icSum = purchseSumLo * icAmnt / purchaseAmntLo 는 입고되는 총합을 의미한다.
//			5. 	purchaseSumLo = purchaseSumLo-icSum
//
//			6.	total = icSum+total 부품 합 갱신
//				stock = stock + icAmnt 부품 양 갱신
//
//			7. 	unit_price = total / stock 을 하면 단가가 계산된다.
//			8.	unit_price, total, stock을 stock 테이블 갱신
//			9.	purchaseSumLo, purchaseAmntLo을 purchase 테이블 갱신
			
			BigDecimal purchaseAmntLo = new BigDecimal(purchaseVo.getAmntLo());
			BigDecimal purchaseSumLo = new BigDecimal(purchaseVo.getPurchaseSumLo());
			BigDecimal icAmnt_decimal = new BigDecimal(incomingVo.getAmnt());
			
			BigDecimal icSum = purchaseSumLo.multiply(icAmnt_decimal).divide(purchaseAmntLo, 0, BigDecimal.ROUND_HALF_UP);
			purchaseSumLo = purchaseSumLo.subtract(icSum);			
			
			LOGGER.debug("//////////////////// Stock 테이블에서 재고, 총합 호출 ////////////////////");
			StockVo stockVo = new StockVo();			
			String productId=purchaseId.substring(0, 10);
			stockVo.setProductId(productId);
			
			List<StockVo>stockDetail = stockService.getTotal_getStock(stockVo);
			BigDecimal stock= new BigDecimal(stockDetail.get(0).getStock());
			BigDecimal total= new BigDecimal(stockDetail.get(0).getTotal());
			
			total = icSum.add(total);
			stock = stock.add(icAmnt_decimal);
			
			BigDecimal unit_price = total.divide(stock,0,BigDecimal.ROUND_HALF_UP);
			
			stockVo.setUnitPrice(String.valueOf(unit_price));
			stockVo.setTotal(String.valueOf(total));
			stockVo.setStock(String.valueOf(stock));
			
			//amntLo 수량 업데이트
			LOGGER.debug("//////////////////// AMNT_LO 업데이트 ////////////////////");
			if(amntLo == icAmnt) {
				//입고완료 플래그 변경!
				LOGGER.debug("AMNT_LO 0 이므로 STATUS 입고완료 2313");
				amntLo=0;
				purchaseVo.setStatus(Code999.PURCHASE_CONDITION_COMPLETE);
				result = Code999.PURCHASE_CONDITION_COMPLETE;
			}else {
				//입고중 플래그 변경!
				LOGGER.debug("STATUS 입고중 2312");
				amntLo=amntLo-icAmnt;				
				purchaseVo.setStatus(Code999.PURCHASE_CONDITION_INCOMING);	
				result = Code999.PURCHASE_CONDITION_INCOMING;
			}		
			purchaseVo.setAmntLo(String.valueOf(amntLo));
			purchaseVo.setPurchaseSumLo(String.valueOf(purchaseSumLo));			
			purchaseVo.setPurchaseId(purchaseId);

			purchaseService.updatePurchase(purchaseVo);
			LOGGER.debug("//////////////////// purchase 업데이트 완료 ////////////////////");

			stockService.updateStock(stockVo);
			LOGGER.debug("//////////////////// 단가 및 재고 업데이트 완료 ////////////////////");
			
		}	
		return result;
	}

	@Override
	public List<Map<String,String>> selectIncoming(IncomingVo vo) {
		
		return incomingDao.selectIncoming(vo);
	}

	@Override
	public String updateIncoming(IncomingVo incomingVo) {
		//입력수량 마이너스 안되게 막아야한다.
		
		String purchaseId = incomingVo.getPurchaseId();
		int icAmnt= Integer.parseInt(incomingVo.getAmnt());
		//업데이트할 icAmnt
		
		//들어온 값으로 purchase 테이블 수량관련 값을 불러와 검증을 실시한다.			
						
		PurchaseVo purchaseVo = new PurchaseVo();
		purchaseVo.setPurchaseId(purchaseId);
		
		LOGGER.debug("//////////////////// purchaseId : "+ purchaseId +" ////////////////////");
		purchaseVo = purchaseService.Purchase_getAmnt_getSum(purchaseVo);				
		int amntLo=Integer.parseInt(purchaseVo.getAmntLo());	
		LOGGER.debug("//////////////////// purchase테이블에서 필요한 값들 구해옴 ////////////////////");
		
		int icAmnt_original = Integer.parseInt(incomingDao.getAmnt(incomingVo).getAmnt());
		LOGGER.debug("//////////////////// 해당 차수 incoming amnt 값 구해옴 ////////////////////");
		
		int amnt= icAmnt-icAmnt_original;
		//기존 수량과 현재수량의 차가 중요하다.
		
		if(amnt == 0) {
			// 입력한 수량과 기존의 수량이 같다. 업데이트 하지 않는다.
			LOGGER.debug("상태 메시지 : 입력수량이 기존값과 동일합니다.");								
			return Code999.INCOMING_SAME_VALUE;			
		}		
		if (amntLo<amnt) {
			// 입력한 수량이 남은수량보다 많다. 업데이트 하지 않는다.
			LOGGER.debug("상태 메시지 : 입력수량이 남은 발주량을 초과합니다.");		
			return Code999.INCOMING_OVER_VALUE;
		}		
		//업데이트 시작		
				
		
		LOGGER.debug("//////////////////// incoming 업데이트 시작 ////////////////////");
		incomingVo.setAmnt(String.valueOf(icAmnt));
		incomingDao.updateIncoming(incomingVo);
		LOGGER.debug("//////////////////// incoming 업데이트 완료 ////////////////////");
		
		String result = null;		
		
		LOGGER.debug("//////////////////// 발주 총합, 수량, 입고수량으로 입고수량의 icSum계산 ////////////////////");
		
//		1. 	현재 재고의 양 stock 합 total stock 테이블에서 가져온다. ->> by.PRODUCT ID
//
//		2.  입고되는 재고의 양 icAmnt(jsp에서 넘어오는) 가져온다. 
//			수정전 icAmnt_origin(incoming 테이블에서) 값 가져온다.
//			변동되는 재고의 양은 icAmnt = icAmnt_origin - icAmnt;	
//
//		3.  주문되는 재고의 양 purchaseAmnt,purchaseAmntLo 
//			합 purchaseSum,purchseSumLo 가져온다.

//
//		4.	icSum = purchaseSum * icAmnt/purchaseAmnt 이번차수 금액
//
//			if icAmnt == purchaseAmntLo 일경우,,
//
//			icSum = purchaseSumLo
//
//		5. 	purchaseSumLo = purchaseSumLo-IcSum
//
//		6.	total = total+icSum 부품 금액 합 갱신
//			stock = stock + icAmnt 부품 양 갱신
//
//		7. 	unit_price = total / stock 을 하면 단가가 계산된다.
//		8.	unit_price, total, stock을 stock 테이블 갱신
//		9.	amntLo, purchaseSumLo, purchaseAmntLo을 purchase 테이블 갱신
		
		int purchaseAmntLo = Integer.parseInt(purchaseVo.getAmntLo());
		icAmnt = amnt;
		
		BigDecimal purchaseAmnt_decimal = new BigDecimal(purchaseVo.getAmnt());
		//BigDecimal purchaseAmntLo_decimal = new BigDecimal(purchaseVo.getAmntLo());
		BigDecimal purchaseSum = new BigDecimal(purchaseVo.getPurchaseSum());
		BigDecimal purchaseSumLo = new BigDecimal(purchaseVo.getPurchaseSumLo());
		BigDecimal icAmnt_decimal = new BigDecimal(amnt);
		LOGGER.debug("//////////////////// 4,5 단계 실행 ////////////////////");
		
		
		BigDecimal icSum;		
		if (icAmnt == purchaseAmntLo) {
			//입고완료 			
			icSum = purchaseSumLo;	
			purchaseSumLo = new BigDecimal(0);
			
			//출고완료 플래그 변경!
			LOGGER.debug("AMNT_LO 0 이므로 STATUS 입고완료 2313");
			amntLo=0;
			purchaseVo.setStatus(Code999.PURCHASE_CONDITION_COMPLETE);
			result = Code999.PURCHASE_CONDITION_COMPLETE;
			
		}else {		
			//입고중			
			icSum = purchaseSum.multiply(icAmnt_decimal).divide(purchaseAmnt_decimal, 0, BigDecimal.ROUND_HALF_UP);
			purchaseSumLo = purchaseSumLo.subtract(icSum);			
			
			//입고중 플래그 변경!
			LOGGER.debug("STATUS 입고중 2312");		
			purchaseVo.setStatus("Code999.PURCHASE_CONDITION_INCOMING");
			result = Code999.PURCHASE_CONDITION_INCOMING;
		}			
		
		//계산된 amntLo purchaseSumLo vo에 담는다.
		purchaseAmntLo = purchaseAmntLo-icAmnt;
		purchaseVo.setAmntLo(String.valueOf(purchaseAmntLo));
		purchaseVo.setPurchaseSumLo(String.valueOf(purchaseSumLo));
		
		LOGGER.debug("//////////////////// Stock 테이블에서 재고, 총합 호출 ////////////////////");
		StockVo stockVo = new StockVo();			
		String productId=purchaseId.substring(0, 10);
		stockVo.setProductId(productId);
		List<StockVo>stockDetail = stockService.getTotal_getStock(stockVo);
		BigDecimal stock= new BigDecimal(stockDetail.get(0).getStock());
		BigDecimal total= new BigDecimal(stockDetail.get(0).getTotal());
		
		total = icSum.add(total);
		stock = stock.add(icAmnt_decimal);
		
		BigDecimal unit_price = total.divide(stock,0,BigDecimal.ROUND_HALF_UP);
		
		//stockVo.setProductId(productId);
		stockVo.setUnitPrice(String.valueOf(unit_price));
		stockVo.setTotal(String.valueOf(total));
		stockVo.setStock(String.valueOf(stock));
		
		//amntLo 수량 업데이트
		LOGGER.debug("//////////////////// AMNT_LO 업데이트 ////////////////////");

		purchaseVo.setPurchaseId(purchaseId);
		purchaseService.updatePurchase(purchaseVo);
		LOGGER.debug("//////////////////// purchase 업데이트 완료 ////////////////////");

		stockService.updateStock(stockVo);
		LOGGER.debug("//////////////////// 단가 및 재고 업데이트 완료 ////////////////////");		
		
		
		return result;
	}

	@Override
	public int deleteIncoming(IncomingVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Map<String, String> icAddView(PurchaseVo vo) {
		//purchaseId 만 사용한다.
		
		return purchaseDao.selectOnePurchase_short(vo);
	}

	@Override
	public int incomingCounter(IncomingVo vo) {		

		return incomingDao.incomingCounter(vo);
	}

	@Override
	public Map<String, String> icModifyView(IncomingVo vo) {
		
		return incomingDao.incomingDetail_short(vo);
	}




	
	

}

package com.ohhoonim.purchase.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.ohhoonim.dao.ProductDao;
import com.ohhoonim.dao.PurchaseDao;
import com.ohhoonim.purchase.service.PurchaseService;
import com.ohhoonim.vo.ProductVo;
import com.ohhoonim.vo.PurchaseVo;
import com.ohhoonim.common.Code999;

@Service("purchaseService")
public class PurchaseServiceImpl implements PurchaseService {
	private static final Logger LOGGER = Logger.getLogger(PurchaseServiceImpl.class);
	@Resource(name = "purchaseDao")
	PurchaseDao purchaseDao;	
	@Resource(name = "productDao")
	ProductDao productDao;		

	@Override
	public List<HashMap<String,String>> selectPurchaseList(PurchaseVo vo) {

		LOGGER.debug("//////////////////// 시작날짜 : " + vo.getStartDate() + " ////////////////////");
		LOGGER.debug("//////////////////// 종료날짜 : " + vo.getEndDate() + " ////////////////////");
		
		return purchaseDao.selectPurchase(vo);
	}
	
	@Override
	public Map<String,String> purchaseAddDetail(ProductVo vo) {

		return productDao.purchaseAddDetail(vo);
	}

	@Override
	public int insertPurchase(PurchaseVo vo) {
		
		String purchaseId = purchaseIdGenrator(vo);
		vo.setPurchaseId(purchaseId);
		
		return purchaseDao.insertPurchase(vo);
	}

	@Override
	public int updatePurchase(PurchaseVo vo) {
		
		return purchaseDao.updatePurchase(vo);
	}

	@Override
	public int deletePurchase(PurchaseVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public String purchaseIdGenrator(PurchaseVo vo) {
		
		String productId = vo.getProductId();
		LOGGER.debug("//////////////////// 들어온 productId : " + productId + " ////////////////////");		
		
		String counter = String.format("%04d", purchaseDao.purchaseIdCounter(vo)+1);
		StringBuffer purchaseId = new StringBuffer();
		purchaseId.append(productId);
		purchaseId.append("-");
		purchaseId.append(counter);
		LOGGER.debug("//////////////////// 생성된 purchaseId : " + purchaseId + " ////////////////////");		
		
		return purchaseId.toString();
	}

	@Override
	public PurchaseVo Purchase_getAmnt_getSum(PurchaseVo vo) {
		
		return purchaseDao.Purchase_getAmnt_getSum(vo);
	}



	
}

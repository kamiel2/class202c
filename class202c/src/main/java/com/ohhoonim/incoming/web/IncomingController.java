package com.ohhoonim.incoming.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ohhoonim.common.Code999;
import com.ohhoonim.common.util.Utils;
import com.ohhoonim.incoming.service.IncomingService;
import com.ohhoonim.purchase.service.PurchaseService;
import com.ohhoonim.stock.service.StockService;
import com.ohhoonim.vo.IncomingVo;
import com.ohhoonim.vo.PurchaseVo;

@Controller
@RequestMapping("/incoming")
public class IncomingController {
	private static final Logger LOGGER = Logger.getLogger(IncomingController.class);
	
	@Resource(name="incomingService")
	IncomingService incomingService;
	@Resource(name="purchaseService")
	PurchaseService purchaseService;
	@Resource(name="stockService")
	StockService stockService;
	
	
	@RequestMapping("/incomingSearch.do")
	@ResponseBody
	public Object incomingList(@RequestParam HashMap<String,String>req) {
		
		IncomingVo vo = new IncomingVo();
		String purchaseId = Utils.toEmptyBlank(req.get("purchaseId"));		
		vo.setPurchaseId(purchaseId);
		List<Map<String,String>> incomingList = incomingService.selectIncoming(vo);
		
		LOGGER.debug(incomingList.get(0).get("purchaseId"));
		
		Map <String, Object> result = new HashMap<String,Object>();
		result.put("result", incomingList);
		
		return result;
	}
	
	@RequestMapping("/incomingAddView.do")
	@ResponseBody
	public Object incomingView(@RequestParam HashMap<String,String>req) {
		
		
		String purchaseId = Utils.toEmptyBlank(req.get("purchaseId"));
		String count = req.get("icCount");
		Map <String, Object> result = new HashMap<String,Object>();
		
		LOGGER.debug("차수가 null 이면 등록화면 출력 숫자면 현재차수 춮력  : "+ count);	
		
		if(count == null) {
		PurchaseVo purchaseVo = new PurchaseVo();
		purchaseVo.setPurchaseId(purchaseId);
		Map<String,String> icAddView = incomingService.icAddView(purchaseVo);
		
		LOGGER.debug(icAddView.get("purchaseId"));
		icAddView.put("icAmnt", "");
		
		result.put("result", icAddView);
		}else {
			IncomingVo incomingVo = new IncomingVo();
			incomingVo.setPurchaseId(purchaseId);
			incomingVo.setCount(count);
			Map<String,String> icAddView = incomingService.icModifyView(incomingVo);
			
			StringBuffer count_sb= new StringBuffer();
			count_sb.append("[");
			count_sb.append(icAddView.get("count"));
			count_sb.append("차]");
			count = count_sb.toString();	
			
			LOGGER.debug(icAddView.get("purchaseId"));		
			LOGGER.debug(icAddView.get("count"));	
			LOGGER.debug(icAddView.get("icAmnt"));	
			
			icAddView.put("count", count);
			
			result.put("result", icAddView);			
		}
		
		return result;
	}
	
	@RequestMapping("/incomingAdd.do")
	@ResponseBody
	public Object incomingAdd(@RequestParam HashMap<String,String>req, ModelMap model) {
		
		LOGGER.debug("///////////////");	
		String purchaseId = Utils.toEmptyBlank(req.get("purchaseId"));	
		String amnt = Utils.toEmptyBlank(req.get("icAddAmnt"));	
		LOGGER.debug("purchaseId = "+ purchaseId+ " /////// amnt = "+ amnt);		
		IncomingVo vo = new IncomingVo();
		vo.setPurchaseId(purchaseId);
		vo.setAmnt(amnt);
		
		Map <String,String> result = new HashMap<String,String>();
		
		if(!Utils.chkInputOnlyNumber(amnt)) {
			
			result.put("msg", "숫자만 입력해주세요");		
			return result;		
		}
		if(Integer.parseInt(amnt)<0) {
			
			result.put("msg", "수량을 제대로 입력해주세요");		
			return result;
		}
		
		
		String chk = incomingService.insertIncoming(vo);
		LOGGER.debug("//////////chk : " + chk +"/////////////");
		String msg="";
		
		if(chk.equals(Code999.INCOMING_DONE_ALRADY)) {
			msg="이미 입고 완료된 제품입니다.. 입고내역을 확인해주세요";
		}
		if(chk.equals(Code999.INCOMING_OVER_VALUE)) {
			msg="입력한 수량에 문제가 있습니다. 다시 확인해주세요";	
		}
		if(chk.equals(Code999.PURCHASE_CONDITION_COMPLETE)) {
			msg="입력완료!";
		}
		if(chk.equals(Code999.PURCHASE_CONDITION_INCOMING)) {
			msg="입고 완료 되었습니다";
		}			
		
		result.put("result", msg);
		
		return result;
	}
	
	@RequestMapping("/incomingModify.do")
	@ResponseBody
	public Object incomingModify(@RequestParam HashMap<String,String>req, ModelMap model) {
		
		String purchaseId = Utils.toEmptyBlank(req.get("purchaseId"));	
		String icCount = Utils.toEmptyBlank(req.get("icCount"));	
		String amnt = Utils.toEmptyBlank(req.get("icAddAmnt"));	
		
		Map <String,String> result = new HashMap<String,String>();
		
		if(!Utils.chkInputOnlyNumber(amnt)) {
			
			result.put("msg", "숫자만 입력해주세요");		
			return result;		
		}
		if(Integer.parseInt(amnt)<0) {
			
			result.put("msg", "수량을 제대로 입력해주세요");		
			return result;
		}
		
		LOGGER.debug("purchaseId = " + purchaseId + " /////// 차수 = "+ icCount + "////////수량 : " + amnt);	
		
		IncomingVo vo = new IncomingVo();
		vo.setPurchaseId(purchaseId);
		vo.setCount(icCount);
		vo.setAmnt(amnt);
		
		String status = incomingService.updateIncoming(vo);
		String msg = "";
			
		if(status.equals(Code999.PURCHASE_CONDITION_INCOMING)) {
			msg="입력완료! (상태 : 입고중) 처리 되었습니다.";			
		}
		if(status.equals(Code999.PURCHASE_CONDITION_COMPLETE)) {
			msg="입력완료! 입고 완료 되었습니다.";	
		}
		if(status.equals(Code999.INCOMING_SAME_VALUE)) {
			msg="입력한 수량이 기존과 같습니다.";
		}
		if(status.equals(Code999.INCOMING_OVER_VALUE)) {
			msg="입력한 수량에 문제가 있습니다. 다시 확인해주세요.";				
		}

//		switch(status) {
//		case "abc":
//			msg="입력완료! (상태 : 입고중) 처리 되었습니다";
//			break;
//		
//		case Code999.PURCHASE_CONDITION_COMPLETE:
//			msg="입력완료! 입고 완료 되었습니다\";";
//			break;
//			
//		case Code999.INCOMING_SAME_VALUE:
//			msg="입력한 수량이 기존과 같습니다.";
//			break;
//		
//		case Code999.INCOMING_OVER_VALUE:
//			msg="입력한 수량에 문제가 있습니다. 다시 확인해주세요";		
//			break;						
//		}	
		
		
		result.put("result", msg);
		
		return result;
	}
	
	@RequestMapping("/incoming/incoming-004.do")
	public String incomingCancel(@RequestParam HashMap<String,String>req, ModelMap model) {
		
		return null;
	}

}
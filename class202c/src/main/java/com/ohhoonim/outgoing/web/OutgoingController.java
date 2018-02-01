package com.ohhoonim.outgoing.web;

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

import com.ohhoonim.common.util.Utils;
import com.ohhoonim.outgoing.service.OutgoingService;
import com.ohhoonim.vo.IncomingVo;
import com.ohhoonim.vo.OrdrVo;
import com.ohhoonim.vo.OutgoingVo;

@Controller
public class OutgoingController {
	private static final Logger LOGGER = Logger.getLogger(OutgoingController.class);
	
	@Resource(name="outgoingService")
	OutgoingService outgoingService;
	
	@RequestMapping("/outgoing/outgoingAddView.do")
	@ResponseBody
	public Object outgoingList(@RequestParam HashMap<String,String>req) {
		
		OrdrVo vo = new OrdrVo();
		String ordrId = Utils.toEmptyBlank(req.get("ordrId"));
		System.out.println("ordrId="+ordrId);
		vo.setOrdrId(ordrId);
		List<Map<String,Object>> ogAddViewList = outgoingService.ogAddViewList(vo);
		
		Map <String,Object> result = new HashMap<String,Object>();
		result.put("result", ogAddViewList);
		
		return result;
	}
	
	@RequestMapping("/outgoing/outgoingAdd.do")
	@ResponseBody
	public Object outgoingAdd(@RequestParam HashMap<String,String>req, ModelMap model) {
		String ordrId = Utils.toEmptyBlank(req.get("ordrId"));
		String amnt = req.get("ogAddAmnt");
		String productId = req.get("productId"); 
		
		int chk = 0;
		if (amnt != null && amnt.length() > 0) {
			String[] amnts = amnt.split(",");
			String[] productIds = productId.split(",");
			int size = amnts.length;
			for (int i = 0; i < size; i++) {
				String amount = amnts[i];
				if (Integer.parseInt(amount) > 0) {
					OutgoingVo vo = new OutgoingVo();
					vo.setOrdrId(ordrId);
					vo.setAmnt(amnts[i]);
					vo.setProductId(productIds[i]);
					chk += outgoingService.insertOutgoing(vo);
				}
			}
		}

		Map <String,String> result = new HashMap<String,String>();
		String msg= chk + "" ;
		result.put("result", msg);
		
		return result;
	}
	
	@RequestMapping("outgoing/outgoingModify.do")
	@ResponseBody
	public Object outgoingModify(@RequestParam HashMap<String,String>req, ModelMap model) {
		
		String ordrId = Utils.toEmptyBlank(req.get("ordrId"));	
		String ogCount = Utils.toEmptyBlank(req.get("ogCount"));	
		String amnt = Utils.toEmptyBlank(req.get("ogAddAmnt"));	
		
		Map <String,String> result = new HashMap<String,String>();
		
		if(!Utils.chkInputOnlyNumber(amnt)) {
			
			result.put("msg", "숫자만 입력해주세요");		
			return result;		
		}
		if(Integer.parseInt(amnt)<0) {
			
			result.put("msg", "수량을 제대로 입력해주세요");		
			return result;
		}
		
		LOGGER.debug("purchaseId = " + ordrId + " /////// 차수 = "+ ogCount + "////////수량 : " + amnt);	
		
		OutgoingVo vo = new OutgoingVo();
		vo.setOrdrId(ordrId);
		vo.setCount(ogCount);
		vo.setAmnt(amnt);
		
		int status = outgoingService.updateOutgoing(vo);
		String msg = "";
		
		switch(status) {
		case 0:
			msg="입력완료! 출고 완료 되었습니다";
			break;
		
		case 1:
			msg="입력완료! (상태 : 출고중)";
			break;
			
		case 2:
			msg="입력한 수량이 기존과 같습니다.";
			break;
		
		case 3:
			msg="입력한 수량에 문제가 있습니다. 다시 확인해주세요";		
			break;						
		}	
		
		
		result.put("result", msg);
		
		return result;
	}
	
	@RequestMapping("/outgoing/outgoing-003.do")
	public String outgoingDelete(@RequestParam HashMap<String,String>req, ModelMap model) {
		
		return null;
	}
	
	@RequestMapping("/outgoing/outgoing-004.do")
	public String outgoingCancel(@RequestParam HashMap<String,String>req, ModelMap model) {
		
		return null;
	}

}
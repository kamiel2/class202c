package com.ohhoonim.ptnr.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ohhoonim.common.util.Utils;
import com.ohhoonim.ptnr.service.PtnrService;
import com.ohhoonim.vo.ProductVo;
import com.ohhoonim.vo.PtnrVo;

@Controller
public class PtnrController {
	private static final Logger LOGGER = Logger.getLogger(PtnrController.class);
	
	@Resource(name="ptnrService")
	PtnrService ptnrService;
	
	@RequestMapping("/ptnr/ptnrList.do")
	public String ptnrList(@RequestParam Map<String,String> req, ModelMap model) {
		
		String ptnrNm=req.get("ptnrNm") == null?"":req.get("ptnrNm");
		PtnrVo vo = new PtnrVo();
		vo.setPtnrNm(ptnrNm);
		List<PtnrVo> list = ptnrService.ptnrList(vo);
		
		model.addAttribute("ptnrList",list);
		model.addAttribute("ptnrNm",ptnrNm);
		
		return "ptnr/ptnrList";
	}
	
	@RequestMapping("/ptnr/ptnrSearch1.do")
	@ResponseBody
	//검색기능
	public Object ptnrSearch(@RequestParam Map<String,String> req) {
		
		String type = Utils.toEmptyBlank(req.get("type"));
		String ptnrId = Utils.toEmptyBlank(req.get("ptnrId"));
		String ptnrNm = Utils.toEmptyBlank(req.get("ptnrNm"));
		
		PtnrVo vo = new PtnrVo();
		
		vo.setType(type.toUpperCase());
		vo.setPtnrId(ptnrId.toUpperCase());
		vo.setPtnrNm(ptnrNm.toUpperCase());
		
		List<PtnrVo> ptnrList = ptnrService.ptnrList(vo);
		
		Map<String, Object> searchResult = new HashMap<String, Object>();
		searchResult.put("result", ptnrList);
		
		return searchResult;
	}
	
	@RequestMapping("/ptnr/ptIdGenerator")
	@ResponseBody
	// productId 만드는 기능
	public Object ptIdGenerator(@RequestParam Map<String, String> req) {

		String type = req.get("type");

		PtnrVo vo = new PtnrVo();
		vo.setPtnrId(type);
		// 부품 ID는 'ctgrId'+5자리의 카운팅숫자로 이루어져있다. Like 'ctgrId%' 로 검색할것
		// 부품 ID 총 8자리로 줄였으면..

		String counter = String.format("%02d", ptnrService.ptnrCounter(vo) + 1);

		StringBuffer ptId = new StringBuffer();
		ptId.append(type);
		ptId.append(counter);
		LOGGER.debug("생성된 ptId" + ptId);

		Map<String, Object> json = new HashMap<String, Object>();
		json.put("ptId", ptId.toString());

		return json;
	}
	
	@RequestMapping("/ptnr/ptnrAddView.do")
	public String ptnrAddView(@RequestParam HashMap<String, String> req,ModelMap model) {
		String type = req.get("type"); 
		return "ptnr/ptnrAdd";
	}
	
	@RequestMapping("/ptnr/ptnrAdd.do")
	public String ptnrAdd(@RequestParam Map<String,String> req, RedirectAttributes redirectAttr) {
		String returnStr = "redirect:/ptnr/ptnrList.do";
		String ptnrId = req.get("PTNR_ID") == null?"":req.get("PTNR_ID");
		String ptnrNm = req.get("PTNR_NM") == null?"":req.get("PTNR_NM");
		String ptnrNmEng = req.get("PTNR_NM_ENG") == null?"":req.get("PTNR_NM_ENG");
		String registerNo = req.get("REGISTER_NO") == null?"":req.get("REGISTER_NO");
		String type = req.get("TYPE") == null?"":req.get("TYPE");
		String addr = req.get("ADDR") == null?"":req.get("ADDR");
		String tel = req.get("TEL") == null?"":req.get("TEL");
		String fax = req.get("FAX") == null?"":req.get("FAX");
		String ceoNm = req.get("CEO_NM") == null?"":req.get("CEO_NM");
		String cltNm = req.get("CLT_NM") == null?"":req.get("CLT_NM");
		String cltTel = req.get("CLT_TEL") == null?"":req.get("CLT_TEL");
		String cmnt = req.get("CMNT") == null?"":req.get("CMNT");
		
		if(ptnrId.equals("") || ptnrNm.equals("")) {
			Map<String,String> attrMap = new HashMap<String,String>();
			attrMap.put("ptnrId", ptnrId);
			attrMap.put("ptnrNm", ptnrNm);
			attrMap.put("ptnrNmEng", ptnrNmEng);
			attrMap.put("registerNo", registerNo);
			attrMap.put("type", type);
			attrMap.put("addr", addr);
			attrMap.put("tel", tel);
			attrMap.put("fax", fax);
			attrMap.put("ceoNm", ceoNm);
			attrMap.put("cltNm", cltNm);
			attrMap.put("cltTel", cltTel);
			attrMap.put("cmnt", cmnt);
			attrMap.put("msg", "please check your input");
			
			redirectAttr.addFlashAttribute("rtnParam", attrMap);
			returnStr = "redirect:/ptnr/ptnrAddView.do";
		}else {
			PtnrVo vo = new PtnrVo();
			vo.setPtnrId(ptnrId);
			vo.setPtnrNm(ptnrNm);
			vo.setPtnrNmEng(ptnrNmEng);
			vo.setRegisterNo(registerNo);
			vo.setType(type);
			vo.setAddr(addr);
			vo.setTel(tel);
			vo.setFax(fax);
			vo.setCeoNm(ceoNm);
			vo.setCltNm(cltNm);
			vo.setCltTel(cltTel);
			vo.setCmnt(cmnt);
			

			ptnrService.ptnrAdd(vo);
		}		
		return returnStr;
	}
	
	@RequestMapping("/ptnr/ptnrDetail.do")
	public String ptnrDetail(@RequestParam HashMap<String,String>req, ModelMap model) {
		String ptnrId = req.get("ptnrId") == null?"":req.get("ptnrId");
		PtnrVo vo = new PtnrVo();
		vo.setPtnrId(ptnrId);
		Map<String,Object> resultPtnr = ptnrService.getPtnr(vo);
		
		model.addAttribute("ptnrId", ptnrId);
		model.addAttribute("ptnr", resultPtnr);
		
		return "ptnr/ptnrDetail";
	}
	
	@RequestMapping("/ptnr/ptnrModifyView.do")
	public String ptnrModifyView(@RequestParam Map<String,String> req, ModelMap model) {
		String ptnrId=req.get("ptnrId")==null?"":req.get("ptnrId");
		
		PtnrVo ptnrvo = new PtnrVo();
		ptnrvo.setPtnrId(ptnrId);
		Map<String,Object> resultPtnr = ptnrService.getPtnr(ptnrvo);
		
		model.addAttribute("ptnr", resultPtnr);
		return "ptnr/ptnrModifyView";
	}
	
	@RequestMapping("/ptnr/ptnrModify.do")
	public String ptnrModify(@RequestParam Map<String,String>req,RedirectAttributes redirectAttr) {
		String returnStr = "redirect:/ptnr/ptnrDetail.do?ptnrId="+Utils.toEmptyBlank(req.get("PTNR_ID"));
		
		String ptnrId = req.get("PTNR_ID") == null?"":req.get("PTNR_ID");
		String ptnrNm = req.get("PTNR_NM") == null?"":req.get("PTNR_NM");
		String ptnrNmEng = req.get("PTNR_NM_ENG") == null?"":req.get("PTNR_NM_ENG");
		String registerNo = req.get("REGISTER_NO") == null?"":req.get("REGISTER_NO");
		String type = req.get("TYPE") == null?"":req.get("TYPE");
		String addr = req.get("ADDR") == null?"":req.get("ADDR");
		String tel = req.get("TEL") == null?"":req.get("TEL");
		String fax = req.get("FAX") == null?"":req.get("FAX");
		String ceoNm = req.get("CEO_NM") == null?"":req.get("CEO_NM");
		String cltNm = req.get("CLT_NM") == null?"":req.get("CLT_NM");
		String cltTel = req.get("CLT_TEL") == null?"":req.get("CLT_TEL");
		String cmnt = req.get("CMNT") == null?"":req.get("CMNT");
		
		if(ptnrId.equals("") || ptnrNm.equals("")) {
			
			Map<String,String> attrMap = new HashMap<String,String>();
			attrMap.put("ptnrId", ptnrId);
			attrMap.put("ptnrNm", ptnrNm);
			attrMap.put("ptnrNmEng", ptnrNmEng);
			attrMap.put("registerNo", registerNo);
			attrMap.put("type", type);
			attrMap.put("addr", addr);
			attrMap.put("tel", tel);
			attrMap.put("fax", fax);
			attrMap.put("ceoNm", ceoNm);
			attrMap.put("cltNm", cltNm);
			attrMap.put("cltTel", cltTel);
			attrMap.put("cmnt", cmnt);
			attrMap.put("msg", "please check your input");
			
			redirectAttr.addFlashAttribute("rtnParam", attrMap);
			returnStr = "redirect:/ptnr/ptnrModify.do";
		}else {
			PtnrVo vo = new PtnrVo();
			vo.setPtnrId(ptnrId);
			vo.setPtnrNm(ptnrNm);
			vo.setPtnrNmEng(ptnrNmEng);
			vo.setRegisterNo(registerNo);
			vo.setType(type);
			vo.setAddr(addr);
			vo.setTel(tel);
			vo.setFax(fax);
			vo.setCeoNm(ceoNm);
			vo.setCltNm(cltNm);
			vo.setCltTel(cltTel);
			vo.setCmnt(cmnt);
			

			int cnt = ptnrService.ptnrModify(vo);
			redirectAttr.addFlashAttribute("ptnrId",ptnrId);
		}			
		return returnStr;		
	}	
	
	////////유경식 추가부분
	//ptnrSearch 팝업창. 해당부분은 부품등록시 사용예정
	
	@RequestMapping("/ptnr/ptnrSearch.do")
	public String ptnrSearch(@RequestParam Map<String,String> req, ModelMap model) {
		
		String ptnrNm=req.get("ptnrNm") == null?"":req.get("ptnrNm");
		PtnrVo vo = new PtnrVo();
		vo.setType("1000");
		vo.setPtnrNm(ptnrNm.toUpperCase());
		
		List<PtnrVo> list = ptnrService.ptnrSearch(vo);
		
		model.addAttribute("ptnrList",list);
		model.addAttribute("ptnrNm",ptnrNm);
		
		return "ptnr/ptnrSearch";
	}
	////////////
}
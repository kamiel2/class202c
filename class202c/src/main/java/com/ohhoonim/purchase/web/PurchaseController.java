package com.ohhoonim.purchase.web;

import java.math.BigDecimal;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ohhoonim.category.service.CategoryService;
import com.ohhoonim.common.util.Utils;
import com.ohhoonim.purchase.service.PurchaseService;
import com.ohhoonim.vo.CategoryVo;
import com.ohhoonim.vo.ProductVo;
import com.ohhoonim.vo.PurchaseVo;
import com.ohhoonim.common.Code999;

@Controller
@RequestMapping("/purchase")
public class PurchaseController {
	private static final Logger LOGGER = Logger.getLogger(PurchaseController.class);
	@Resource(name="purchaseService")
	PurchaseService purchaseService;
	@Resource(name = "categoryService")
	CategoryService ctgrService;
	
	
	@RequestMapping("/purchase-000.do")
	public String purchaseCreate() {	
		
		return "purchase/order-000";
		
	}
	
	@RequestMapping("/purchaseList.do")
	public String purchaseList(@RequestParam HashMap<String,String>req,ModelMap model) {
		
		PurchaseVo vo = new PurchaseVo();
		List<HashMap<String,String>> purchaseList = purchaseService.selectPurchaseList(vo);
		
		model.put("purchaseList", purchaseList);
		
		CategoryVo ctgrvo = new CategoryVo();
		ctgrvo.setCtgrLvl(Code999.CATEGORY_1ST);
		// 대분류만 최초 로딩
		List<CategoryVo> ctgrList = ctgrService.selectCtgrIdNm(ctgrvo);
		model.addAttribute("ctgrList", ctgrList);
		
		return "purchase/purchaseList";
		
	}
	
	@RequestMapping("/purchaseSearch.do")
	@ResponseBody
	// 검색기능
	public Object productSearch(@RequestParam Map<String, String> req) {

		String ctgr1st = Utils.toEmptyBlank(req.get("ctgr1st"));
		String ctgr2nd = Utils.toEmptyBlank(req.get("ctgr2nd"));
		String ctgr3rd = Utils.toEmptyBlank(req.get("ctgr3rd"));
		String productId = Utils.toEmptyBlank(req.get("productId"));
		String productNm = Utils.toEmptyBlank(req.get("productNm"));
		String ptnrNm = Utils.toEmptyBlank(req.get("ptnrNm"));
		String startDate = Utils.toEmptyBlank(req.get("startDate"));
		String endDate = Utils.toEmptyBlank(req.get("endDate"));
		
		PurchaseVo vo = new PurchaseVo();
		
		vo.setProductId(productId.toUpperCase());
		vo.setProductNm(productNm.toUpperCase());
		vo.setPtnrNm(ptnrNm.toUpperCase());
		vo.setStartDate(startDate);
		vo.setEndDate(endDate);
		
		if (ctgr3rd.length() == 5) {
			vo.setCtgrId(ctgr3rd);		
			}
		if (ctgr2nd.length() == 5) {
			vo.setCtgrId(ctgr2nd.substring(0, 3));
			}
		if (ctgr1st.length() == 5) {
			vo.setCtgrId(ctgr1st.substring(0, 1));	
			}
		
		List<HashMap<String, String>> purchaseList = purchaseService.selectPurchaseList(vo);
		
		LOGGER.debug("테스트");
		
		Map<String, Object> searchResult = new HashMap<String, Object>();
		searchResult.put("result", purchaseList);
		return searchResult;
	}
	
	@RequestMapping("/purchaseAddView.do")
	public String productAddView(@RequestParam HashMap<String, String> req, ModelMap model) {
		//productId 검증 좀더필요
		
		String productId = Utils.toEmptyBlank(req.get("productId"));
		ProductVo vo = new ProductVo();
		vo.setProductId(productId);
		Map<String,String>purchaseAddDetail=purchaseService.purchaseAddDetail(vo);		
		model.addAttribute("purchaseAddDetail", purchaseAddDetail);		
		return "purchase/purchaseAdd";
	}

	@RequestMapping("/purchaseAdd.do")
	public String productAdd(@RequestParam HashMap<String, String> req, ModelMap model, RedirectAttributes reAttr) {
		
		//String purchaseId    = Utils.toEmptyBlank(req.get("purchaseId"));
		String productId     = Utils.toEmptyBlank(req.get("productId"));
		//String unitPrice     = Utils.toEmptyBlank(req.get("unitPrice"));
		String amnt          = Utils.toEmptyBlank(req.get("amnt"));
		//String amntLo        = Utils.toEmptyBlank(req.get("amntLo"));
		String confirmDate   = Utils.toEmptyBlank(req.get("confirmDate"));
		String status        = "2311";
		String eta           = Utils.toEmptyBlank(req.get("eta"));	
		//eta 추후 구현		
		String purchaseSum       = Utils.toEmptyBlank(req.get("purchaseSum"));
		String cmnt          = Utils.toEmptyBlank(req.get("cmnt"));
		// PURCHASE_DATE 는 sysdate 로 서버시간으로 기입한다.
		
		BigDecimal amnt_bd= new BigDecimal(amnt);
		BigDecimal ordrSum_bd= new BigDecimal(purchaseSum);				
		BigDecimal unitPrice = ordrSum_bd.divide(amnt_bd, 2, BigDecimal.ROUND_DOWN);	
		//unitPrice 단가계산
		
		PurchaseVo vo = new PurchaseVo ();
		//vo.setPurchaseId(purchaseId);		
		
		vo.setProductId(productId);
		vo.setUnitPrice(unitPrice.toString());
		vo.setAmnt(amnt);
		vo.setAmntLo(amnt);
		vo.setConfirmDate(confirmDate);
		vo.setStatus(status);
		vo.setPurchaseSum(purchaseSum);
		vo.setPurchaseSumLo(purchaseSum);
		vo.setCmnt(cmnt);				
		
		purchaseService.insertPurchase(vo);

		return "redirect://purchase/purchaseList.do";
	}	
	
	@RequestMapping("/purchase-003.do")
	public String purchaseDelete(@RequestParam HashMap<String,String>req,ModelMap model) {
		return null;
		
	}
	
	@RequestMapping("/purchase-004.do")
	public String purchaseCancel(@RequestParam HashMap<String,String>req,ModelMap model) {
		return null;
		
	}

}

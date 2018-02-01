
package com.ohhoonim.ordr.web;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ohhoonim.common.Constants;
import com.ohhoonim.common.util.Utils;
import com.ohhoonim.ordr.service.OrdrService;
import com.ohhoonim.outgoing.service.OutgoingService;
import com.ohhoonim.product.service.ProductService;
import com.ohhoonim.category.service.CategoryService;
import com.ohhoonim.vo.CategoryVo;
import com.ohhoonim.vo.OrdrVo;
import com.ohhoonim.vo.ProductVo;
import com.ohhoonim.vo.OutgoingVo;
import com.ohhoonim.vo.PtnrVo;

@Controller
@RequestMapping("/ordr")
public class OrdrController {
	private static final Logger LOGGER = Logger.getLogger(OrdrController.class);
	
	@Resource(name = "outgoingService")
	OutgoingService outgoingService;
	
	@Resource(name = "ordrService")
	OrdrService ordrService;

	@Resource(name = "productService")
	ProductService productService;

	@Resource(name = "categoryService")
	CategoryService ctgrService;
	
/*	@Resource(name = "PtnrService")
	PtnrService ptnrService;
*/
	////////////////////////////////////////////////////
	@RequestMapping("/ordr_index.do")
	public String ordrCreate(@RequestParam HashMap<String, String> req, ModelMap model) {

		OrdrVo vo = new OrdrVo();
		ProductVo pvo = new ProductVo();

		String productId = Utils.toEmptyBlank(req.get("productId"));
		String productNm = Utils.toEmptyBlank(req.get("productNm"));
		String ptnrNm = Utils.toEmptyBlank(req.get("ptnrNm"));
		
		String ctgr1st = Utils.toEmptyBlank(req.get("ctgr1st"));
		String ctgr2nd = Utils.toEmptyBlank(req.get("ctgr2nd"));
		String ctgr3rd = Utils.toEmptyBlank(req.get("ctgr3rd"));

		if (ctgr3rd.length() == 5) {
			pvo.setCtgrId(ctgr3rd);
		}
		if (ctgr2nd.length() == 5) {
			pvo.setCtgrId(ctgr2nd.substring(0, 3));
		}
		if (ctgr1st.length() == 5) {
			pvo.setCtgrId(ctgr1st.substring(0, 1));
		}
		pvo.setProductId(productId);
		pvo.setProductNm(productNm);
		pvo.setPtnrNm(ptnrNm);

		List<ProductVo> productList = productService.selectProductB(pvo);
		
		model.addAttribute("productList", productList);
		model.addAttribute("productId", productId);
		model.addAttribute("productNm", productNm);
		model.addAttribute("ptnrNm", ptnrNm);

		CategoryVo ctgrvo = new CategoryVo();
		ctgrvo.setCtgrLvl("5100");

		List<CategoryVo> ctgrList = ctgrService.selectCtgrIdNm(ctgrvo);
		model.addAttribute("ctgrList", ctgrList);

		return "ordr/ordr_index";
	}
/*  디테일에 뜨는 정보와 주문 페이지 정보의 종류 자체가 같음
 * 
	@RequestMapping("/itemDetail.do")
	public String itemDetail(@RequestParam HashMap<String, String> req, ModelMap model) {

		String productId = (req.get("productId") == null ? "" : req.get("productId"));

		model.addAttribute("pId", productId);

		OrdrVo vo = new OrdrVo();

		OrdrVo itemDetail = ordrService.itemDetail(vo);
		model.addAttribute("itemDetail", itemDetail);

		return "ordr/itemDetail";
	}
*/
	

	@RequestMapping("/ordrList.do")
	public String ordrList(@RequestParam HashMap<String, String> req, ModelMap model) {
		
		String ordrId = req.get("ordrId") == null ? "" : req.get("ordrId");
		String startDate = req.get("startDate") == null ? "" : req.get("startDate");
		String endDate = req.get("endDate") == null ? "" : req.get("endDate");

		OrdrVo vo = new OrdrVo();
		vo.setOrdrId(ordrId);
		vo.setStartDate(startDate);
		vo.setEndDate(endDate);

		List<Map<String,Object>> resultOrdr = ordrService.selectOrdrList(vo);
		List<Map<String,Object>> resultOrdrOutgoing = ordrService.selectOrdrOutgoingList(vo);

		model.addAttribute("ordrList", resultOrdr);
		model.addAttribute("ordroutgoingList", resultOrdrOutgoing);
		model.addAttribute("ordrId", ordrId);
	
		return "ordr/ordrList";
	}
	
		
	@RequestMapping("/ordrSearch.do")
	@ResponseBody
	public Object ordrSearch(@RequestParam HashMap<String, String> req) {
		
		String ordrId = Utils.toEmptyBlank(req.get("ordrId"));
		String ptnrNm = Utils.toEmptyBlank(req.get("ptnrNm"));
		String productNm = Utils.toEmptyBlank(req.get("productNm"));
		String startDate = Utils.toEmptyBlank(req.get("startDate"));
		String endDate = Utils.toEmptyBlank(req.get("endDate"));
		
		System.out.println("startDate:"+startDate);
		System.out.println("endDate:"+endDate);
		
		OrdrVo vo = new OrdrVo();
		
		vo.setOrdrId(ordrId.toUpperCase());
		vo.setPtnrNm(ptnrNm.toUpperCase());
		vo.setProductNm(productNm.toUpperCase());
		vo.setStartDate(startDate);
		vo.setEndDate(endDate);
		
		List<Map<String,Object>> ordrList = ordrService.selectOrdrList(vo);
		
		Map<String,Object> searchResult = new HashMap<String,Object>();
		searchResult.put("result", ordrList);
		
		return searchResult;
	}
	
	@RequestMapping("/ordrSearch1.do")
	@ResponseBody
	public Object ordrSearch1(@RequestParam HashMap<String, String> req) {
		
		String ordrId = Utils.toEmptyBlank(req.get("ordrId"));
		
		OrdrVo vo = new OrdrVo();
		
		vo.setOrdrId(ordrId.toUpperCase());
		
		List<Map<String,Object>> ordroutgoingList = ordrService.selectOrdrOutgoingList(vo);
		
		Map<String,Object> searchResult1 = new HashMap<String,Object>();
		searchResult1.put("result1", ordroutgoingList);
		
		return searchResult1;
	}
	
	@RequestMapping("/ordroutgoingModify.do")
	public String ordroutgoingModify(@RequestParam Map<String,String> req,RedirectAttributes redirectAttr) {
		String ordrId=req.get("ordrId")==null?"":req.get("ordrId");
		String productId=req.get("productId")==null?"":req.get("productId");
		String amnt2=req.get("amnt2")==null?"":req.get("amnt2");
		String count=req.get("count")==null?"":req.get("count");
		
		OutgoingVo vo = new OutgoingVo();
		vo.setOrdrId(ordrId);
		vo.setProductId(productId);
		vo.setAmnt2(amnt2);
		vo.setCount(count);
		
		int cnt = outgoingService.ordroutgoingModify(vo);
		return "redirect:/ordr/ordrList.do";
	}
	
	@RequestMapping("/updateConfirm.do")
	public String updateConfirm(@RequestParam Map<String, String> req) {
		String ordrId = req.get("ordrId");
		String prdId = req.get("prdId");
		
		String[] ordrIds = ordrId.split(",");
		String[] prdIds = prdId.split(",");
		int size = ordrIds.length;
		for(int i = 0; i < size; i++) {
			OrdrVo vo = new OrdrVo();
			vo.setOrdrId(ordrIds[i]);
			vo.setProductId(prdIds[i]);
			ordrService.ordrupdateConfirm(vo);
		}
		
		
//		System.out.println(productId);

		return "redirect:/ordr/ordrList.do";
	}
	
	@RequestMapping("/putCart.do")  // 카트에 넣는다 !!! putCart
	public String putCart(@RequestParam HashMap<String, String> req, ModelMap model) {
		
		String productId = req.get("productId") == null ? "" : req.get("productId");
		String amnt = req.get("amnt") == null ? "" : req.get("amnt");
		
		OrdrVo vo = new OrdrVo();
		vo.setProductId(productId);
		vo.setAmnt(amnt);
		
		ordrService.putCart(vo);
		
		return "redirect:/ordr/ordr_index.do";
	}
	
	@RequestMapping("/putCartAjax.do")  // 카트에 넣는다 !!! putCart
	@ResponseBody
	public Object putCartAjax(@RequestParam HashMap<String, String> req) {
		
		String productId = req.get("productId") == null ? "" : req.get("productId");
		String amnt = req.get("amnt") == null ? "" : req.get("amnt");
		
		OrdrVo vo = new OrdrVo();
		vo.setProductId(productId);
		vo.setAmnt(amnt);
		
		ordrService.putCart(vo);
		
		Map<String, String> rtnMap = new HashMap<String, String>();
		rtnMap.put("resultMsg", productId + " 가 " + amnt + " 개 담아졌습니다.");
		return rtnMap;
	}
	/**
	 * 장바구니 페이지 이동
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping("/ordr-001.do")  
		public String cartView(@RequestParam HashMap<String, String> req, ModelMap model) {
		String productId = Utils.toEmptyBlank(req.get("productId"));
		String cartAmnt = Utils.toEmptyBlank(req.get("cartAmnt"));
		String cartId = Utils.toEmptyBlank(req.get("cartId"));
		
		OrdrVo vo = new OrdrVo();
		vo.setProductId(productId);
		vo.setCartAmnt(cartAmnt);
		vo.setCartId(cartId);
		
		List<Map<String, Object>> cartView = ordrService.cartView(vo);
		model.addAttribute("cartView", cartView);
		
		return "ordr/order-001";
	}
	
	/**
	 * 주문하기(장바구니화면에서)
	 * @param req
	 * @return
	 */
	@RequestMapping("/finalOrdr.do")  
	public String finalOrdr(@RequestParam MultiValueMap<String, String> req, ModelMap model, HttpServletRequest request) {
		
		List<String> cartAmntList = req.get("cartAmnt");
		List<String> productIdList = req.get("productId");
		List<String> sum = req.get("sum");
		
		if (cartAmntList != null && productIdList != null) {
			String ordrId = ordrService.nextOrdrId();
			int listSize = cartAmntList.size();
			for(int i = 0; i < listSize; i++) {
				String amnt = cartAmntList.get(i);
				String productId = productIdList.get(i);
				
				OrdrVo vo = new OrdrVo();
				vo.setPtnrId(Constants.getPtnrId(request.getSession()));
				vo.setOrdrId(ordrId);
				vo.setAmnt(amnt);
				vo.setProductId(productId);
				vo.setSum(sum.get(0));
				ordrService.finalOrdr(vo);
			}
		}
		
		return "redirect:/ordr/ordr-004.do";
	}
	
	
	///////////////////// 장바구니 선택 삭제
	@RequestMapping("/delCart.do")
	public String cartRemove(@RequestParam Map<String, String> req) {
		String productId = req.get("productId");

		String[] prdIds = productId.split(",");
		int size = prdIds.length;
		for(int i = 0; i < size; i++) {
			OrdrVo vo = new OrdrVo();
			vo.setProductId(prdIds[i]);
			ordrService.ordrDelCart(vo);
		}

		
//		System.out.println(productId);

		return "redirect:/ordr/ordr-001.do";
	}

	
	@RequestMapping("/amntUpdate.do")
	public String amntUpdate(@RequestParam Map<String, String> req) {

		String productId = Utils.toEmptyBlank(req.get("productId"));
		String cartAmnt = Utils.toEmptyBlank(req.get("cartAmnt"));
		
		OrdrVo vo = new OrdrVo();
		vo.setProductId(productId);
		vo.setCartAmnt(cartAmnt);
		
		ordrService.AmntUpdate(vo);
		
		return "redirect:/ordr/ordr-001.do";
	}
	
	@RequestMapping("/delOrdr.do")
	public String ordrRemove(@RequestParam Map<String, String> req) {
		String productId = req.get("productId");
		String ordrId = req.get("ordrId");
		
		OrdrVo vo = new OrdrVo();	
		
		String[] ordIds = ordrId.split(",");
		String[] prdIds = productId.split(",");
		
		int size = prdIds.length;
		for(int i = 0; i < size; i++) {

		vo.setProductId(prdIds[i]);
		vo.setOrdrId(ordIds[i]);
			
		ordrService.ordrDelOrdr(vo);
			
		}
		return "redirect:/ordr/ordr-004.do";
	}
	
	@RequestMapping("/ordr-003.do")
	public String ordrList4(@RequestParam HashMap<String, String> req, ModelMap model) {

		return "ordr/order-003";
	}

	@RequestMapping("/ordr-004.do")
	public String cartList(@RequestParam HashMap<String, String> req, ModelMap model) {
		
		OrdrVo vo = new OrdrVo();
	    Date today = new Date();
		
		SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMDD");
		String todayStr = sdf.format(today);
		
		String ordrId = req.get("ordrId") == null ? "" : req.get("ordrId");
		String startDate = req.get("startDate") == null ? todayStr + "000000" : req.get("startDate");
		String endDate = req.get("endDate") == null ? todayStr + "235959" : req.get("endDate");
		
		vo.setOrdrId(ordrId);
		vo.setStartDate(startDate);
		vo.setEndDate(endDate);
		
			List<Map<String,Object>> result = ordrService.cartList(vo);
			model.addAttribute("cartList", result);
					
		return "ordr/order-004";
	}

	@RequestMapping("/ordr/ordr-005.do")
	public String ordrCancel(@RequestParam HashMap<String, String> req, ModelMap model) {

		return null;
	}

	@RequestMapping("/ordr/ordr-006.do")
	public String ordrDelete(@RequestParam HashMap<String, String> req, ModelMap model) {

		return null;
	}

}

package com.ohhoonim.product.web;

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

import com.ohhoonim.common.Code999;
import com.ohhoonim.category.service.CategoryService;
import com.ohhoonim.common.util.Utils;
import com.ohhoonim.product.service.ProductService;
import com.ohhoonim.ptnr.service.PtnrService;
import com.ohhoonim.stock.service.StockService;
import com.ohhoonim.vo.CategoryVo;
import com.ohhoonim.vo.ProductVo;
import com.ohhoonim.vo.PtnrVo;
import com.ohhoonim.vo.StockVo;

@Controller
@RequestMapping("/product")
public class ProductController {
	private static final Logger LOGGER = Logger.getLogger(ProductController.class);

	@Resource(name = "productService")
	ProductService productService;
	@Resource(name = "categoryService")
	CategoryService ctgrService;
	@Resource(name = "ptnrService")
	PtnrService ptnrService;
	@Resource(name = "stockService")
	StockService stockService;

	@RequestMapping("/productList.do")
	public String productView(@RequestParam HashMap<String, String> req, ModelMap model) {

		ProductVo vo = new ProductVo();
		// 기존 검색 로직..
		/////////////////////////////////
		/*
		 * 
		 * String searchValue = (req.get("searchValue") == null ? "" :
		 * req.get("searchValue")); String searchType = (req.get("searchType") == null ?
		 * "" : req.get("searchType")); System.out.println(searchValue);
		 * System.out.println(searchType);
		 * 
		 * String ctgr1st = Utils.toEmptyBlank(req.get("ctgr1st")); String ctgr2nd =
		 * Utils.toEmptyBlank(req.get("ctgr2nd")); String ctgr3rd =
		 * Utils.toEmptyBlank(req.get("ctgr3rd"));
		 * 
		 * System.out.println(ctgr1st); System.out.println(ctgr2nd);
		 * System.out.println(ctgr3rd);
		 * 
		 * 
		 * model.addAttribute("searchValue", searchValue);
		 * model.addAttribute("searchType", searchType);
		 * 
		 * if(searchType.length()>0) { if(searchType.equals("pId")) {
		 * System.out.println("pId"); vo.setProductId(searchValue.toUpperCase());
		 * 
		 * }else if(searchType.equals("pNm")) { System.out.println("pNm");
		 * vo.setProductNm(searchValue.toUpperCase());
		 * 
		 * }else if(searchType.equals("ptnrNm")) { System.out.println("ptnrNm");
		 * vo.setPtnrNm(searchValue.toUpperCase()); } }
		 * 
		 * while(true) { if (ctgr3rd.length()==5) { vo.setCtgrId(ctgr3rd); break; } if
		 * (ctgr2nd.length()==5) { vo.setCtgrId(ctgr2nd.substring(0, 3)); break; } if
		 * (ctgr1st.length()==5) { vo.setCtgrId(ctgr1st.substring(0, 1)); break; }
		 * break; }
		 */
		// 기존 검색로직 ajax파트로 내려보냈다.
		///////////////////////////////////

		List<ProductVo> productList = productService.selectProductList(vo);
		model.addAttribute("productList", productList);

		CategoryVo ctgrvo = new CategoryVo();
		ctgrvo.setCtgrLvl(Code999.CATEGORY_1ST);
		// 대분류만 최초 로딩
		List<CategoryVo> ctgrList = ctgrService.selectCtgrIdNm(ctgrvo);
		model.addAttribute("ctgrList", ctgrList);

		return "product/productList";
	}

	@RequestMapping("/productSearch.do")
	@ResponseBody
	// 검색기능
	public Object productSearch(@RequestParam Map<String, String> req) {

		String ctgr1st = Utils.toEmptyBlank(req.get("ctgr1st"));
		String ctgr2nd = Utils.toEmptyBlank(req.get("ctgr2nd"));
		String ctgr3rd = Utils.toEmptyBlank(req.get("ctgr3rd"));
		String productId = Utils.toEmptyBlank(req.get("productId"));
		String productNm = Utils.toEmptyBlank(req.get("productNm"));
		String ptnrNm = Utils.toEmptyBlank(req.get("ptnrNm"));

		ProductVo vo = new ProductVo();


		// 구버전용 SELECT BOX 용
		/*
		 * String searchValue = (req.get("searchValue") == null ? "" :
		 * req.get("searchValue")); String searchType = (req.get("searchType") == null ?
		 * "" : req.get("searchType"));
		 * 
		 * if(searchType.length()>0) { if(searchType.equals("pId")) {
		 * System.out.println(searchType); System.out.println(searchValue);
		 * vo.setProductId(searchValue.toUpperCase());
		 * 
		 * }else if(searchType.equals("pNm")) { System.out.println(searchType);
		 * System.out.println(searchValue); vo.setProductNm(searchValue.toUpperCase());
		 * 
		 * }else if(searchType.equals("ptnrNm")) { System.out.println(searchType);
		 * System.out.println(searchValue); vo.setPtnrNm(searchValue.toUpperCase()); } }
		 */
		// 위에꺼는 구버전 SelectBox 전용.

		vo.setProductId(productId.toUpperCase());
		vo.setProductNm(productNm.toUpperCase());
		vo.setPtnrNm(ptnrNm.toUpperCase());
		
		if (ctgr1st.length() == 5) {
			vo.setCtgrId(ctgr1st.substring(0, 1));	
			}
		if (ctgr2nd.length() == 5) {
			vo.setCtgrId(ctgr2nd.substring(0, 3));
			}
		if (ctgr3rd.length() == 5) {
			vo.setCtgrId(ctgr3rd);		
			}
		//카테고리 검색
		
		
		List<ProductVo> productList = productService.selectProductList(vo);

		Map<String, Object> searchResult = new HashMap<String, Object>();
		searchResult.put("result", productList);

		return searchResult;
	}

	@RequestMapping("/productDetail.do")
	public String productDetail(@RequestParam HashMap<String, String> req, ModelMap model, RedirectAttributes reAttr) {

		String productId = (req.get("productId") == null ? "" : req.get("productId"));
		model.addAttribute("pId", productId);

		ProductVo vo = new ProductVo();
		vo.setProductId(productId);
		LOGGER.debug(productId);

		///// vo사용
		// ProductVo productDetail = productService.productDetail(vo);
		// model.addAttribute("productDetail", productDetail);
		// 이건 vo를 이용한..

		///// Map사용
		Map<String, String> productDetailMap = productService.productDetailMap(vo);
		model.addAttribute("productDetailMap", productDetailMap);
		// Map 사용한..

		return "product/productDetail";
	}

	@RequestMapping("/pIdGenerator")
	@ResponseBody
	// productId 만드는 기능
	public Object pIdGenerator(@RequestParam Map<String, String> req) {

		String ctgrId = req.get("ctgrId");

		ProductVo vo = new ProductVo();
		vo.setProductId(ctgrId);
		// 부품 ID는 'ctgrId'+5자리의 카운팅숫자로 이루어져있다. Like 'ctgrId%' 로 검색할것
		// 부품 ID 총 8자리로 줄였으면..

		String pId = productService.pIdGenerator(vo);

		Map<String, Object> json = new HashMap<String, Object>();
		json.put("pId", pId);

		return json;
	}

	@RequestMapping("/productAddView.do")
	public String productAddView(@RequestParam HashMap<String, String> req, ModelMap model) {

		CategoryVo ctgrvo = new CategoryVo();
		ctgrvo.setCtgrLvl(Code999.CATEGORY_1ST);
		// 대분류만 최초 로딩
		List<CategoryVo> ctgrList = ctgrService.selectCtgrIdNm(ctgrvo);
		model.addAttribute("ctgrList", ctgrList);

		return "product/productAdd";
	}

	@RequestMapping("/productAdd.do")
	public String productAdd(@RequestParam HashMap<String, String> req, ModelMap model, RedirectAttributes reAttr) {

		String productId = Utils.toEmptyBlank(req.get("productId"));
		String ptnrId = Utils.toEmptyBlank(req.get("ptnrId"));
		String returnUrl = "";

		String ctgr1st = Utils.toEmptyBlank(req.get("ctgr1st"));
		String ctgr2nd = Utils.toEmptyBlank(req.get("ctgr2nd"));
		String ctgr3rd = Utils.toEmptyBlank(req.get("ctgr3rd"));
		String productNm = Utils.toEmptyBlank(req.get("productNm"));
		String salesCost = Utils.toEmptyBlank(req.get("salesCost"));
		String cmnt = Utils.toEmptyBlank(req.get("cmnt"));
		// 이상 PRODUCT 테이블로 들어가는 데이터

		String safetyStock = Utils.toEmptyBlank(req.get("safetyStock"));
		String stock = "0"; // 최초 등록시 재고는 0이다 무조건..
		String unitPrice = "0"; // 최초 등록시 단가는 0이다 무조건..
		String total = "0"; // 최초 등록시 부품 총액은 0이다 무조건..
		String soldAmnt = "0";
		String status = Code999.STOCK_CONDITION_SAFE;
		// 이상 STOCK 테이블로 들어가는 데이터

		LOGGER.debug(Utils.chkInputOnlyNumber(safetyStock));
		LOGGER.debug(Utils.chkInputOnlyNumber(salesCost));
		if (Utils.chkInputOnlyNumber(safetyStock) && Utils.chkInputOnlyNumber(salesCost)) {
			ProductVo pvo = new ProductVo();
			pvo.setProductId(productId);
			pvo.setCtgr1st(ctgr1st);
			pvo.setCtgr2nd(ctgr2nd);
			pvo.setCtgr3rd(ctgr3rd);
			pvo.setProductNm(productNm);
			pvo.setPtnrId(ptnrId);
			pvo.setSalesCost(salesCost);
			pvo.setCmnt(cmnt);

			StockVo svo = new StockVo();
			svo.setProductId(productId);
			svo.setSafetyStock(safetyStock);
			svo.setStock(stock);
			svo.setUnitPrice(unitPrice);
			svo.setTotal(total);
			svo.setSoldAmnt(soldAmnt);
			svo.setStatus(status);

			PtnrVo ptnrVo = new PtnrVo();
			ptnrVo.setPtnrId(ptnrId);

			// 각각 vo 담기완료

			String statusCode = productService.insertProduct(pvo, svo, ptnrVo);

			// 여기서 상태코드가 반환이 되어온다.

			LOGGER.debug("상태코드는?:" + status);
			
			
			if(statusCode.equals(Code999.PRODUCT_INSERT_COMPLETE)) {
				// 정상적으로 실행된 케이스. 해당 부품 디테일로 리턴해준다.
				StringBuffer url = new StringBuffer();
				url.append("redirect:/product/productDetail.do?productId=");
				url.append(productId);
				returnUrl = url.toString();				
			}
			
			if(statusCode.equals(Code999.PRODUCT_INSERT_NO_PTNRID)) {
				// 존재하지 않는 ptnrId 삭제되었거나 변경되었을 가능성
				req.put("msg", "PTNRID ERROR!!");
				reAttr.addFlashAttribute("reAttr", req);
				returnUrl = "redirect:/product/productAddView.do";			
			}
			
			if(statusCode.equals(Code999.PRODUCT_INSERT_PRODUCTID_ERROR)) {
				// productId에 문제가 있음.
				req.put("msg", "PRODUCT TABLE PRODUCTID ERROR!!");
				returnUrl = "redirect:/product/productAddView.do";				
			}

		} else {
			req.put("msg", "안전재고와 가격은 숫자만 입력하세요!");
			returnUrl = "redirect:/product/productAddView.do";
		}
		return returnUrl;
	}

	@RequestMapping("/productModifyView.do")
	public String productModify(@RequestParam HashMap<String, String> req, ModelMap model) {

		String productId = (req.get("productId") == null ? "" : req.get("productId"));
		model.addAttribute("pId", productId);

		ProductVo vo = new ProductVo();
		vo.setProductId(productId);
		LOGGER.debug("들어온 pid" + productId);

		///// Map사용
		Map<String, String> productDetailMap = productService.productDetailMap(vo);
		model.addAttribute("productDetailMap", productDetailMap);
		// Map 사용한..

		/*
		 * CategoryVo ctgrvo = new CategoryVo(); ctgrvo.setCtgrLvl("5100"); // 대분류만 최초
		 * 로딩
		 * 
		 * List<CategoryVo> ctgrList = ctgrService.selectCtgrIdNm(ctgrvo);
		 * model.addAttribute("ctgrList", ctgrList);
		 */

		return "product/productModify";
	}

	@RequestMapping("/productModify.do")
	public String productDelete(@RequestParam HashMap<String, String> req, ModelMap model, RedirectAttributes reAttr) {

		String productId = Utils.toEmptyBlank(req.get("productId"));
		String ptnrId = Utils.toEmptyBlank(req.get("ptnrId"));
		String returnUrl = "";

		String ctgr1st = Utils.toEmptyBlank(req.get("ctgrid1st"));
		String ctgr2nd = Utils.toEmptyBlank(req.get("ctgrid2nd"));
		String ctgr3rd = Utils.toEmptyBlank(req.get("ctgrid3rd"));
		String productNm = Utils.toEmptyBlank(req.get("productNm"));
		String salesCost = Utils.toEmptyBlank(req.get("salesCost"));
		String cmnt = Utils.toEmptyBlank(req.get("cmnt"));
		// 이상 PRODUCT 테이블로 들어가는 데이터

		String safetyStock = Utils.toEmptyBlank(req.get("safetyStock"));
		// String stock = "0"; // 최초 등록시 재고는 0이다 무조건..
		// String unitPrice = "0"; // 최초 등록시 단가는 0이다 무조건..
		// 주의 Add와는 다르게 안전재고와 매입가격은 vo에 담지 않는다!!

		// 이상 STOCK 테이블로 들어가는 데이터

		ProductVo pvo = new ProductVo();
		pvo.setProductId(productId);
		pvo.setCtgr1st(ctgr1st);
		pvo.setCtgr2nd(ctgr2nd);
		pvo.setCtgr3rd(ctgr3rd);
		pvo.setProductNm(productNm);
		pvo.setPtnrId(ptnrId);
		pvo.setSalesCost(salesCost);
		pvo.setCmnt(cmnt);

		StockVo svo = new StockVo();
		svo.setProductId(productId);
		svo.setSafetyStock(safetyStock);
		// svo.setStock(stock);
		// svo.setUnitPrice(unitPrice);

		PtnrVo ptnrVo = new PtnrVo();
		ptnrVo.setPtnrId(ptnrId);
		// 각각 vo 담기완료

		String status = productService.updateProduct(pvo, svo, ptnrVo);

		// 여기서 상태코드가 반환이 되어온다.
		LOGGER.debug("상태코드는?:" + status);
		
		if(status.equals(Code999.PRODUCT_INSERT_COMPLETE)) {
			// 정상적으로 실행된 케이스. 해당 부품 디테일로 리턴해준다.
			StringBuffer url = new StringBuffer();
			url.append("redirect:/product/productDetail.do?productId=");
			url.append(productId);
			returnUrl = url.toString();			
		}
		
		if(status.equals(Code999.PRODUCT_INSERT_NO_PTNRID)) {
			// 존재하지 않는 ptnrId 삭제되었거나 변경되었을 가능성
			req.put("msg", "존재 하지 않는 회사ID입니다. ptnrId 오류");
			reAttr.addFlashAttribute("reAttr", req);
			returnUrl = "redirect:/product/productAddView.do";		
		}
		
		if(status.equals(Code999.PRODUCT_INSERT_PRODUCTID_ERROR)) {
			// productId에 문제가 있음.
			req.put("msg", "존재하지 않는 productId 입니다. productId오류");
			returnUrl = "redirect:/product/productAddView.do";
		}
		return returnUrl;
	}
}

package com.ohhoonim.product.web;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ohhoonim.category.service.CategoryService;
import com.ohhoonim.product.service.ProductService;
import com.ohhoonim.vo.ProductVo;
import com.ohhoonim.vo.CategoryVo;

@Controller
@RequestMapping("/purchase")
public class ClientController {

	@Resource(name = "productService")
	ProductService productService;
	@Resource(name = "categoryService")
	CategoryService ctgrService;

	public class ItemController {
		@RequestMapping("/itemDetail.do")
		public String itemDetail(@RequestParam HashMap<String, String> req, ModelMap model) {

			String productId = (req.get("productId") == null ? "" : req.get("productId"));
			model.addAttribute("pId", productId);

			ProductVo vo = new ProductVo();
			vo.setProductId(productId);
			System.out.println(productId);

			ProductVo itemDetail = productService.productDetail(vo);
			model.addAttribute("itemDetail", itemDetail);

			return "purchase/itemDetail";
		}
	}
}


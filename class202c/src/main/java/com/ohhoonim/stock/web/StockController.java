package com.ohhoonim.stock.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ohhoonim.common.util.Utils;


@Controller
public class StockController {
	@RequestMapping("/stock/stockList.do")
	public String ptnrList(@RequestParam Map<String,String> req, ModelMap model) {
		
		
		
		return "stock/stockList";
	}
}

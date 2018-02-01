package com.ohhoonim.idManage.web;

import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ohhoonim.idManage.service.IdManageService;

@Controller
public class IdManageController {
	@Resource(name="idManageService")
	IdManageService idManageService;
	
	@RequestMapping("/idManage/idManage-000.do")
	public String idManageCreate(@RequestParam HashMap<String,String>req, ModelMap model) {
		
		return null;
	}
	
	@RequestMapping("/idManage/idManage-001.do")
	public String idManageList(@RequestParam HashMap<String,String>req, ModelMap model) {
		
		return null;
	}
	
	@RequestMapping("/idManage/idManage-002.do")
	public String idManageModify(@RequestParam HashMap<String,String>req, ModelMap model) {
		
		return null;
	}
	
	@RequestMapping("/idManage/idManage-003.do")
	public String idManageDelete(@RequestParam HashMap<String,String>req, ModelMap model) {
		
		return null;
	}
	
	@RequestMapping("/idManage/idManage-004.do")
	public String idManageCancel(@RequestParam HashMap<String,String>req, ModelMap model) {
		
		return null;
	}

}
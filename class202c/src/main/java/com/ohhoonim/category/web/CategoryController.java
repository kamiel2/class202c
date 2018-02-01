package com.ohhoonim.category.web;

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
import com.ohhoonim.product.web.ProductController;
import com.ohhoonim.vo.CategoryVo;

@Controller
@RequestMapping("/category")
public class CategoryController {
	private static final Logger LOGGER = Logger.getLogger(CategoryController.class);
	@Resource(name="categoryService")
	CategoryService ctgrService;

	@RequestMapping("/findCtgr.do")
	@ResponseBody
	//하위 Category 찾아서 리턴해준다. 
	public Object findCtgr(@RequestParam Map<String,String> req) {
		
		String ctgrId = req.get("ctgrId") == null?"":req.get("ctgrId");
		System.out.println(ctgrId);
		
		CategoryVo vo = new CategoryVo();
		vo.setCtgrParent(ctgrId);
		//넘어온 ctgrId 에서 이 값을 ctgr_Parent 컬럼에 담고 있는놈들을 색출할것이다.
		
		List<CategoryVo> ctgrList= ctgrService.selectCtgrIdNm(vo);		
				
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("ctgrList", ctgrList);
		
		return result;
	}	
	
	@RequestMapping("/categoryAddView.do")
	public String categoryCreate(@RequestParam HashMap<String,String>req, ModelMap model) {
		
		CategoryVo ctgrVo = new CategoryVo();
		ctgrVo.setCtgrLvl("5100");
		// 대분류만 최초 로딩
		List<CategoryVo> ctgrList = ctgrService.selectCtgrIdNm(ctgrVo);
		model.addAttribute("ctgrList", ctgrList);	
		
		
		return "category/categoryAdd";		
	}
	
	@RequestMapping("/categoryAdd.do")
	public String categoryAdd(@RequestParam Map<String,String>req, ModelMap model, RedirectAttributes reAttr) {		
		

		String ctgrNm = req.get("ctgrNm");
		String ctgrId = req.get("ctgrId");
		String ctgrLvl = req.get("ctgrLvl");	
		
		if(ctgrNm != null || ctgrId != null || ctgrLvl != null) {
			ctgrNm = Utils.toEmptyBlank(req.get("ctgrNm"));
			ctgrId = Utils.toEmptyBlank(req.get("ctgrId"));	
			ctgrLvl = Utils.toEmptyBlank(req.get("ctgrLvl"));	
			String ctgrParent = req.get("ctgrParent");	
			//null 처리를 하면 안된다. ctgr1st 의 경우 null 이 들어가야한다!!
			
			//차라리 만들어둔 IdGenerator 를 통해서 보여지지않고 자동생성해서 무결성으로 들어가게 할것인가?
			
			LOGGER.debug("카테고리이름:"+ctgrNm);		
			LOGGER.debug("카테고리ID:"+ctgrId);		
			LOGGER.debug("카테고리부모:"+ctgrParent);		
			LOGGER.debug("카테고리레벨:"+ctgrLvl);	
				
			CategoryVo ctgrVo = new CategoryVo();
			ctgrVo.setCtgrId(ctgrId);
			ctgrVo.setCtgrLvl(ctgrLvl);
			ctgrVo.setCtgrNm(ctgrNm);
			ctgrVo.setCtgrParent(ctgrParent);	
			
			ctgrService.insertCtgr(ctgrVo);
			//pk 무결성검사와 이름중복검사를 수행하지 않고 넣는다. 나중에 퀄리티 올리면된다...
			
			StringBuffer msg = new StringBuffer();
			msg.append("[");
			msg.append(ctgrNm);
			msg.append("] 카테고리를 [");
			msg.append(ctgrId);
			msg.append("] 으로 등록 완료!");
			
			reAttr.addFlashAttribute("msg", msg.toString());
			
		}else {
			//입력값중 하나라도  Null이면..
			
			reAttr.addFlashAttribute("msg", "다시 입력해주세요!!!!");			
		}

		return "redirect:/category/categoryAddView.do";
	}
	
	@RequestMapping("/ctgrIdGenerator.do")
	@ResponseBody
	//하위 Category 찾아서 리턴해준다. 
	public Object ctgrIdGenerator(@RequestParam Map<String,String> req) {		
		
		String ctgrNm = Utils.toEmptyBlank(req.get("ctgrNm"));
		String ctgrLvl = Utils.toEmptyBlank(req.get("ctgrLvl"));
		String ctgrParent = Utils.toEmptyBlank(req.get("ctgrParent"));	
				
		LOGGER.debug("ctgrNm:"+ctgrNm);
		LOGGER.debug("ctgrLvl:"+ctgrLvl);
		LOGGER.debug("ctgrParent:"+ctgrParent);				
		
		//ctgrLvl 과 ctgrParent 에 대한 유효성 검사를 1차 진행하면 더 좋을듯.
		//자바스크립트에서 정규화식을 통해 공백제거와 uppercase 를 진행하였기에 여기서 생략했다.
		//하지만 Utils에 공백제거와 null 체크 한번에하는 기능 만들어둠

		CategoryVo vo = new CategoryVo();
		vo.setCtgrNm(ctgrNm);
		vo.setCtgrParent(ctgrParent);
		vo.setCtgrLvl(ctgrLvl);
		//들어가야하는 값은 ctgrParent, ctgrNm, ctgrLvl
		
		String returnString = ctgrService.ctgrIdGenerator(vo);
		LOGGER.debug("생성된 ctgrId : " + returnString);	
		
		String msg = "true";
		if(returnString.length() != 5) {
			msg = "false";
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("ctgrId", returnString);
		result.put("msg", msg);
		
		return result;
	}
	

	
	@RequestMapping("/category/category-002.do")
	public String categoryModify(@RequestParam HashMap<String,String>req,ModelMap model) {
		return null;
		
	}
	
	@RequestMapping("/category/category-003.do")
	public String categoryDelete(@RequestParam HashMap<String,String>req,ModelMap model) {
		return null;
		
	}
	
	@RequestMapping("/category/category-004.do")
	public String categoryCancel(@RequestParam HashMap<String,String>req,ModelMap model) {
		return null;
		
	}


}

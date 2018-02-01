package com.ohhoonim.board.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ohhoonim.board.service.BoardService;
import com.ohhoonim.common.util.Paging;
import com.ohhoonim.vo.BoardVo;

@Controller
public class AjaxBoardController {
	
	@Resource(name = "boardService")
	BoardService boardService;
	
	@RequestMapping("/ajax/board.do")
	@ResponseBody
	public Object selectBoardList(@RequestParam HashMap<String, String> req) {
		String title = (req.get("title") == null ? "" : req.get("title"));
		String pageNo = (req.get("pageNo") == null ? "1" : req.get("pageNo"));
		String fName = (req.get("fName")) == null ? "" : req.get("fName");
		
		BoardVo vo = new BoardVo();
		vo.setTitle(title);
		vo.setPageNo(Integer.parseInt(pageNo));
		vo.setPageSize(10);
		
		List<BoardVo> noticeList = boardService.selectNotice(vo);
		List<BoardVo> resultList = boardService.selectBoardList(vo);
		int totalCnt = boardService.selectBoardListCount(vo);
		
		Paging paging = new Paging();
		paging.setPageNo(Integer.parseInt(pageNo));
		paging.setPageSize(10);
		paging.setTotalCount(totalCnt);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("noticeList", noticeList);
		resultMap.put("paging", paging);
		resultMap.put("resultList", resultList);		
		resultMap.put("title", title);
		resultMap.put("fName", fName);
		
		return resultMap;
	}
	
	
	

}

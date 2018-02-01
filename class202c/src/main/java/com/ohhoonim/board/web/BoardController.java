package com.ohhoonim.board.web;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ohhoonim.board.service.BoardService;
import com.ohhoonim.common.util.Paging;
import com.ohhoonim.vo.BoardVo;

@Controller
public class BoardController {
	
	@Resource(name = "boardService")
	BoardService boardService;
	
	@RequestMapping("/board/board.do")
	public String selectBoardList(@RequestParam HashMap<String, String> req, ModelMap model) {
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
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("paging", paging);
		model.addAttribute("resultList", resultList);		
		model.addAttribute("title", title);
		model.addAttribute("fName", fName);
		
		return "board/boardList";
	}
	
	
	@RequestMapping(value = "/board/boardView.do")
	public String viewBoard(@RequestParam HashMap<String, String> req,
			ModelMap model) {
		String bNumber = req.get("bNumber");
		BoardVo vo = new BoardVo();
		vo.setbNumber(bNumber);

		boardService.updateViewCount(vo);
		BoardVo resultVo = boardService.viewBoard(vo);
		model.addAttribute("resultVo", resultVo);
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardModify.do") //게시물 수정
	public String updateBoard(@RequestParam HashMap<String, String> req,
			ModelMap model) {
		
		BoardVo vo = new BoardVo();
		vo.setbNumber(req.get("bNumber"));
		vo.setMemberId(req.get("memberId"));
		vo.setCategory(req.get("category"));
		vo.setTitle(req.get("title"));
		vo.setrDate(req.get("rDate"));
		vo.setClickNum(req.get("clickNum"));
		vo.setFileId(req.get("fileId"));
		vo.setContents(req.get("contents"));
		
		boardService.updateBoard(vo);
		return "redirect:/board/board.do";
	
	}

	
	@RequestMapping(value = "/board/boardModifyView.do")
	public String ftvUpdateView(@RequestParam HashMap<String, String> req,
			ModelMap model) {
		String bNumber = req.get("bNumber");
		
		BoardVo vo = new BoardVo();
		vo.setbNumber(bNumber);
		
		BoardVo resultVo = boardService.viewBoard(vo);
		
		model.addAttribute("resultVo", resultVo);
		return "board/boardModify";
	}
	
	
	
	@RequestMapping(value = "/board/boardAddView.do")
	public String ftvAddView(@RequestParam HashMap<String, String> req,
			ModelMap model) {
	
	
		
		return "board/boardAdd";
	}
	
	

	@RequestMapping(value="/board/boardAdd.do")
	public String addBoard(@RequestParam HashMap<String, String> req, ModelMap model ) {
		
		
		BoardVo vo = new BoardVo();
		vo.setbNumber(req.get("bNumber"));
		vo.setMemberId(req.get("memberId"));
		vo.setCategory(req.get("category"));
		vo.setTitle(req.get("title"));
		vo.setrDate(req.get("rDate"));
		vo.setFileId(req.get("fileId"));
		vo.setContents(req.get("contents"));
		
		
		boardService.addBoard(vo);
				
		return "redirect:/board/board.do";
	}
	
		
	@RequestMapping(value="/board/boardDelete.do")
	public String deleteBoard(@RequestParam HashMap<String, String> req, ModelMap model ) {
		
		String bNumber = req.get("bNumber");
	
		BoardVo vo = new BoardVo();
		vo.setbNumber(bNumber);
		
		boardService.deleteBoard(vo);
		
		return "redirect:/board/board.do";
	}
	
	

}

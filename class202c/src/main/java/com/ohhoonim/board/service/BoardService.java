package com.ohhoonim.board.service;

import java.util.List;

import com.ohhoonim.vo.BoardVo;

public interface BoardService {
	public List<BoardVo> selectBoardList(BoardVo vo);
	public List<BoardVo> selectNotice(BoardVo vo);
	public int selectBoardListCount(BoardVo vo);
	public BoardVo viewBoard(BoardVo vo);
	public int addBoard(BoardVo vo);
	public int updateBoard(BoardVo vo);
	public int deleteBoard(BoardVo vo);
	public int updateViewCount(BoardVo vo);
	
	
}

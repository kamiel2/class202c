package com.ohhoonim.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.ohhoonim.vo.BoardVo;

@Repository("boardDao")
public class BoardDao extends Mapper {

	public List<BoardVo> selectBoardList(BoardVo vo) {

		return selectList ("selectBoardList", vo);
	}
	
	public List<BoardVo> selectNotice(BoardVo vo) {

		return selectList ("selectNotice", vo);
	}
	
	public int selectBoardListCount(BoardVo vo) {

		return selectOne("selectBoardListCount", vo);
	}

	public BoardVo viewBoard(BoardVo vo) {
	
		return selectOne("selectBoard", vo);
	}

	public int addBoard(BoardVo vo) {
		
		return insert("addBoard", vo);
	}

	public int updateBoard(BoardVo vo) {

		return update("updateBoard", vo);
	}
	
	public int updateViewCount(BoardVo vo) {

		return update("updateViewCount", vo);
	}

	public int deleteBoard(BoardVo vo) {

		return delete("deleteBoard", vo);
	}
	
	
}
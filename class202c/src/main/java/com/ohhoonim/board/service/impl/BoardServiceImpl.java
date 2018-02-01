package com.ohhoonim.board.service.impl;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.ohhoonim.board.service.BoardService;
import com.ohhoonim.dao.BoardDao;
import com.ohhoonim.vo.BoardVo;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Resource(name = "boardDao")
	BoardDao boardDao;

	@Override
	public List<BoardVo> selectBoardList(BoardVo vo) {
		
		return boardDao.selectBoardList(vo);
	}
	
	public List<BoardVo> selectNotice(BoardVo vo) {
		
		return boardDao.selectNotice(vo);
	}

	@Override
	public int selectBoardListCount(BoardVo vo) {
		int resultCnt = boardDao.selectBoardListCount(vo);		
		return resultCnt;
	}

	@Override
	public BoardVo viewBoard(BoardVo vo) {
		
		return boardDao.viewBoard(vo);
	}

	@Override
	public int addBoard(BoardVo vo) {
		
		return boardDao.addBoard(vo);
	}

	@Override
	public int updateBoard(BoardVo vo) {
		
		return boardDao.updateBoard(vo);
	}
	
	@Override
	public int updateViewCount(BoardVo vo) {
		
		return boardDao.updateViewCount(vo);
	}
	

	@Override
	public int deleteBoard(BoardVo vo) {
		
		return boardDao.deleteBoard(vo);
	}
}

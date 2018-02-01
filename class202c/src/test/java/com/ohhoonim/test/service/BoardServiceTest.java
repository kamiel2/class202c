package com.ohhoonim.test.service;

import static org.mockito.Mockito.when;

import java.util.ArrayList;
import java.util.List;

import org.mockito.runners.MockitoJUnitRunner;
import org.mockito.stubbing.Answer;

import com.ohhoonim.board.service.BoardService;
import com.ohhoonim.board.service.impl.BoardServiceImpl;
import com.ohhoonim.dao.BoardDao;
import com.ohhoonim.vo.BoardVo;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.*;


import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.invocation.InvocationOnMock;


@RunWith(MockitoJUnitRunner.class)
public class BoardServiceTest {
	
	@InjectMocks
	private BoardService service = new BoardServiceImpl();
	
	@Mock
	BoardDao dao;
	BoardVo vo;
	
	@Before
	public void setUp() {
		vo = new BoardVo();
	}
	
		
	@Test
	public void selectTest() {
		vo.setTitle("test");
		List<BoardVo> returnVo = dao.selectBoardList(vo);
		when(returnVo).thenAnswer(new Answer<List<BoardVo>> () {
			@Override
			public List<BoardVo> answer(InvocationOnMock invocation) throws Throwable {
				List<BoardVo> list = new ArrayList<BoardVo>();
				list.add(vo);
				return list;
			}
			
		});
		
		List<BoardVo> expected = service.selectBoardList(vo);
		assertThat(expected.get(0).getTitle(), is("test"));
	}
}



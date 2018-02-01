package com.ohhoonim.test.service;

import static org.mockito.Mockito.when;

import java.util.ArrayList;
import java.util.List;

import org.mockito.runners.MockitoJUnitRunner;
import org.mockito.stubbing.Answer;

import com.ohhoonim.board.service.BoardService;
import com.ohhoonim.board.service.impl.BoardServiceImpl;
import com.ohhoonim.dao.BoardDao;
import com.ohhoonim.dao.OrdrDao;
import com.ohhoonim.ordr.service.OrdrService;
import com.ohhoonim.ordr.service.impl.OrdrServiceImpl;
import com.ohhoonim.vo.BoardVo;
import com.ohhoonim.vo.OrdrVo;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.*;


import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.invocation.InvocationOnMock;


@RunWith(MockitoJUnitRunner.class)
public class OrdrServiceTest {
	
	@InjectMocks
	private OrdrService service = new OrdrServiceImpl();
	
	@Mock
	OrdrDao dao;
	
	OrdrVo vo;
	
	@Before
	public void setUp() {
		vo = new OrdrVo();
	}
	
	@Test
	public void putCartTest() {
		vo.setProductId("B010200001");
		vo.setAmnt("200");
		
		when(dao.hasCart(vo)).thenReturn(1);
		when(dao.updateCart(vo)).thenReturn(1);
	
		int result = service.putCart(vo);
		
		assertThat(result, is(1));
	}
	@Test
	public void putCartTest2() {
		vo.setProductId("B010200001");
		vo.setAmnt("200");
		
		when(dao.hasCart(vo)).thenReturn(0);
		when(dao.putCart(vo)).thenReturn(1);
		
		int result = service.putCart(vo);
		
		assertThat(result, is(1));
	}
		
	@Test
	public void finalOrdrTest() {
		
		OrdrVo vo = new OrdrVo();
		vo.setAmnt("1");
		vo.setProductId("A010100029");

		service.finalOrdr(vo);
	}
	
}



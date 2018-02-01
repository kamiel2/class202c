package com.ohhoonim.test.controller;


import static org.mockito.Matchers.anyObject;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.ArrayList;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import com.ohhoonim.board.service.BoardService;
import com.ohhoonim.board.web.BoardController;
import com.ohhoonim.vo.BoardVo;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:**/applicationContext.xml")
@WebAppConfiguration
public class BoardControllerTest {
	
	private MockMvc mockMvc;
	
	@Mock
	private BoardService boardService;
	
	@InjectMocks
	private BoardController controller = new BoardController();

	@Before
	public void setUp() {
		MockitoAnnotations.initMocks(this);
		mockMvc = MockMvcBuilders.standaloneSetup(controller).build();
	}
	
	@Test
	public void listTest() throws Exception {
		
		List<BoardVo> returnList = new ArrayList<BoardVo>();
		when(boardService.selectBoardList((BoardVo)anyObject())).thenReturn(returnList);
		
		mockMvc.perform(get("/board/board.do"))
				.andExpect(status().isOk())
				.andExpect(model().attributeExists("resultList"))
				.andExpect(model().attributeExists("paging"));
				//.andExpect(model().attributeExists("name"));
	}

}



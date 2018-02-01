package com.ohhoonim.test.dao;

import static org.hamcrest.CoreMatchers.*;
import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.ohhoonim.dao.BoardDao;
import com.ohhoonim.vo.BoardVo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:**/applicationContext.xml")
@TransactionConfiguration(defaultRollback=false)
@Transactional(value="txManager")
public class BoardDaoTest {
	@Resource(name = "boardDao")
	private BoardDao dao;
	
	private BoardVo vo;
	
	@Before
	public void setUp() {
		vo = new BoardVo();
	}
	
	
	@Test
	public void boardListTest() {
		vo.setTitle("");
		
		List<BoardVo> resultList = dao.selectBoardList(vo);
		
		int size = resultList.size();
		
		assertThat(size, is(0));		
	}		
		
		
	

}

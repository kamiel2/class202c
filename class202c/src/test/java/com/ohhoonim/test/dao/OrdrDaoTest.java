package com.ohhoonim.test.dao;

import static org.hamcrest.CoreMatchers.*;
import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.ohhoonim.dao.BoardDao;
import com.ohhoonim.dao.OrdrDao;
import com.ohhoonim.vo.BoardVo;
import com.ohhoonim.vo.OrdrVo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:**/applicationContext.xml")
@TransactionConfiguration(defaultRollback=true)
@Transactional(value="txManager")
public class OrdrDaoTest {
	@Resource(name = "ordrDao")
	private OrdrDao dao;
	
	private OrdrVo vo;
	
	@Before
	public void setUp() {
		vo = new OrdrVo();
	}
	
	@Test
	public void cartTest() {
		vo.setProductId("A010100029");
		int resultCnt = dao.hasCart(vo);
		assertThat(resultCnt, is(1));
	}		
	@Test
	public void putCartTest() {
		vo.setProductId("B010200001");
		vo.setAmnt("200");
		int result = dao.putCart(vo);
		assertThat(result, is(1));
	}		
	@Test
	public void updateCartTest() {
		vo.setProductId("A010100029");
		vo.setAmnt("200");
		int result = dao.updateCart(vo);
		assertThat(result, is(1));
	}		
		
	@Ignore
	@Test
	public void inserOrdrTest() {
		int result = dao.insertOrdr(vo);
	}	
	
	@Test
	public void nextOrdrIdTest() {
		String result = dao.nextOrdrId();
		System.out.println(result);
	}		
	
		
	

}

package com.ohhoonim.test.controller;


import static org.mockito.Matchers.anyObject;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

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

import com.ohhoonim.category.service.CategoryService;
import com.ohhoonim.ordr.service.OrdrService;
import com.ohhoonim.ordr.web.OrdrController;
import com.ohhoonim.outgoing.service.OutgoingService;
import com.ohhoonim.product.service.ProductService;
import com.ohhoonim.vo.BoardVo;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:**/applicationContext.xml")
@WebAppConfiguration
public class OrdrControllerTest {
	
	private MockMvc mockMvc;
	
	@Mock private OutgoingService outgoingService;
	@Mock private OrdrService ordrService;
	@Mock private ProductService productService;
	@Mock private CategoryService ctgrService;
	
	@InjectMocks
	private OrdrController controller = new OrdrController();

	@Before
	public void setUp() {
		MockitoAnnotations.initMocks(this);
		mockMvc = MockMvcBuilders.standaloneSetup(controller).build();
	}
	
	/**
	 * 주문하기
	 * @throws Exception
	 */
	@Test
	public void finalOrdrTest() throws Exception {
		mockMvc.perform(post("/ordr/finalOrdr.do")
				.param("cartAmnt", "1", "212", "156")
				.param("productId", "A010100029", "A010100044", "A020200001"))
			.andExpect(status().is3xxRedirection())
			.andExpect(redirectedUrl("/ordr/order-004.do"));
	}

}



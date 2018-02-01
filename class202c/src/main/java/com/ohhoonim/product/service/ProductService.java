package com.ohhoonim.product.service;

import java.util.List;
import java.util.Map;

import com.ohhoonim.vo.ProductVo;
import com.ohhoonim.vo.PtnrVo;
import com.ohhoonim.vo.StockVo;

public interface ProductService {	
	List<ProductVo> selectProductList(ProductVo vo);
	//기본적인 검색및 리스트 쿼리
	//--부품id/부품이름/제조사id/제조사이름/재고/안전재고/부품단가/부품가격/대분류/중분류/소분류
	String insertProduct(ProductVo pvo, StockVo svo, PtnrVo ptnrVo);	
	String updateProduct(ProductVo pvo, StockVo svo, PtnrVo ptnrVo);	
	int deleteProduct(ProductVo vo);
	ProductVo productDetail(ProductVo vo);
	Map<String,String> productDetailMap(ProductVo vo);
	String pIdGenerator(ProductVo vo);
	public int productCounter(ProductVo vo);	
	boolean productDupChk(ProductVo vo);
	List<ProductVo> selectProductB(ProductVo pvo);	
}
package com.ohhoonim.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.ohhoonim.vo.ProductVo;

@Repository("productDao")
public class ProductDao extends Mapper{
	
	public int insertProduct(ProductVo vo) {
		//product 등록 쿼리
		
		return insert("insertProduct", vo);
	}
	
	public int insertStock(ProductVo vo) {
		//stock 등록 쿼리
		
		return insert("insertStock", vo);
	}

	public List<ProductVo> selectProduct(ProductVo vo) {
		//기본적인 검색및 리스트 쿼리
		//--부품id/부품이름/제조사id/제조사이름/재고/안전재고/부품단가/부품가격/대분류/중분류/소분류
		return selectList("selectProduct", vo);
	}
	
	public ProductVo productDetail(ProductVo vo) {
		//pid 로 제품 상세정보 조회 쿼리
		return selectOne("selectProduct", vo);
	}
	
	public Map<String,String> productDetailMap(ProductVo vo) {
		//pid 로 제품 상세정보 조회 쿼리 맵으로 받아본다.
		return selectOne("selectProductMap", vo);
	}
	
	public Map<String,String> purchaseAddDetail(ProductVo vo) {
		//purchase 등록 화면을 위한 값들
		return selectOne("purchaseAddDetail", vo);
	}
	
	public int productCounter(ProductVo vo) {
		//이건 count(0) 날리는 쿼리 vo 사용안하고 맵으로 받아보겠다.
		//productId 중복 체크할때도 이걸 사용한다.
		return selectOne("productCounter", vo);
	}	


	public int updateProduct(ProductVo vo) {

		return update("updateProduct", vo);
	}

	public int deleteProduct(ProductVo vo) {

		return delete("deleteProduct", vo);
	}
	
	public int updateCancelProduct(ProductVo vo) {

		return update("updateCancelProduct", vo);
	}

	///////////// 소매처 list 용
	
	public List<ProductVo> selectProductB(ProductVo vo) {
		return selectList("selectProductB", vo);
		
	} 
	
	
}
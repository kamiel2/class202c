package com.ohhoonim.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.ohhoonim.vo.ProductVo;
import com.ohhoonim.vo.StockVo;

@Repository("stockDao")
public class StockDao extends Mapper{
	
	public int insertStock(StockVo vo) {
		
		return insert("insertStock", vo);
	}

	public List<StockVo> selectStock(StockVo vo) {

		return selectList("selectStock", vo);
	}
	
	public List<StockVo> getTotal_getStock(StockVo vo) {
		
		return selectList("getTotal_getStock", vo);
	}
	
	public int updateStock(StockVo vo) {

		return update("updateStock", vo);
	}
	
	public int stockCounter(StockVo vo) {
		//이건 count(0) 날리는 쿼리 vo 사용안하고 맵으로 받아보겠다.
		//productId 중복 체크할때도 이걸 사용한다.
		return selectOne("stockCounter", vo);
	}
	
	public StockVo getAmnts(StockVo vo) {
		
		return selectOne("getAmnts", vo);
	}
}
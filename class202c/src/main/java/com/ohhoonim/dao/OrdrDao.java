package com.ohhoonim.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.ohhoonim.vo.OrdrVo;
import com.ohhoonim.vo.ProductVo;

import java.util.Map;

@Repository("ordrDao")
public class OrdrDao extends Mapper {
	public int insertOrdr(OrdrVo vo) {
		return insert("insertOrdr", vo);
	}

	public String nextOrdrId() {
		return selectOne("nextOrdrId");
	}

	public List<OrdrVo> selectOrdr(OrdrVo vo) {
		return selectList("selectOrdr", vo);
	}

	public OrdrVo itemDetail(OrdrVo vo) {
		return selectOne("itemDetail", vo);
	}

	public int updateOrdr(OrdrVo vo) {
		return update("updateOrdr", vo);
	}

	public int deleteOrdr(OrdrVo vo) {
		return delete("deleteOrdr", vo);
	}

	public int updateCancelOrdr(OrdrVo vo) {
		return update("updateCancelOrdr", vo);
	}

	public List<Map<String, Object>> selectOrdrList(OrdrVo vo) {
		return selectList("selectOrdrList", vo);
	}

	public List<Map<String, Object>> cart(OrdrVo vo) {
		return selectList("cart", vo);
	}

	public List<Map<String, Object>> selectOrdrOutgoingList(OrdrVo vo) {
		return selectList("selectOrdrOutgoingList", vo);
	}

	////////////////////////////////////////// start: cart
	public int putCart(OrdrVo vo) {
		return insert("putCart", vo);
	}

	public int updateCart(OrdrVo vo) {
		return update("updateCart", vo);
	}

	public int hasCart(OrdrVo vo) {
		return selectOne("hasCart", vo);
	}
	/////////////////////////////////////////// end: cart
	
	public List<Map<String, Object>> cartView(OrdrVo vo) {
		return selectList("cartView", vo);
	}

	public int delCart(OrdrVo vo) {
		return delete("delCart", vo);
	}

	public int AmntUpdate(OrdrVo vo) {
		
		return update("amntUpdate", vo);
		
	}

	public int delOrdr(OrdrVo vo) {
		
		return delete("delOrdr", vo);
	}
	
	public int ordrupdateConfirm(OrdrVo vo) {
		
		return update("ordrupdateConfirm", vo);
	}

	
	public List<Map<String, Object>> selectOrdr_short(OrdrVo vo) {
		// TODO Auto-generated method stub
		return selectList("selectOrdr_short", vo);
	}

	public Map<String, Object> getOrdrAmnt(OrdrVo ordrVo) {
		// TODO Auto-generated method stub
		return selectOne("getOrdrAmnt", ordrVo);
	}



}
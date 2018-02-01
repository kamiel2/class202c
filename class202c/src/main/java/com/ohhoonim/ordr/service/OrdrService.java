package com.ohhoonim.ordr.service;

import java.util.List;
import java.util.Map;

import com.ohhoonim.vo.OrdrVo;

public interface OrdrService {
	public int insertOrder(OrdrVo vo);
	public int updateOrdr(OrdrVo vo);
	public int deleteOrder(OrdrVo vo);
	public List<Map<String, Object>> selectOrdrList(OrdrVo vo);
	public List<OrdrVo> selectList(OrdrVo vo);
	public OrdrVo itemDetail(OrdrVo vo);
	public List<Map<String, Object>> cartList(OrdrVo vo);  // 제품 조회
	public List<Map<String, Object>> selectOrdrOutgoingList(OrdrVo vo);
	public int putCart(OrdrVo vo);                        // 카트에 넣을 때 필요한 vo
	public List<Map<String, Object>> cartView(OrdrVo vo);    // 실제 카트
	public int ordrDelCart(OrdrVo vo);
	public int ordrDelOrdr(OrdrVo vo);
	public void finalOrdr(OrdrVo vo);
	public String nextOrdrId();
	public int AmntUpdate(OrdrVo vo);
	public int ordrupdateConfirm(OrdrVo vo);
	public Map<String, Object> getOrdrAmnt(OrdrVo ordrVo);
	


}



package com.ohhoonim.ordr.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ohhoonim.dao.OrdrDao;
import com.ohhoonim.ordr.service.OrdrService;
import com.ohhoonim.vo.OrdrVo;

@Service("ordrService")
public class OrdrServiceImpl implements OrdrService {
	
	public static String ORDER_CONDITION_AWAITING_SHIPMENT = "1101"; //출고대기
	
	@Resource(name = "ordrDao")
	OrdrDao ordrDao;

	@Override
	public List<OrdrVo> selectList(OrdrVo vo) {
		return ordrDao.selectOrdr(vo);
	}

	@Override
	public int insertOrder(OrdrVo vo) {
		return 0;
	}

	

	@Override
	public int deleteOrder(OrdrVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public OrdrVo itemDetail(OrdrVo vo) {

		return ordrDao.itemDetail(vo);
	}

	@Override
	public List<Map<String, Object>> selectOrdrList(OrdrVo vo) {

		List<Map<String, Object>> list = ordrDao.selectOrdrList(vo);

		return list;
	}

	@Override
	public List<Map<String, Object>> cartList(OrdrVo ovo) {

		List<Map<String, Object>> cList = ordrDao.cart(ovo);

		return cList;
	}

	@Override
	public List<Map<String, Object>> selectOrdrOutgoingList(OrdrVo vo) {

		List<Map<String, Object>> list = ordrDao.selectOrdrOutgoingList(vo);

		return list;
	}

	@Override
	public int putCart(OrdrVo vo) {
		int result = 0;
		if(ordrDao.hasCart(vo) > 0) {
			result = ordrDao.updateCart(vo);
		} else {
			result = ordrDao.putCart(vo);
		}
		return result;
	}

	@Override
	public List<Map<String, Object>> cartView(OrdrVo vo) {

		List<Map<String, Object>> cartView = ordrDao.cartView(vo);

		return cartView;
	}

	@Override
	public int ordrDelCart(OrdrVo vo) {
		return ordrDao.delCart(vo);
	}
	
	@Override
	public String nextOrdrId() {
		return ordrDao.nextOrdrId();
	}
	
	@Override
	public void finalOrdr(OrdrVo vo) {
		vo.setUnitPrice("");
		vo.setAmntLo(vo.getAmnt());
		vo.setConfirmDate("");
		vo.setStatus(ORDER_CONDITION_AWAITING_SHIPMENT);
		vo.setCmnt("");

		ordrDao.insertOrdr(vo);
		ordrDao.delCart(vo);
	}

	@Override
	public int AmntUpdate(OrdrVo vo) {

		return ordrDao.AmntUpdate(vo);
	}

	@Override
	public int ordrDelOrdr(OrdrVo vo) {
		
		return ordrDao.delOrdr(vo);
	}
	
	@Override
	public int ordrupdateConfirm(OrdrVo vo) {
		
		
		return ordrDao.ordrupdateConfirm(vo);
		
	}

	@Override
	public Map<String, Object> getOrdrAmnt(OrdrVo ordrVo) {
		
		return ordrDao.getOrdrAmnt(ordrVo);
	}

	@Override
	public int updateOrdr(OrdrVo vo) {
		// TODO Auto-generated method stub
		return ordrDao.updateOrdr(vo);
	}

	

	
}
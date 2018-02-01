package com.ohhoonim.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.ohhoonim.vo.OutgoingVo;

@Repository("outgoingDao")
public class OutgoingDao extends Mapper{
	
	public int insertOutgoing(OutgoingVo vo) {
		
		return insert("insertOutgoing", vo);
	}

	public List<OutgoingVo> selectOutgoing(OutgoingVo vo) {

		return selectList("selectOutgoing", vo);
	}
	
	public int updateOutgoing(OutgoingVo vo) {

		return update("updateOutgoing", vo);
	}

	public int deleteOutgoing(OutgoingVo vo) {

		return delete("deleteOutgoing", vo);
	}
	
	public int updateCancelOutgoing(OutgoingVo vo) {

		return update("updateCancelOutgoing", vo);
	}

	public int ordroutgoingModify(OutgoingVo vo) {
		// TODO Auto-generated method stub
		return update("ordroutgoingModify", vo);
	}

	public Map<String,Object> getOutgoing(OutgoingVo outgoingvo) {
		
		selectOne("getOutgoing",outgoingvo);
		System.out.println("ordrId = " +outgoingvo.getOrdrId());
		System.out.println("amnt = " +outgoingvo.getAmnt());
		
		Map<String,Object> resultMap = new HashMap();
		
		resultMap.put("ordrId", outgoingvo.getOrdrId());
		resultMap.put("amnt", outgoingvo.getAmnt());
		
		return resultMap;
	}

	public int outgoingCounter(OutgoingVo vo) {
		// TODO Auto-generated method stub
		return selectOne("outgoingCounter", vo);
	}

}
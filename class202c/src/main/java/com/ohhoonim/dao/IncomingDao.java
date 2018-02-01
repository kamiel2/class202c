package com.ohhoonim.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.ohhoonim.vo.IncomingVo;

@Repository("incomingDao")
public class IncomingDao extends Mapper{
	
	public int insertIncoming(IncomingVo vo) {
		
		return insert("insertIncoming", vo);
	}

	public List<Map<String,String>> selectIncoming(IncomingVo vo) {

		return selectList("selectIncoming", vo);
	}
	public Map<String,String> incomingDetail_short(IncomingVo vo) {

		return selectOne("incomingDetail_short", vo);
	}
	
	public int updateIncoming(IncomingVo vo) {

		return update("updateIncoming", vo);
	}

	public int deleteIncoming(IncomingVo vo) {

		return delete("deleteIncoming", vo);
	}
	
	public int updateCancelIncoming(IncomingVo vo) {

		return update("updateCancelIncoming", vo);
	}
	public int incomingCounter(IncomingVo vo) {
		
		return selectOne("incomingCounter",vo);
	}	
	
	public IncomingVo getAmnt(IncomingVo vo) {

		return selectOne("getAmnt", vo);
	}

	

}
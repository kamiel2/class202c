package com.ohhoonim.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.ohhoonim.vo.PtnrVo;

@Repository("ptnrDao")
public class PtnrDao extends Mapper{
	
	public int insertPtnr(PtnrVo vo) {
		
		return insert("insertPtnr", vo);
	}

	public List<PtnrVo> ptnrList(PtnrVo vo) {

		return selectList("selectPtnr", vo);
	}
	
	public int updatePtnr(PtnrVo vo) {

		return update("updatePtnr", vo);
	}

	public int deletePtnr(PtnrVo vo) {

		return delete("deletePtnr", vo);
	}
	
	public int updateCancelPtnr(PtnrVo vo) {

		return update("updateCancelPtnr", vo);
	}

	public int ptnrAdd(PtnrVo vo) {
		// TODO Auto-generated method stub
		return insert("ptnrAdd",vo);
	}

	public Map<String, Object> getPtnr(PtnrVo vo) {
		
		return selectOne("getPtnr",vo);
	}

	public int ptnrModify(PtnrVo vo) {
		// TODO Auto-generated method stub
		return update("ptnrModify",vo);
	}
	
	//유경식 ptnr 작성파트	
	public List<PtnrVo> ptnrSearch (PtnrVo vo){
		
		return selectList("ptnrSearch", vo); 
	}
	
	public int ptnrCounter(PtnrVo vo) {
		//ptnrid 로 count(0)리턴

		return selectOne("ptnrCounter", vo);
	}

	public int ptnrCounter1(PtnrVo vo) {
		// TODO Auto-generated method stub
		return selectOne("ptnrCounter1", vo);
	}
	
}
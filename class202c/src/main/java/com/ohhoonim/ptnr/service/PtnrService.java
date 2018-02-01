package com.ohhoonim.ptnr.service;

import java.util.List;
import java.util.Map;

import com.ohhoonim.vo.PtnrVo;

public interface PtnrService {
	public int insertPtnr(PtnrVo vo);
	public List<PtnrVo> ptnrList(PtnrVo vo);
	public int updatePtnr(PtnrVo vo);
	public int deletePtnr(PtnrVo vo);
	public int ptnrAdd(PtnrVo vo);
	public Map<String, Object> getPtnr(PtnrVo vo);
	public int ptnrModify(PtnrVo vo);
	
	//유경식 작성
	List<PtnrVo> ptnrSearch(PtnrVo vo);
	boolean ptnrDupChk(PtnrVo vo);
	public int ptnrCounter(PtnrVo vo);
}
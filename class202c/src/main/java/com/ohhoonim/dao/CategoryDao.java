package com.ohhoonim.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.ohhoonim.vo.CategoryVo;

@Repository("categoryDao")
public class CategoryDao extends Mapper {
	
	public List<CategoryVo> selectCtgrIdNm(CategoryVo vo) {

		return selectList ("selectCtgrIdNm", vo);
	}
	
	public int insertCtgr(CategoryVo vo) {
		
		return insert("insertCtgr", vo);
	}

	public int updateCtgr(CategoryVo vo) {

		return update("updateCtgr", vo);
	}
	
	public int deleteCtgr(CategoryVo vo) {

		return delete("deleteCtgr", vo);
	}

	public int ctgrCounter(CategoryVo vo) {
		
		return selectOne("ctgrCounter", vo);
	}
	
	public int ctgrNmDupChk(CategoryVo vo) {
		
		return selectOne("ctgrNmDupChk", vo);
	}
	
	public int ctgrIdDupChk(CategoryVo vo) {
		
		return selectOne("ctgrIdDupChk", vo);
	}
	
}

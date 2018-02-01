package com.ohhoonim.category.service;

import java.util.List;

import com.ohhoonim.vo.CategoryVo;


public interface CategoryService {
	public List<CategoryVo> selectCtgrIdNm(CategoryVo vo);
	public int insertCtgr(CategoryVo vo);
	public int updateCtgr(CategoryVo vo);
	public int deleteCtgr(CategoryVo vo);
	public int ctgrCounter(CategoryVo vo);
	public boolean ctgrNmDupChk(CategoryVo vo);
	public boolean ctgrIdDupChk(CategoryVo vo);
	public String ctgrIdGenerator(CategoryVo vo);
}

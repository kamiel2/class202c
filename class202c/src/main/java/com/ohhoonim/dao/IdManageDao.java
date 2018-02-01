package com.ohhoonim.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.ohhoonim.vo.IdManageVo;

@Repository("idManageDao")
public class IdManageDao extends Mapper {
	
	public List<IdManageVo> selectIdManageList(IdManageVo vo) {

		return selectList ("selectIdManageList", vo);
	}
	
	public int insertIdManage(IdManageVo vo) {
		
		return insert("insertIdManage", vo);
	}

	public int updateIdManage(IdManageVo vo) {

		return update("updateIdManage", vo);
	}
	
	public int deleteIdManage(IdManageVo vo) {

		return delete("deleteIdManage", vo);
	}
	
}

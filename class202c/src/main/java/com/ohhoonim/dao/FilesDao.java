package com.ohhoonim.dao;

import org.springframework.stereotype.Repository;

import com.ohhoonim.vo.FilesVo;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;


@Repository("filesDao")
public class FilesDao extends EgovAbstractMapper{

	public FilesVo selectFiles(FilesVo vo) {
		return selectOne("selectFiles", vo);
	}
	
	public int addFiles(FilesVo vo) {
		return insert("addFiles", vo);
	}
	
	public int updateFiles(FilesVo vo) {
		return update("updateFiles", vo);
	}
	
	public int deleteFiles(FilesVo vo) {
		return delete("deleteFiles", vo);
	}

}

package com.ohhoonim.common.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ohhoonim.common.service.FilesService;
import com.ohhoonim.dao.FilesDao;
import com.ohhoonim.vo.FilesVo;

@Service("filesService")
public class FilesServiceImpl implements FilesService {

	@Resource(name="filesDao")
	FilesDao dao;
	
	public FilesVo selectFiles(FilesVo vo) {
		return dao.selectFiles(vo);
	}

	public int addFiles(FilesVo vo) {
		return dao.addFiles(vo);
	}

	public int updateFiles(FilesVo vo) {
		return dao.updateFiles(vo);
	}

	public int deleteFiles(FilesVo vo) {
		return dao.deleteFiles(vo);
	}

}

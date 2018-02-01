package com.ohhoonim.common.service;

import com.ohhoonim.vo.FilesVo;

public interface FilesService {
	public FilesVo selectFiles(FilesVo vo);
	public int addFiles(FilesVo vo);
	public int updateFiles(FilesVo vo);
	public int deleteFiles(FilesVo vo);
}

package com.ohhoonim.idManage.service;

import com.ohhoonim.vo.IdManageVo;

public interface IdManageService {
	public int insertIdManage(IdManageVo vo);
	public int selectIdManage(IdManageVo vo);
	public int updateIdManage(IdManageVo vo);
	public int deleteIdManage(IdManageVo vo);


}
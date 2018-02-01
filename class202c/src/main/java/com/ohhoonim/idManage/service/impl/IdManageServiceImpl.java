package com.ohhoonim.idManage.service.impl;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.ohhoonim.dao.IdManageDao;
import com.ohhoonim.idManage.service.IdManageService;
import com.ohhoonim.vo.IdManageVo;

@Service("idManageService")
public class IdManageServiceImpl implements IdManageService{
	@Resource(name="idManageDao")
	IdManageDao idManageDao;

	@Override
	public int insertIdManage(IdManageVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int selectIdManage(IdManageVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateIdManage(IdManageVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteIdManage(IdManageVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	

}

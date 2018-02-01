package com.ohhoonim.common.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ohhoonim.common.service.IdGenService;
import com.ohhoonim.dao.IdGenDao;

@Service("idGenService")
public class IdGenServiceImpl implements IdGenService {

	@Resource(name="idGenDao")
	IdGenDao idGenDao;
	
	@Override
	public String getNextId(String tableName) {
		String nextId = idGenDao.getNextId(tableName);
		
		idGenDao.updateNextId(tableName);
		
		return nextId;
	}

}

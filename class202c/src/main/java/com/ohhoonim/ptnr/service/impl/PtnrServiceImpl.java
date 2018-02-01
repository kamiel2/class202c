package com.ohhoonim.ptnr.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ohhoonim.dao.PtnrDao;
import com.ohhoonim.ptnr.service.PtnrService;
import com.ohhoonim.vo.PtnrVo;

@Service("ptnrService")
public class PtnrServiceImpl implements PtnrService{
	@Resource(name="ptnrDao")
	PtnrDao ptnrDao;

	@Override
	public int insertPtnr(PtnrVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<PtnrVo> ptnrList(PtnrVo vo) {
		List<PtnrVo> list = ptnrDao.ptnrList(vo);
		return list;
	}

	@Override
	public int updatePtnr(PtnrVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deletePtnr(PtnrVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int ptnrAdd(PtnrVo vo) {
		// TODO Auto-generated method stub
		return ptnrDao.ptnrAdd(vo);
	}

	@Override
	public Map<String, Object> getPtnr(PtnrVo vo) {
		
		Map<String,Object> resultVo = ptnrDao.getPtnr(vo);
		
		return resultVo;
	}

	@Override
	public int ptnrModify(PtnrVo vo) {
		// TODO Auto-generated method stub
		return ptnrDao.ptnrModify(vo);
	}
	
	@Override
	public List<PtnrVo> ptnrSearch(PtnrVo vo) {
		
		return ptnrDao.ptnrSearch(vo);
	}

	@Override
	public boolean ptnrDupChk(PtnrVo vo) {
		//DB에 없다면 True 아니면 False
		int counter = ptnrDao.ptnrCounter(vo);

		if (counter == 0) {
			return true;

		} else {
			return false;
		}

	}

	@Override
	public int ptnrCounter(PtnrVo vo) {
		// TODO Auto-generated method stub
		return ptnrDao.ptnrCounter1(vo);
	}
}

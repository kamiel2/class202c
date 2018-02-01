package com.ohhoonim.category.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.ohhoonim.category.service.CategoryService;
import com.ohhoonim.dao.CategoryDao;
import com.ohhoonim.vo.CategoryVo;
import com.ohhoonim.common.Code999;

@Service("categoryService")
public class CategoryServiceImpl implements CategoryService {
	private static final Logger LOGGER = Logger.getLogger(CategoryService.class);
	@Resource(name = "categoryDao")
	CategoryDao ctgrDao;

	@Override
	public List<CategoryVo> selectCtgrIdNm(CategoryVo vo) {
		return ctgrDao.selectCtgrIdNm(vo);
	}

	@Override
	public int insertCtgr(CategoryVo vo) {

		return ctgrDao.insertCtgr(vo);
	}

	@Override
	public int updateCtgr(CategoryVo vo) {
		return ctgrDao.updateCtgr(vo);
	}

	@Override
	public int deleteCtgr(CategoryVo vo) {
		return ctgrDao.deleteCtgr(vo);
	}

	@Override
	public int ctgrCounter(CategoryVo vo) {

		return ctgrDao.ctgrCounter(vo);
	}

	@Override
	public boolean ctgrNmDupChk(CategoryVo vo) {

		LOGGER.debug("들어온 ctgrNm값" + vo.getCtgrNm());
		LOGGER.debug("들어온 ctgrLvl값" + vo.getCtgrLvl());

		int counter = ctgrDao.ctgrNmDupChk(vo);

		// 존재 하지않을때 true
		if (counter == 0) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public String ctgrIdGenerator(CategoryVo vo) {

		String ctgrLvl = vo.getCtgrLvl();
		String ctgrParent = vo.getCtgrParent();
		String returnString = "중복된 카테고리 이름입니다.";
		LOGGER.debug("ctgrIdGenerator 서비스 진입");

		if (ctgrNmDupChk(vo) == true) {
			LOGGER.debug("이름 중복체크완료 생성시작");
			String counter = "";
			StringBuffer ctgrId = new StringBuffer();
			
			if(ctgrLvl.equals(Code999.CATEGORY_1ST)) {
				LOGGER.debug("ctgrLvl 은 " + ctgrLvl);
				vo.setCtgrParent(null);
				int counter2 = ctgrDao.ctgrCounter(vo) + 65;
				LOGGER.debug(counter2);
				char ctgr1st = (char) (counter2);
				ctgrId.append(ctgr1st);
				ctgrId.append("0000");
				returnString = ctgrId.toString();
				
			}else if(ctgrLvl.equals(Code999.CATEGORY_2ND)) {
				counter = String.format("%02d", ctgrDao.ctgrCounter(vo) + 1);
				ctgrId.append(ctgrParent.substring(0, 1));
				ctgrId.append(counter);
				ctgrId.append("00");
				returnString = ctgrId.toString();
				
			}else if(ctgrLvl.equals(Code999.CATEGORY_3RD)) {
				counter = String.format("%02d", ctgrDao.ctgrCounter(vo) + 1);
				ctgrId.append(ctgrParent.substring(0, 3));
				ctgrId.append(counter);
				returnString = ctgrId.toString();
				
			}else {
				returnString = "카테고리 레벨 에러. 관리자 문의.";
			}			

			LOGGER.debug("생성된 CTGRID :  " + returnString + " 해당 ctgrId pk 검증시작");

			if (returnString.length() == 5) {				
				vo.setCtgrId(returnString);
				if (ctgrIdDupChk(vo)) {
					LOGGER.debug("CTGRID [" + returnString + "] 검증완료");					
				}else {
					returnString = "ctgrId 생성오류.. 다시 시도해주세요..";
				}
			}

		}

		return returnString;
	}

	@Override
	public boolean ctgrIdDupChk(CategoryVo vo) {

		LOGGER.debug("들어온 ctgrLvl값" + vo.getCtgrLvl());

		CategoryVo vo2nd = new CategoryVo();
		vo2nd.setCtgrId(vo.getCtgrLvl());

		int counter = ctgrDao.ctgrIdDupChk(vo2nd);

		// 존재 하지않을때 true
		if (counter == 0) {
			return true;
		} else {
			return false;
		}
	}

}

package com.ohhoonim.outgoing.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.ohhoonim.dao.OrdrDao;
import com.ohhoonim.dao.OutgoingDao;
import com.ohhoonim.incoming.service.IncomingService;
import com.ohhoonim.ordr.service.OrdrService;
import com.ohhoonim.outgoing.service.OutgoingService;
import com.ohhoonim.vo.OrdrVo;
import com.ohhoonim.vo.OutgoingVo;

@Service("outgoingService")
public class OutgoingServiceImpl implements OutgoingService{
	private static final Logger LOGGER = Logger.getLogger(IncomingService.class);
	@Resource(name="outgoingDao")
	OutgoingDao outgoingDao;
	@Resource(name="ordrDao")
	OrdrDao ordrDao;
	@Resource(name="ordrService")
	OrdrService ordrService;

	@Override
	public int insertOutgoing(OutgoingVo vo) {

		int result = 0;
		String ordrId = vo.getOrdrId();
		String productId = vo.getProductId();
		
		OrdrVo ordrVo = new OrdrVo();
		ordrVo.setOrdrId(ordrId);
		ordrVo.setProductId(productId);
		
		LOGGER.debug("ordrId:"+ordrId);
		Map<String,Object> ordrAmnt = ordrService.getOrdrAmnt(ordrVo);
		
		System.out.println("amnt="+vo.getAmnt());
		System.out.println("amntLo="+ordrAmnt.get("amntLo"));
		
		int amnt = Integer.parseInt(vo.getAmnt());
		int amntLo = Integer.parseInt(ordrAmnt.get("amntLo").toString());
		
		System.out.println("////////////////////////");
		System.out.println("amnt="+amnt);
		System.out.println("amntLo="+amntLo);
		
		/*
		if (amntLo == 0) {
			
			return 2;
			
		}else if(amnt>amntLo) {
			
			return 3;
			
		}else {
		*/
		int count = outgoingCounter(vo);
		vo.setCount(String.valueOf(count+1));
		
		outgoingDao.insertOutgoing(vo);
		
			if(amntLo == amnt) {
				//출고완료
				amntLo = 0;
				ordrVo.setStatus("1303");
				result = 1;
			}else {
				//출고중
				amntLo = amntLo - amnt;
				ordrVo.setStatus("1302");
			}
		ordrVo.setAmntLo(String.valueOf(amntLo));
		ordrService.updateOrdr(ordrVo);
		
		//출고수량 만큼 재고수량에서 빼고  총합에서 수량*단위가격을 뺀다.
		//}
		return result;
	}
	
	@Override
	public int outgoingCounter(OutgoingVo vo) {
		// TODO Auto-generated method stub
		return outgoingDao.outgoingCounter(vo);
	}

	@Override
	public List<OutgoingVo> selectOutgoing(OutgoingVo vo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateOutgoing(OutgoingVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteOutgoing(OutgoingVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int ordroutgoingModify(OutgoingVo vo) {
		// TODO Auto-generated method stub
		return outgoingDao.ordroutgoingModify(vo);
	}

	@Override
	public Map<String, Object> getOutgoing(OutgoingVo outgoingvo) {
		
		Map<String,Object> resultVo = outgoingDao.getOutgoing(outgoingvo);
		
		return resultVo;
	}

	

	@Override
	public List<Map<String, Object>> ogAddViewList(OrdrVo vo) {
		List<Map<String,Object>> list = ordrDao.selectOrdr_short(vo);
		
		return list;
	}

	
	

}

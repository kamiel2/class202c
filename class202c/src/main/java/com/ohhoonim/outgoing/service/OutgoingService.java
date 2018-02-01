package com.ohhoonim.outgoing.service;

import java.util.List;
import java.util.Map;

import com.ohhoonim.vo.OrdrVo;
import com.ohhoonim.vo.OutgoingVo;

public interface OutgoingService {
	public int insertOutgoing(OutgoingVo vo);
	public List<OutgoingVo> selectOutgoing(OutgoingVo vo);
	public int updateOutgoing(OutgoingVo vo);
	public int deleteOutgoing(OutgoingVo vo);
	public int ordroutgoingModify(OutgoingVo vo);
	public Map<String, Object> getOutgoing(OutgoingVo outgoingvo);
	public List<Map<String, Object>> ogAddViewList(OrdrVo vo);
	int outgoingCounter(OutgoingVo vo);


}
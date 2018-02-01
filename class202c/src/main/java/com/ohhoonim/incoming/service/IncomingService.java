package com.ohhoonim.incoming.service;

import java.util.List;
import java.util.Map;

import com.ohhoonim.vo.IncomingVo;
import com.ohhoonim.vo.PurchaseVo;

public interface IncomingService {
	public String insertIncoming(IncomingVo vo);
	public List<Map<String,String>> selectIncoming(IncomingVo vo);
	public Map<String,String> icAddView(PurchaseVo vo);
	public Map<String,String> icModifyView(IncomingVo vo);
	public String updateIncoming(IncomingVo vo);
	public int deleteIncoming(IncomingVo vo);
	public int incomingCounter(IncomingVo vo);

	
}
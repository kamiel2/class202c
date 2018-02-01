package com.ohhoonim.stock.service;

import java.util.List;

import com.ohhoonim.vo.StockVo;

public interface StockService {
	public List<StockVo> selectStockList(StockVo vo);
	public List<StockVo> getTotal_getStock(StockVo vo);
	public int insertStock(StockVo vo);
	public int updateStock(StockVo vo);
	public int deleteStock(StockVo vo);
	boolean stockDupChk(StockVo svo);
	boolean stockChk(String productId, String sold_amnt);


}

package com.ohhoonim.stock.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.ohhoonim.dao.StockDao;
import com.ohhoonim.incoming.service.IncomingService;
import com.ohhoonim.stock.service.StockService;
import com.ohhoonim.vo.StockVo;

@Service("stockService")
public class StockServiceImpl implements StockService {
	private static final Logger LOGGER = Logger.getLogger(StockService.class);
	@Resource(name = "stockDao")
	StockDao stockDao;

	@Override
	public List<StockVo> selectStockList(StockVo vo) {
		
		return stockDao.selectStock(vo);
	}

	@Override
	public int insertStock(StockVo vo) {
		LOGGER.debug("//////////////////// getProductId : "+ vo.getProductId() + " ////////////////////");
		LOGGER.debug("//////////////////// getStock : "+ vo.getStock() + " ////////////////////");
		LOGGER.debug("//////////////////// getUnitPrice : "+ vo.getUnitPrice() + " ////////////////////");		
		LOGGER.debug("//////////////////// getTotal : "+ vo.getTotal() + " ////////////////////");		
		LOGGER.debug("//////////////////// getSoldAmnt : "+ vo.getSoldAmnt() + " ////////////////////");		

		return stockDao.insertStock(vo);
	}

	@Override
	public int updateStock(StockVo vo) {
		// 재고 업데이트
		return stockDao.updateStock(vo);
	}

	@Override
	public int deleteStock(StockVo vo) {

		return 0;
	}

	@Override
	public boolean stockDupChk(StockVo vo) {
		// DB에 없다면 True 아니면 False
		// 아마 사용할일이 거의 없지 않을까.. stock 테이블은 product 테이블과 연결되어있다..
		int counter = stockDao.stockCounter(vo);

		if (counter == 0) {
			return true;

		} else {
			return false;
		}

	}

	@Override
	public List<StockVo> getTotal_getStock(StockVo vo) {		
		
		return stockDao.getTotal_getStock(vo);
	}

	@Override
	public boolean stockChk(String productId, String sold_amnt) {
		StockVo svo = new StockVo();
		svo.setProductId(productId);
		svo = stockDao.getAmnts(svo);
		
		int locked_stock = Integer.parseInt(svo.getSafetyStock())+Integer.parseInt(svo.getSoldAmnt())+Integer.parseInt(sold_amnt);
		
		if(Integer.parseInt(svo.getStock())>=locked_stock) {
			
			return true;
		}
		return false;
	}


}

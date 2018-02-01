package com.ohhoonim.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.ohhoonim.vo.PurchaseVo;

@Repository("purchaseDao")
public class PurchaseDao extends Mapper {
	
	public List<HashMap<String,String>> selectPurchase(PurchaseVo vo) {

		return selectList ("selectPurchase", vo);
	}
	
	public HashMap<String,String> selectOnePurchase_short(PurchaseVo vo) {
		
		return selectOne ("selectOnePurchase_short",vo);
	}
	
	public int insertPurchase(PurchaseVo vo) {
		
		return insert("insertPurchase", vo);
	}

	public int updatePurchase(PurchaseVo vo) {

		return update("updatePurchase", vo);
	}
	
	public int deletePurchase(PurchaseVo vo) {

		return delete("deletePurchase", vo);
	}
	
	public int purchaseIdCounter(PurchaseVo vo) {
		
		return selectOne("purchaseIdCounter", vo);
	}
	
	public PurchaseVo Purchase_getAmnt_getSum(PurchaseVo vo){
		
		return selectOne("Purchase_getAmnt_getSum", vo);
	}
	

	
}

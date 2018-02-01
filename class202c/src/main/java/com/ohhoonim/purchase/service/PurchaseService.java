package com.ohhoonim.purchase.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ohhoonim.vo.ProductVo;
import com.ohhoonim.vo.PurchaseVo;

public interface PurchaseService {
	public List<HashMap<String,String>> selectPurchaseList(PurchaseVo vo);
	public Map<String,String> purchaseAddDetail(ProductVo vo);
	public int insertPurchase(PurchaseVo vo);
	public int updatePurchase(PurchaseVo vo);
	public int deletePurchase(PurchaseVo vo);
	public String purchaseIdGenrator(PurchaseVo vo);
	public PurchaseVo Purchase_getAmnt_getSum(PurchaseVo vo);
}

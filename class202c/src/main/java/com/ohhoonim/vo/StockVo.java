package com.ohhoonim.vo;

public class StockVo {
	private String productId;
	private String stock;
	private String safetyStock;
	private String unitPrice;
	private String total;
	private String soldAmnt;
	private String status;
	

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
	}
	public String getSoldAmnt() {
		return soldAmnt;
	}
	public void setSoldAmnt(String soldAmnt) {
		this.soldAmnt = soldAmnt;
	}
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public String getStock() {
		return stock;
	}
	public void setStock(String stock) {
		this.stock = stock;
	}
	public String getSafetyStock() {
		return safetyStock;
	}
	public void setSafetyStock(String safetyStock) {
		this.safetyStock = safetyStock;
	}
	public String getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}
	
	
	
}

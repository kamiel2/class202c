package com.ohhoonim.vo;

public class OrdrVo {
	private String ordrId;
	private String productId;
	private String productNm;
	private String ptnrId;
	private String ptnrNm;
	private String amnt;
	private String amntLo;
	private String ordrDate;
	private String confirmDate;
	private String status;
	private String comments;
	////////////////////////
	private String rstock;
	////////////////////////
	private String startDate;
	private String endDate;
	////////////////////////
	private String cartAmnt;
	private String cartId;
	private String sum;
	private String unitPrice;
	private String salesCost;
	private String cmnt;
	private String total;
	////////////////////////
	private String soldAmnt;
	
	
	
	public String getSoldAmnt() {
		return soldAmnt;
	}

	public void setSoldAmnt(String soldAmnt) {
		this.soldAmnt = soldAmnt;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}


	
	public String getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getSalesCost() {
		return salesCost;
	}

	public void setSalesCost(String salesCost) {
		this.salesCost = salesCost;
	}

	public String getCmnt() {
		return cmnt;
	}

	public void setCmnt(String cmnt) {
		this.cmnt = cmnt;
	}

	public String getCartId() {
		return cartId;
	}

	public void setCartId(String cartId) {
		this.cartId = cartId;
	}

	public String getCartAmnt() {
		return cartAmnt;
	}

	public void setCartAmnt(String cartAmnt) {
		this.cartAmnt = cartAmnt;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getProductNm() {
		return productNm;
	}

	public void setProductNm(String productNm) {
		this.productNm = productNm;
	}

	public String getPtnrNm() {
		return ptnrNm;
	}

	public void setPtnrNm(String ptnrNm) {
		this.ptnrNm = ptnrNm;
	}

	public String getRstock() {
		return rstock;
	}

	public void setRstock(String rstock) {
		this.rstock = rstock;
	}

	public String getOrdrId() {
		return ordrId;
	}

	public void setOrdrId(String ordrId) {
		this.ordrId = ordrId;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getPtnrId() {
		return ptnrId;
	}

	public void setPtnrId(String ptnrId) {
		this.ptnrId = ptnrId;
	}

	public String getAmnt() {
		return amnt;
	}

	public void setAmnt(String amnt) {
		this.amnt = amnt;
	}

	public String getAmntLo() {
		return amntLo;
	}

	public void setAmntLo(String amntLo) {
		this.amntLo = amntLo;
	}

	public String getOrdrDate() {
		return ordrDate;
	}

	public void setOrdrDate(String ordrDate) {
		this.ordrDate = ordrDate;
	}

	public String getConfirmDate() {
		return confirmDate;
	}

	public void setConfirmDate(String confirmDate) {
		this.confirmDate = confirmDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb = sb.append("ordrId      : ");
		sb = sb.append(ordrId);
		sb = sb.append("| productId   : ");
		sb = sb.append(productId);
		sb = sb.append("| ptnrId      : ");
		sb = sb.append(ptnrId);
		sb = sb.append("| amnt        : ");
		sb = sb.append(amnt);
		sb = sb.append("| amntLo      : ");
		sb = sb.append(amntLo);
		sb = sb.append("| ordrDate    : ");
		sb = sb.append(ordrDate);
		sb = sb.append("| confirmDate : ");
		sb = sb.append(confirmDate);
		sb = sb.append("| status      : ");
		sb = sb.append(status);
		sb = sb.append("| comments    : ");
		sb = sb.append(comments);
		return sb.toString();
	}

	public String getSum() {
		return sum;
	}

	public void setSum(String sum) {
		this.sum = sum;
	}

}

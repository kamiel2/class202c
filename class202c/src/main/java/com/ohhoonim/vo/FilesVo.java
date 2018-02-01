package com.ohhoonim.vo;

public class FilesVo {
	private String fileN;
	private String fileU;
	private String fileS;
	private String cType;
	private String link;


	
	public String getFileN() {
		return fileN;
	}
	public void setFileN(String fileN) {
		this.fileN = fileN;
	}
	public String getFileU() {
		return fileU;
	}
	public void setFileU(String fileU) {
		this.fileU = fileU;
	}
	public String getFileS() {
		return fileS;
	}
	public void setFileS(String fileS) {
		this.fileS = fileS;
	}
	public String getcType() {
		return cType;
	}
	public void setcType(String cType) {
		this.cType = cType;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	
	@Override
	public String toString() {
		return "FilesVo [ fileN=" + fileN + ", fileU=" + fileU + ", fileS=" + fileS + ", cType="
				+ cType + ", link=" + link + "]";
	}

}

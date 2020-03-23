package com.kh.kkiri.member.model.vo;

public class Attachment {

	private String fileOriginName;
	private String fileChangeName;
	private String filePath;
	
	
	public Attachment() {
		
	}


	public Attachment(String fileOriginName, String fileChangeName, String filePath) {
		super();
		this.fileOriginName = fileOriginName;
		this.fileChangeName = fileChangeName;
		this.filePath = filePath;
	}


	public String getFileOriginName() {
		return fileOriginName;
	}


	public void setFileOriginName(String fileOriginName) {
		this.fileOriginName = fileOriginName;
	}


	public String getFileChangeName() {
		return fileChangeName;
	}


	public void setFileChangeName(String fileChangeName) {
		this.fileChangeName = fileChangeName;
	}


	public String getFilePath() {
		return filePath;
	}


	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}


	@Override
	public String toString() {
		return "Attachment [fileOriginName=" + fileOriginName + ", fileChangeName=" + fileChangeName + ", filePath="
				+ filePath + "]";
	}
	
	
	
	
	
}

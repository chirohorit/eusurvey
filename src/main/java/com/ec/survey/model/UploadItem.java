package com.ec.survey.model;

import org.springframework.web.multipart.MultipartFile;

public class UploadItem {
	private String filename;
    private MultipartFile fileData;

    public String getFilename() {
            return filename;
    }

    public void setFilename(String filename) {
            this.filename = filename;
    }

    public MultipartFile getFileData() {
            return fileData;
    }

    public void setFileData(MultipartFile fileData) {
            this.fileData = fileData;
    }
}

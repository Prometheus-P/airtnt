package com.airtnt.airtnt.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class AjaxFile {
	List<MultipartFile> images;

	public List<MultipartFile> getImages() {
		return images;
	}

	public void setImages(List<MultipartFile> images) {
		this.images = images;
	}
}

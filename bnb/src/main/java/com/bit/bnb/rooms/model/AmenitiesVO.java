package com.bit.bnb.rooms.model;

public class AmenitiesVO {

	private int amenities_idx;
	private String amenities_details;

	public final int getAmenities_idx() {
		return amenities_idx;
	}

	public final void setAmenities_idx(int amenities_idx) {
		this.amenities_idx = amenities_idx;
	}

	public final String getAmenities_details() {
		return amenities_details;
	}

	public final void setAmenities_details(String amenities_details) {
		this.amenities_details = amenities_details;
	}

	@Override
	public String toString() {
		return "AmenitiesVO [amenities_idx=" + amenities_idx + ", amenities_details=" + amenities_details + "]";
	}

}

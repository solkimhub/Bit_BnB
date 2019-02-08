package com.bit.bnb.rooms.model;

public class RoomsVO {

	private int roomsId;
	private String hostId;
	private String details;
	private int avail_adults;
	private int avail_children;
	private int avail_infants;
	private int avail_bedroom;
	private int avail_bed;
	private int avail_bathroom;
	private String amenities;
	private String time_checkin;
	private String time_checkout;
	private int price_weekdays;
	private int price_weekend;
	private String address;
	private int disabled;

	public final int getRoomsId() {
		return roomsId;
	}

	public final void setRoomsId(int roomsId) {
		this.roomsId = roomsId;
	}

	public final String getHostId() {
		return hostId;
	}

	public final void setHostId(String hostId) {
		this.hostId = hostId;
	}

	public final String getDetails() {
		return details;
	}

	public final void setDetails(String details) {
		this.details = details;
	}

	public final int getAvail_adults() {
		return avail_adults;
	}

	public final void setAvail_adults(int avail_adults) {
		this.avail_adults = avail_adults;
	}

	public final int getAvail_children() {
		return avail_children;
	}

	public final void setAvail_children(int avail_children) {
		this.avail_children = avail_children;
	}

	public final int getAvail_infants() {
		return avail_infants;
	}

	public final void setAvail_infants(int avail_infants) {
		this.avail_infants = avail_infants;
	}

	public final int getAvail_bedroom() {
		return avail_bedroom;
	}

	public final void setAvail_bedroom(int avail_bedroom) {
		this.avail_bedroom = avail_bedroom;
	}

	public final int getAvail_bed() {
		return avail_bed;
	}

	public final void setAvail_bed(int avail_bed) {
		this.avail_bed = avail_bed;
	}

	public final int getAvail_bathroom() {
		return avail_bathroom;
	}

	public final void setAvail_bathroom(int avail_bathroom) {
		this.avail_bathroom = avail_bathroom;
	}

	public final String getAmenities() {
		return amenities;
	}

	public final void setAmenities(String amenities) {
		this.amenities = amenities;
	}

	public final String getTime_checkin() {
		return time_checkin;
	}

	public final void setTime_checkin(String time_checkin) {
		this.time_checkin = time_checkin;
	}

	public final String getTime_checkout() {
		return time_checkout;
	}

	public final void setTime_checkout(String time_checkout) {
		this.time_checkout = time_checkout;
	}

	public final int getPrice_weekdays() {
		return price_weekdays;
	}

	public final void setPrice_weekdays(int price_weekdays) {
		this.price_weekdays = price_weekdays;
	}

	public final int getPrice_weekend() {
		return price_weekend;
	}

	public final void setPrice_weekend(int price_weekend) {
		this.price_weekend = price_weekend;
	}

	public final String getAddress() {
		return address;
	}

	public final void setAddress(String address) {
		this.address = address;
	}

	public final int getDisabled() {
		return disabled;
	}

	public final void setDisabled(int disabled) {
		this.disabled = disabled;
	}

	@Override
	public String toString() {
		return "RoomsVO [roomsId=" + roomsId + ", hostId=" + hostId + ", details=" + details + ", avail_adults="
				+ avail_adults + ", avail_children=" + avail_children + ", avail_infants=" + avail_infants
				+ ", avail_bedroom=" + avail_bedroom + ", avail_bed=" + avail_bed + ", avail_bathroom=" + avail_bathroom
				+ ", amenities=" + amenities + ", time_checkin=" + time_checkin + ", time_checkout=" + time_checkout
				+ ", price_weekdays=" + price_weekdays + ", price_weekend=" + price_weekend + ", address=" + address
				+ ", disabled=" + disabled + "]";
	}

}

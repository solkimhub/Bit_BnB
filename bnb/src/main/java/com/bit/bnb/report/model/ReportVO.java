package com.bit.bnb.report.model;

public class ReportVO {
    private int reservationNum;
    private String reportContent;
    private String reportCk;
    private int totalCount;
    private Integer result;

    public Integer getResult() {
        return result;
    }

    public void setResult(Integer result) {
        this.result = result;
    }

    private String hostId;

    public String getHostId() {
        return hostId;
    }

    public void setHostId(String hostId) {
        this.hostId = hostId;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    public int getReservationNum() {
        return reservationNum;
    }

    public void setReservationNum(int reservationNum) {
        this.reservationNum = reservationNum;
    }

    public String getReportContent() {
        return reportContent;
    }

    public void setReportContent(String reportContent) {
        this.reportContent = reportContent;
    }

    public String getReportCk() {
        return reportCk;
    }

    public void setReportCk(String reportCk) {
        this.reportCk = reportCk;
    }

    @Override
    public String toString() {
        return "ReportVO{" +
                "reservationNum=" + reservationNum +
                ", reportContent='" + reportContent + '\'' +
                ", reportCk='" + reportCk + '\'' +
                ", totalCount=" + totalCount +
                ", result=" + result +
                ", hostId='" + hostId + '\'' +
                '}';
    }
}

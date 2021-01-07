//javabean 
package com.highradius.internship;
import java.util.Date;

public class OrderPojo {
	private Date orderDate;
	private String approvedBy;
	private Integer orderId;
	private String customerName;
	private Integer customerId;
	private Integer orderAmount;
	private String approvalStatus;
	private String notes;
	
	public String getApprovedBy() {
		return approvedBy;
	}

	public void setApprovedBy(String approvedBy) {
		if(approvedBy==null)
			approvedBy="";
		this.approvedBy = approvedBy;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public int getOrderAmount() {
		return orderAmount;
	}

	public void setOrderAmount(int orderAmount) {
		this.orderAmount = orderAmount;
	}

	public String getApprovalStatus() {
		return approvalStatus;
	}

	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		if(notes==null)
			notes="";
		this.notes = notes;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
}




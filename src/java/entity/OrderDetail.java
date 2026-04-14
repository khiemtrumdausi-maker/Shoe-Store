package entity;

public class OrderDetail {
    private int orderDetailID;
    private int orderID;
    private int variantID;
    private int quantity;
    private double unitPrice;

    public OrderDetail() {
    }

    public OrderDetail(int orderDetailID, int orderID, int variantID, int quantity, double unitPrice) {
        this.orderDetailID = orderDetailID;
        this.orderID = orderID;
        this.variantID = variantID;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    public int getOrderDetailID() {
        return orderDetailID;
    }

    public void setOrderDetailID(int orderDetailID) {
        this.orderDetailID = orderDetailID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getVariantID() {
        return variantID;
    }

    public void setVariantID(int variantID) {
        this.variantID = variantID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    @Override
    public String toString() {
        return "OrderDetail{" + "orderDetailID=" + orderDetailID + ", orderID=" + orderID + ", variantID=" + variantID + ", quantity=" + quantity + ", unitPrice=" + unitPrice + '}';
    }
}
package entity;

public class DashboardDTO {
    private double totalRevenue;
    private int totalOrders;
    private int totalCustomers;

    public DashboardDTO(double totalRevenue, int totalOrders, int totalCustomers) {
        this.totalRevenue = totalRevenue;
        this.totalOrders = totalOrders;
        this.totalCustomers = totalCustomers;
    }

    // Getter cho sếp gọi bên JSP
    public double getTotalRevenue() { return totalRevenue; }
    public int getTotalOrders() { return totalOrders; }
    public int getTotalCustomers() { return totalCustomers; }
}
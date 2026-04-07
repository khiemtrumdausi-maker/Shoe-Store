package entity;

public class Shoe {
    private int id;
    private String name;
    private String image;
    private double price;
    private double discountPrice;
    private String description;
    private int genderID;
    private int brandID;
    private int categoryID;

    public Shoe() {}

    public Shoe(int id, String name, String image, double price, double discountPrice, String description, int genderID, int brandID, int categoryID) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.price = price;
        this.discountPrice = discountPrice;
        this.description = description;
        this.genderID = genderID;
        this.brandID = brandID;
        this.categoryID = categoryID;
    }

    // Khiêm nhấn Alt + Insert -> Getter and Setter -> Chọn hết -> Generate

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(double discountPrice) {
        this.discountPrice = discountPrice;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getGenderID() {
        return genderID;
    }

    public void setGenderID(int genderID) {
        this.genderID = genderID;
    }

    public int getBrandID() {
        return brandID;
    }

    public void setBrandID(int brandID) {
        this.brandID = brandID;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }
    
    
}
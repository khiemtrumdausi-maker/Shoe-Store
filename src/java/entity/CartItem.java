package entity;

public class CartItem {
    private int cartId;
    private int variantId;
    private String shoeName;
    private String image;
    private int size;
    private double price;
    private int quantity;

    public CartItem() {
    }

    public CartItem(int cartId, int variantId, String shoeName, String image, int size, double price, int quantity) {
        this.cartId = cartId;
        this.variantId = variantId;
        this.shoeName = shoeName;
        this.image = image;
        this.size = size;
        this.price = price;
        this.quantity = quantity;
    }

    // --- GETTER & SETTER ---
    public int getCartId() { return cartId; }
    public void setCartId(int cartId) { this.cartId = cartId; }

    public int getVariantId() { return variantId; }
    public void setVariantId(int variantId) { this.variantId = variantId; }

    public String getShoeName() { return shoeName; }
    public void setShoeName(String shoeName) { this.shoeName = shoeName; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public int getSize() { return size; }
    public void setSize(int size) { this.size = size; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
}
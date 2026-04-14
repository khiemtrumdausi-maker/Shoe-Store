package entity;

public class Notification {
    private int notiId;
    private int userId;
    private String message;
    private boolean isRead;
    private String createdAt;

    public Notification() {}

    public Notification(int notiId, int userId, String message, boolean isRead, String createdAt) {
        this.notiId = notiId;
        this.userId = userId;
        this.message = message;
        this.isRead = isRead;
        this.createdAt = createdAt;
    }

    // Getter và Setter
    public int getNotiId() { return notiId; }
    public void setNotiId(int notiId) { this.notiId = notiId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public boolean isIsRead() { return isRead; }
    public void setIsRead(boolean isRead) { this.isRead = isRead; }
    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}
package entity;

public class UserSession {
    private String id;
    private String hoTen;
    private String role; // ADMIN, STAFF, CUSTOMER

    public UserSession() {}

    public UserSession(String id, String hoTen, String role) {
        this.id = id;
        this.hoTen = hoTen;
        this.role = role;
    }

    // Các hàm getter/setter thủ công để IDE nhận diện 100% không lo lỗi plugin
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}
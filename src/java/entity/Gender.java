package entity;

public class Gender {
    private int genderID;
    private String genderName;

    public Gender() {
    }

    public Gender(int genderID, String genderName) {
        this.genderID = genderID;
        this.genderName = genderName;
    }

    public int getGenderID() {
        return genderID;
    }

    public void setGenderID(int genderID) {
        this.genderID = genderID;
    }

    public String getGenderName() {
        return genderName;
    }

    public void setGenderName(String genderName) {
        this.genderName = genderName;
    }

    @Override
    public String toString() {
        return "Gender{" + "genderID=" + genderID + ", genderName=" + genderName + '}';
    }
}
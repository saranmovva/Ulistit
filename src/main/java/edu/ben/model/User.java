package edu.ben.model;

import java.io.File;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.text.SimpleDateFormat;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.annotations.Formula;
import org.springframework.transaction.annotation.Transactional;

@Entity(name = "user")
@Table(name = "user")
@Transactional
public class User {

    @Id
    @Column(name = "user_ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int userID;

    @Column(name = "first_name")
    @NotNull
    @Size(min = 2, max = 15, message = "First Name Must Be Between 2 and 15 Characters")
    private String firstName;

    @Column(name = "last_name")
    @NotNull
    @Size(min = 2, max = 15, message = "Last Name Must Be Between 2 and 15 Characters")
    private String lastName;

    @Column(unique = true, name = "username")
    @NotNull
    @Size(min = 6, max = 15, message = "First Name Must Be Between 6 and 15 Characters")
    private String username;

    @Column(name = "email")
    @Email
    @Size( message = "Invalid Email")
    private String email;

    @Column(unique = true, name = "phone_number")
    private String phoneNumber;

    @Column(unique = true, name = "school_email")
    @NotNull
    @Email(message = "Invalid School Email")
    @Size(message = "Invalid School Email")
    private String schoolEmail;

    @Column(name = "password")
    @NotNull
    @Size(min = 5, max = 20, message = "Password Must Be Between 6 and 20 Characters")
    private String password;

    @Transient
    private String passwordConfirm;

    @Column(name = "grade_level")
    @NotNull
    private int gradeLevel;

    @Transient
    private int securityLevel;

    @Column(name = "active")
    private int active;

    @Column(name = "login_attempts")
    private int loginAttempts;

    @Column(name = "date_modified")
    private Timestamp dateModified;

    @Column(name = "date_created")
    private Timestamp dateCreated;

    @Column(name = "locked")
    private int locked;

    @Column(name = "admin_level")
    private int adminLevel;

    @Column(name = "banned")
    private int banned;

    @Column(name = "logged_in")
    private int loggedIn;

    @Formula("(select avg(transaction.trans_rating) from transaction where transaction.trans_rating > 0 and transaction.seller_ID=user_ID)")
    @Column(name = "seller_rating")
    private Integer sellerRating;

    @Transient
    private ArrayList<String> status = new ArrayList<>();

    @OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
    private List<Image> profileImages;

    @OneToOne(fetch = FetchType.LAZY,
            cascade =  CascadeType.ALL,
            mappedBy = "user")
    private Tutorial tutorial;

    public User() {
    }

    public User(String firstName, String lastName, String username, String email, String schoolEmail, String password) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.username = username;
        this.email = email;
        this.schoolEmail = schoolEmail;
        this.password = password;
    }

    public User(String firstName, String lastName, String username, String email, String schoolEmail, String password,
                String passwordConfirm, int securityLevel) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.username = username;
        this.email = email;
        this.schoolEmail = schoolEmail;
        this.password = password;
        this.passwordConfirm = passwordConfirm;
        this.securityLevel = securityLevel;
    }

    public User(int userID, String firstName, String lastName, String username, String email, String schoolEmail,
                String password, String passwordConfirm, int securityLevel) {
        this.userID = userID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.username = username;
        this.email = email;
        this.schoolEmail = schoolEmail;
        this.password = password;
        this.passwordConfirm = passwordConfirm;
        this.securityLevel = securityLevel;
    }

    public Tutorial getTutorial() {
        return this.tutorial;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSchoolEmail() {
        return schoolEmail;
    }

    public void setSchoolEmail(String schoolEmail) {
        this.schoolEmail = schoolEmail;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordConfirm() {
        return passwordConfirm;
    }

    public void setPasswordConfirm(String passwordConfirm) {
        this.passwordConfirm = passwordConfirm;
    }

    public int getSecurity_level() {
        return securityLevel;
    }

    public void setSecurity_level(int securityLevel) {
        this.securityLevel = securityLevel;
    }

    public int getSecurityLevel() {
        return securityLevel;
    }

    public void setSecurityLevel(int securityLevel) {
        this.securityLevel = securityLevel;
    }

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }

    public int getLoginAttempts() {
        return loginAttempts;
    }

    public void setLoginAttempts(int loginAttempts) {
        this.loginAttempts = loginAttempts;
    }

    public void setAdmin(int i) {
        this.adminLevel = i;
    }

    public Timestamp getDateModified() {
        return dateModified;
    }

    public void setDateModified(Timestamp dateModified) {
        this.dateModified = dateModified;
    }

    public Timestamp getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Timestamp dateCreated) {
        this.dateCreated = dateCreated;
    }

    public int getLocked() {
        return locked;
    }

    public void setLocked(int locked) {
        this.locked = locked;
    }

    public int getAdminLevel() {
        return adminLevel;
    }

    public void setAdminLevel(int adminLevel) {
        this.adminLevel = adminLevel;
    }

    public Integer getSellerRating() {
        return sellerRating;
    }

    public void setSellerRating(Integer sellerRating) {
        this.sellerRating = sellerRating;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getFormattedPhoneNumber() {
        return "(" + phoneNumber.substring(0, 2) + ") " + phoneNumber.substring(3, 5) + "-" + phoneNumber.substring(6);
    }

    public int getBanned() {
        return banned;
    }

    public void setBanned(int banned) {
        this.banned = banned;
    }

    public int getGradeLevel() {
        return gradeLevel;
    }

    public void setGradeLevel(int gradeLevel) {
        this.gradeLevel = gradeLevel;
    }

    public List<Image> getProfileImages() {
        return profileImages;
    }

    public void setProfileImages(List<Image> profileImages) {
        this.profileImages = profileImages;
    }


    public String getTruncatedDate() {
        java.sql.Date date = new java.sql.Date(dateCreated.getTime());
        return new SimpleDateFormat("MM/dd/yyyy").format(date);
    }



    public ArrayList<String> getStatus() {
        return status;
    }

    public void setStatus(ArrayList<String> status) {
        this.status = status;
    }

    public void setTutorial(Tutorial tutorial) {
        this.tutorial = tutorial;
    }

    public String getMainImage(){
        for(int i =0; i < profileImages.size(); i++){
            if(profileImages.get(i).getMain() == 1){
                return getProfileImages().get(i).getImage_path() + File.separator + getProfileImages().get(i).getImage_name();
            }
        }
        return null;
    }

    public int getLoggedIn() {
        return loggedIn;
    }

    public void setLoggedIn(int loggedIn) {
        this.loggedIn = loggedIn;
    }
}

package edu.kh.project.member.model.dto;

public class KakaoUser {
    private String email;
    private String nickname;

    public KakaoUser() {}

    public KakaoUser(String email, String nickname) {
        this.email = email;
        this.nickname = nickname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    @Override
    public String toString() {
        return "KakaoUser [email=" + email + ", nickname=" + nickname + "]";
    }
}


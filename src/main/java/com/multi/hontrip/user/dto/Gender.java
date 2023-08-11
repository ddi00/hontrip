package com.multi.hontrip.user.dto;

public enum Gender{ //성별 - Oauth 마다 다름, db에 넣을 때 필요
    NONE("정보없음", 1),
    MALE("남성", 2),
    FEMALE("여성", 3);

    private final String description;
    private final int id;

    Gender(String description, int id) {
        this.description = description;
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public int getId() {
        return id;
    }

    // ID로부터 Gender 열거형 가져오는 메서드
    public static Gender fromId(int id) {
        for (Gender gender : values()) {
            if (gender.getId() == id) {
                return gender;
            }
        }
        return NONE; // 해당 id에 맞는 Gender 멤버를 찾지 못한 경우
    }

    // ID로부터 Gender 열거형의 description 가져오는 메서드
    public static String getDescriptionFromId(int id) {
        return fromId(id).getDescription();
    }
}

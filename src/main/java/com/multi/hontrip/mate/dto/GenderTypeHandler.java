package com.multi.hontrip.mate.dto;


import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedTypes;
import org.apache.ibatis.type.TypeHandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@MappedTypes(Gender.class)
public class GenderTypeHandler implements TypeHandler<Gender> {

    @Override
    public void setParameter(PreparedStatement ps, int i, Gender parameter, JdbcType jdbcType) throws SQLException {
        ps.setInt(i, parameter.getGenderNum());
    }

    @Override
    public Gender getResult(ResultSet rs, String columnName) throws SQLException {
        int genderNumber = rs.getInt(columnName);
        return getGenderNumber(genderNumber);
    }

    private Gender getGenderNumber(int genderNumber) {
        Gender gender = null;
        switch (genderNumber) {
            case 2:
                gender = Gender.MALE;
                break;
            case 3:
                gender = Gender.FEMALE;
                break;
            case 4:
                gender = Gender.ALLGENDER;
                break;
            case 1:
                gender = Gender.NONE;
        }
        return gender;
    }

    @Override
    public Gender getResult(ResultSet rs, int columnIndex) throws SQLException {
        int genderNumber = rs.getInt(columnIndex);
        return getGenderNumber(genderNumber);
    }

    @Override
    public Gender getResult(CallableStatement cs, int columnIndex) throws SQLException {
        int genderNumber = cs.getInt(columnIndex);
        return getGenderNumber(genderNumber);
    }
}

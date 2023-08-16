package com.multi.hontrip.mate.dto;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedTypes;
import org.apache.ibatis.type.TypeHandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@MappedTypes(AgeRange.class)
public class AgeRangeTypeHandler implements TypeHandler<AgeRange> {
    @Override
    public void setParameter(PreparedStatement ps, int i, AgeRange parameter, JdbcType jdbcType) throws SQLException {
        ps.setInt(i, parameter.getAgeRangeNum());
    }

    @Override
    public AgeRange getResult(ResultSet rs, String columnName) throws SQLException {
        int ageRangeNumber = rs.getInt(columnName);
        return getAgeRangeNumber(ageRangeNumber);
    }

    private AgeRange getAgeRangeNumber(int ageRangeNumber) {
        AgeRange ageRange = null;
        switch (ageRangeNumber) {
            case 0:
                ageRange = AgeRange.ALLAGE;
                break;
            case 1:
                ageRange = AgeRange.TEENAGER;
                break;
            case 2:
                ageRange = AgeRange.TWENTIES;
                break;
            case 3:
                ageRange = AgeRange.THIRTIES;
                break;
            case 4:
                ageRange = AgeRange.FORTIES;
                break;
            case 5:
                ageRange = AgeRange.FIFTIES;
                break;
            case 6:
                ageRange = AgeRange.SIXTIES;
                break;
            case 7:
                ageRange = AgeRange.SEVENTIES;
                break;
        }
        return ageRange;
    }

    @Override
    public AgeRange getResult(ResultSet rs, int columnIndex) throws SQLException {
        int ageRangeNumber = rs.getInt(columnIndex);
        return getAgeRangeNumber(ageRangeNumber);
    }

    @Override
    public AgeRange getResult(CallableStatement cs, int columnIndex) throws SQLException {
        int ageRangeNumber = cs.getInt(columnIndex);
        return getAgeRangeNumber(ageRangeNumber);
    }
}

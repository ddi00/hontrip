package com.multi.hontrip.mate.dto;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedTypes;
import org.apache.ibatis.type.TypeHandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@MappedTypes(Region.class)
public class RegionTypeHandler implements TypeHandler<Region> {
    @Override
    public void setParameter(PreparedStatement ps, int i, Region parameter, JdbcType jdbcType) throws SQLException {
        ps.setInt(i, parameter.getRegionNum());
    }

    @Override
    public Region getResult(ResultSet rs, String columnName) throws SQLException {
        int regionNumber = rs.getInt(columnName);
        return getRegionNumber(regionNumber);
    }

    private Region getRegionNumber(int regionNumber) {
        Region region = null;
        switch (regionNumber) {
            case 1:
                region = Region.SEOUL;
                break;
            case 2:
                region = Region.GANGWONDO;
                break;
            case 3:
                region = Region.JEJU;
                break;
            case 4:
                region = Region.BUSAN;
                break;
            case 5:
                region = Region.GYEONGGIDO;
                break;
            case 6:
                region = Region.INCHEON;
                break;
            case 7:
                region = Region.CHUNGCHEONGDO;
                break;
            case 8:
                region = Region.GYEONGSANGDO;
                break;
            case 9:
                region = Region.JEOLLADO;
                break;
            case 10:
                region = Region.ULLEUNGDO;
                break;
        }
        return region;
    }

    @Override
    public Region getResult(ResultSet rs, int columnIndex) throws SQLException {
        int regionNumber = rs.getInt(columnIndex);
        return getRegionNumber(regionNumber);
    }

    @Override
    public Region getResult(CallableStatement cs, int columnIndex) throws SQLException {
        int regionNumber = cs.getInt(columnIndex);
        return getRegionNumber(regionNumber);
    }
}

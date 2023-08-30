package com.multi.hontrip.plan.parser;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public class LocationConstants {
    public static final Map<String, Map<String, String>> COORDINATES = new HashMap<>();

    static {
        Map<String, String> gangnamgu = new HashMap<>();
        gangnamgu.put("lat", "37.4951");
        gangnamgu.put("long", "127.06278");
        COORDINATES.put("서울특별시/강남구", gangnamgu);

        Map<String, String> gangdonggu = new HashMap<>();
        gangdonggu.put("lat", "37.55274");
        gangdonggu.put("long", "127.14546");
        COORDINATES.put("서울특별시/강동구", gangdonggu);

        Map<String, String> gangbukgu = new HashMap<>();
        gangbukgu.put("lat", "37.6349");
        gangbukgu.put("long", "127.02015");
        COORDINATES.put("서울특별시/강북구", gangbukgu);

        Map<String, String> gangseogu = new HashMap<>();
        gangseogu.put("lat", "37.56227");
        gangseogu.put("long", "126.81622");
        COORDINATES.put("서울특별시/강서구", gangseogu);

        Map<String, String> kwanacgu = new HashMap<>();
        kwanacgu.put("lat", "37.47876");
        kwanacgu.put("long", "126.95235");
        COORDINATES.put("서울특별시/관악구", kwanacgu);

        Map<String, String> gwangjingu = new HashMap<>();
        gwangjingu.put("lat", "37.53913");
        gwangjingu.put("long", "127.08366");
        COORDINATES.put("서울특별시/광진구", gwangjingu);

        Map<String, String> gurogu = new HashMap<>();
        gurogu.put("lat", "37.49447");
        gurogu.put("long", "126.8502");
        COORDINATES.put("서울특별시/구로구", gurogu);

        Map<String, String> 금cheongu = new HashMap<>();
        금cheongu.put("lat", "37.47486");
        금cheongu.put("long", "126.89106");
        COORDINATES.put("서울특별시/금천구", 금cheongu);

        Map<String, String> nowongu = new HashMap<>();
        nowongu.put("lat", "37.66045");
        nowongu.put("long", "127.06718");
        COORDINATES.put("서울특별시/노원구", nowongu);

        Map<String, String> dobonggu = new HashMap<>();
        dobonggu.put("lat", "37.65066");
        dobonggu.put("long", "127.03011");
        COORDINATES.put("서울특별시/도봉구", dobonggu);

        Map<String, String> dongdaemungu = new HashMap<>();
        dongdaemungu.put("lat", "37.58189");
        dongdaemungu.put("long", "127.05408");
        COORDINATES.put("서울특별시/동대문구", dongdaemungu);

        Map<String, String> donggacgu = new HashMap<>();
        donggacgu.put("lat", "37.50056");
        donggacgu.put("long", "126.95149");
        COORDINATES.put("서울특별시/동작구", donggacgu);

        Map<String, String> mapogu = new HashMap<>();
        mapogu.put("lat", "37.55438");
        mapogu.put("long", "126.90926");
        COORDINATES.put("서울특별시/마포구", mapogu);

        Map<String, String> seodaemungu = new HashMap<>();
        seodaemungu.put("lat", "37.57809");
        seodaemungu.put("long", "126.93506");
        COORDINATES.put("서울특별시/서대문구", seodaemungu);

        Map<String, String> seochogu = new HashMap<>();
        seochogu.put("lat", "37.49447");
        seochogu.put("long", "127.01088");
        COORDINATES.put("서울특별시/서초구", seochogu);

        Map<String, String> seongdonggu = new HashMap<>();
        seongdonggu.put("lat", "37.54784");
        seongdonggu.put("long", "127.02461");
        COORDINATES.put("서울특별시/성동구", seongdonggu);

        Map<String, String> seongbukgu = new HashMap<>();
        seongbukgu.put("lat", "37.60267");
        seongbukgu.put("long", "127.01448");
        COORDINATES.put("서울특별시/성북구", seongbukgu);

        Map<String, String> songpagu = new HashMap<>();
        songpagu.put("lat", "37.5021");
        songpagu.put("long", "127.11113");
        COORDINATES.put("서울특별시/송파구", songpagu);

        Map<String, String> yangcheongu = new HashMap<>();
        yangcheongu.put("lat", "37.52056");
        yangcheongu.put("long", "126.87472");
        COORDINATES.put("서울특별시/양천구", yangcheongu);

        Map<String, String> yeongdeongpogu = new HashMap<>();
        yeongdeongpogu.put("lat", "37.52606");
        yeongdeongpogu.put("long", "126.90308");
        COORDINATES.put("서울특별시/영등포구", yeongdeongpogu);

        Map<String, String> yongsangu = new HashMap<>();
        yongsangu.put("lat", "37.53391");
        yongsangu.put("long", "126.9775");
        COORDINATES.put("서울특별시/용산구", yongsangu);

        Map<String, String> eunpyeonggu = new HashMap<>();
        eunpyeonggu.put("lat", "37.61846");
        eunpyeonggu.put("long", "126.9278");
        COORDINATES.put("서울특별시/은평구", eunpyeonggu);

        Map<String, String> jongrogu = new HashMap<>();
        jongrogu.put("lat", "37.5729");
        jongrogu.put("long", "126.97928");
        COORDINATES.put("서울특별시/종로구", jongrogu);

        Map<String, String> junggu = new HashMap<>();
        junggu.put("lat", "37.55986");
        junggu.put("long", "126.99398");
        COORDINATES.put("서울특별시/중구", junggu);

        Map<String, String> junglanggu = new HashMap<>();
        junglanggu.put("lat", "37.60199");
        junglanggu.put("long", "127.10461");
        COORDINATES.put("서울특별시/중랑구", junglanggu);

        Map<String, String> busangangseogu = new HashMap<>();
        busangangseogu.put("lat", "35.1593");
        busangangseogu.put("long", "128.933");
        COORDINATES.put("부산광역시/강서구", busangangseogu);

        Map<String, String> geamjeonggu = new HashMap<>();
        geamjeonggu.put("lat", "35.25863");
        geamjeonggu.put("long", "129.0901");
        COORDINATES.put("부산광역시/금정구", geamjeonggu);

        Map<String, String> gijanggun = new HashMap<>();
        gijanggun.put("lat", "35.29721");
        gijanggun.put("long", "129.20076");
        COORDINATES.put("부산광역시/기장군", gijanggun);

        Map<String, String> namgu = new HashMap<>();
        namgu.put("lat", "35.13648");
        namgu.put("long", "129.08266");
        COORDINATES.put("부산광역시/남구", namgu);

        Map<String, String> donggu = new HashMap<>();
        donggu.put("lat", "35.12468");
        donggu.put("long", "129.03432");
        COORDINATES.put("부산광역시/동구", donggu);

        Map<String, String> dongraegu = new HashMap<>();
        dongraegu.put("lat", "35.20447");
        dongraegu.put("long", "129.078");
        COORDINATES.put("부산광역시/동래구", dongraegu);

        Map<String, String> busanjingu = new HashMap<>();
        busanjingu.put("lat", "35.16293");
        busanjingu.put("long", "129.05133");
        COORDINATES.put("부산광역시/부산진구", busanjingu);

        Map<String, String> bukgu = new HashMap<>();
        bukgu.put("lat", "35.19724");
        bukgu.put("long", "128.99134");
        COORDINATES.put("부산광역시/북구", bukgu);

        Map<String, String> sasanggu = new HashMap<>();
        sasanggu.put("lat", "35.14479");
        sasanggu.put("long", "128.97986");
        COORDINATES.put("부산광역시/사상구", sasanggu);

        Map<String, String> sahagu = new HashMap<>();
        sahagu.put("lat", "35.08552");
        sahagu.put("long", "128.98725");
        COORDINATES.put("부산광역시/사하구", sahagu);

        Map<String, String> seogu = new HashMap<>();
        seogu.put("lat", "35.12529");
        seogu.put("long", "129.01946");
        COORDINATES.put("부산광역시/서구", seogu);

        Map<String, String> suyeonggu = new HashMap<>();
        suyeonggu.put("lat", "35.15627");
        suyeonggu.put("long", "129.11253");
        COORDINATES.put("부산광역시/수영구", suyeonggu);

        Map<String, String> yeaonjegu = new HashMap<>();
        yeaonjegu.put("lat", "35.18206");
        yeaonjegu.put("long", "129.08285");
        COORDINATES.put("부산광역시/연제구", yeaonjegu);

        Map<String, String> yeongdogu = new HashMap<>();
        yeongdogu.put("lat", "35.07849");
        yeongdogu.put("long", "129.06483");
        COORDINATES.put("부산광역시/영도구", yeongdogu);

        Map<String, String> busanjunggu = new HashMap<>();
        busanjunggu.put("lat", "35.10594");
        busanjunggu.put("long", "129.03331");
        COORDINATES.put("부산광역시/중구", busanjunggu);

        Map<String, String> heayundaegu = new HashMap<>();
        heayundaegu.put("lat", "35.16665");
        heayundaegu.put("long", "129.16792");
        COORDINATES.put("부산광역시/해운대구", heayundaegu);

        Map<String, String> ganghwagun = new HashMap<>();
        ganghwagun.put("lat", "37.74722");
        ganghwagun.put("long", "126.48556");
        COORDINATES.put("인천광역시/강화군", ganghwagun);

        Map<String, String> geayanggu = new HashMap<>();
        geayanggu.put("lat", "37.52306");
        geayanggu.put("long", "126.74472");
        COORDINATES.put("인천광역시/계양구", geayanggu);

        Map<String, String> innamgu = new HashMap<>();
        innamgu.put("lat", "37.46362");
        innamgu.put("long", "126.65");
        COORDINATES.put("인천광역시/남구", innamgu);

        Map<String, String> namdonggu = new HashMap<>();
        namdonggu.put("lat", "37.41831");
        namdonggu.put("long", "126.7184");
        COORDINATES.put("인천광역시/남동구", namdonggu);

        Map<String, String> indonggu = new HashMap<>();
        indonggu.put("lat", "37.48375");
        indonggu.put("long", "126.6369");
        COORDINATES.put("인천광역시/동구", indonggu);

        Map<String, String> bupyeonggu = new HashMap<>();
        bupyeonggu.put("lat", "37.4972");
        bupyeonggu.put("long", "126.71107");
        COORDINATES.put("인천광역시/부평구", bupyeonggu);

        Map<String, String> inseogu = new HashMap<>();
        inseogu.put("lat", "37.55233");
        inseogu.put("long", "126.65543");
        COORDINATES.put("인천광역시/서구", inseogu);

        Map<String, String> yeaonsugu = new HashMap<>();
        yeaonsugu.put("lat", "37.41911");
        yeaonsugu.put("long", "126.66489");
        COORDINATES.put("인천광역시/연수구", yeaonsugu);

        Map<String, String> yungjingun = new HashMap<>();
        yungjingun.put("lat", "37.23361");
        yungjingun.put("long", "126.12305");
        COORDINATES.put("인천광역시/옹진군", yungjingun);

        Map<String, String> injunggu = new HashMap<>();
        injunggu.put("lat", "37.47353");
        injunggu.put("long", "126.62151");
        COORDINATES.put("인천광역시/중구", injunggu);

        Map<String, String> deajunggu = new HashMap<>();
        deajunggu.put("lat", "35.86678");
        deajunggu.put("long", "128.59538");
        COORDINATES.put("대구광역시/중구", deajunggu);

        Map<String, String> deadonggu = new HashMap<>();
        deadonggu.put("lat", "35.88566");
        deadonggu.put("long", "128.63296");
        COORDINATES.put("대구광역시/동구", deadonggu);

        Map<String, String> deaseogu = new HashMap<>();
        deaseogu.put("lat", "35.87465");
        deaseogu.put("long", "128.55109");
        COORDINATES.put("대구광역시/서구", deaseogu);

        Map<String, String> daenamgu = new HashMap<>();
        daenamgu.put("lat", "35.84119");
        daenamgu.put("long", "128.588");
        COORDINATES.put("대구광역시/남구", daenamgu);

        Map<String, String> daebukgu = new HashMap<>();
        daebukgu.put("lat", "35.9");
        daebukgu.put("long", "128.59175");
        COORDINATES.put("대구광역시/북구", daebukgu);

        Map<String, String> suseonggu = new HashMap<>();
        suseonggu.put("lat", "35.85905");
        suseonggu.put("long", "128.62625");
        COORDINATES.put("대구광역시/수성구", suseonggu);

        Map<String, String> dalseogu = new HashMap<>();
        dalseogu.put("lat", "35.82569");
        dalseogu.put("long", "128.52403");
        COORDINATES.put("대구광역시/달서구", dalseogu);

        Map<String, String> dalseonggun = new HashMap<>();
        dalseonggun.put("lat", "35.77467");
        dalseonggun.put("long", "128.42955");
        COORDINATES.put("대구광역시/달성군", dalseonggun);

        Map<String, String> gwaungdonggu = new HashMap<>();
        gwaungdonggu.put("lat", "35.14592");
        gwaungdonggu.put("long", "126.9232");
        COORDINATES.put("광주광역시/동구", gwaungdonggu);

        Map<String, String> gwaungseogu = new HashMap<>();
        gwaungseogu.put("lat", "35.15248");
        gwaungseogu.put("long", "126.89106");
        COORDINATES.put("광주광역시/서구", gwaungseogu);

        Map<String, String> gwaungnamgu = new HashMap<>();
        gwaungnamgu.put("lat", "35.12159");
        gwaungnamgu.put("long", "126.90943");
        COORDINATES.put("광주광역시/남구", gwaungnamgu);

        Map<String, String> gwaungbukgu = new HashMap<>();
        gwaungbukgu.put("lat", "35.19232");
        gwaungbukgu.put("long", "126.92439");
        COORDINATES.put("광주광역시/북구", gwaungbukgu);

        Map<String, String> gwangsangu = new HashMap<>();
        gwangsangu.put("lat", "35.16158");
        gwangsangu.put("long", "126.8081");
        COORDINATES.put("광주광역시/광산구", gwangsangu);

        Map<String, String> daedonggu = new HashMap<>();
        daedonggu.put("lat", "36.32938");
        daedonggu.put("long", "127.44313");
        COORDINATES.put("대전광역시/동구", daedonggu);

        Map<String, String> daejunggu = new HashMap<>();
        daejunggu.put("lat", "36.28044");
        daejunggu.put("long", "127.41093");
        COORDINATES.put("대전광역시/중구", daejunggu);

        Map<String, String> daeseogu = new HashMap<>();
        daeseogu.put("lat", "36.28071");
        daeseogu.put("long", "127.34533");
        COORDINATES.put("대전광역시/서구", seogu);

        Map<String, String> useonggu = new HashMap<>();
        useonggu.put("lat", "36.36685");
        useonggu.put("long", "127.327");
        COORDINATES.put("대전광역시/유성구", useonggu);

        Map<String, String> daeduckgu = new HashMap<>();
        daeduckgu.put("lat", "36.39591");
        daeduckgu.put("long", "127.43437");
        COORDINATES.put("대전광역시/대덕구", daeduckgu);

        Map<String, String> yuljunggu = new HashMap<>();
        yuljunggu.put("lat", "35.5684");
        yuljunggu.put("long", "129.33226");
        COORDINATES.put("울산광역시/중구", yuljunggu);

        Map<String, String> yulnamgu = new HashMap<>();
        yulnamgu.put("lat", "35.54382");
        yulnamgu.put("long", "129.32917");
        COORDINATES.put("울산광역시/남구", yulnamgu);

        Map<String, String> yuldonggu = new HashMap<>();
        yuldonggu.put("lat", "35.5047");
        yuldonggu.put("long", "129.4186");
        COORDINATES.put("울산광역시/동구", yuldonggu);

        Map<String, String> yulbukgu = new HashMap<>();
        yulbukgu.put("lat", "35.58243");
        yulbukgu.put("long", "129.36049");
        COORDINATES.put("울산광역시/북구", yulbukgu);

        Map<String, String> uljugun = new HashMap<>();
        uljugun.put("lat", "35.56233");
        uljugun.put("long", "129.1269");
        COORDINATES.put("울산광역시/울주군", uljugun);

        Map<String, String> gapyeonggun = new HashMap<>();
        gapyeonggun.put("lat", "37.8308");
        gapyeonggun.put("long", "127.51522");
        COORDINATES.put("경기도/가평군", gapyeonggun);

        Map<String, String> goyangsi = new HashMap<>();
        goyangsi.put("lat", "37.65639");
        goyangsi.put("long", "126.835");
        COORDINATES.put("경기도/고양시", goyangsi);

        Map<String, String> guacheonsi = new HashMap<>();
        guacheonsi.put("lat", "37.43407");
        guacheonsi.put("long", "126.99989");
        COORDINATES.put("경기도/과천시", guacheonsi);

        Map<String, String> gwangmyeaongsi = new HashMap<>();
        gwangmyeaongsi.put("lat", "37.44435");
        gwangmyeaongsi.put("long", "126.86499");
        COORDINATES.put("경기도/광명시", gwangmyeaongsi);

        Map<String, String> gwangjusi = new HashMap<>();
        gwangjusi.put("lat", "35.16667");
        gwangjusi.put("long", "126.91667");
        COORDINATES.put("경기도/광주시", gwangjusi);

        Map<String, String> gurisi = new HashMap<>();
        gurisi.put("lat", "37.5986");
        gurisi.put("long", "127.1394");
        COORDINATES.put("경기도/구리시", gurisi);

        Map<String, String> gunposi = new HashMap<>();
        gunposi.put("lat", "37.34261");
        gunposi.put("long", "126.92149");
        COORDINATES.put("경기도/군포시", gunposi);

        Map<String, String> kimposi = new HashMap<>();
        kimposi.put("lat", "37.59417");
        kimposi.put("long", "126.7425");
        COORDINATES.put("경기도/김포시", kimposi);

        Map<String, String> namyangjusi = new HashMap<>();
        namyangjusi.put("lat", "37.65217");
        namyangjusi.put("long", "127.2401");
        COORDINATES.put("경기도/남양주시", namyangjusi);

        Map<String, String> dongducheonsi = new HashMap<>();
        dongducheonsi.put("lat", "37.91889");
        dongducheonsi.put("long", "127.06897");
        COORDINATES.put("경기도/동두천시", dongducheonsi);

        Map<String, String> bucheonsi = new HashMap<>();
        bucheonsi.put("lat", "37.49889");
        bucheonsi.put("long", "126.78306");
        COORDINATES.put("경기도/부천시", bucheonsi);

        Map<String, String> seongnamsi = new HashMap<>();
        seongnamsi.put("lat", "37.41875");
        seongnamsi.put("long", "127.12877");
        COORDINATES.put("경기도/성남시", seongnamsi);

        Map<String, String> suwonsi = new HashMap<>();
        suwonsi.put("lat", "37.28586");
        suwonsi.put("long", "127.00993");
        COORDINATES.put("경기도/수원시", suwonsi);

        Map<String, String> siheungsi = new HashMap<>();
        siheungsi.put("lat", "37.39067");
        siheungsi.put("long", "126.7888");
        COORDINATES.put("경기도/시흥시", siheungsi);

        Map<String, String> ansansi = new HashMap<>();
        ansansi.put("lat", "37.31693");
        ansansi.put("long", "126.83048");
        COORDINATES.put("경기도/안산시", ansansi);

        Map<String, String> anseongsi = new HashMap<>();
        anseongsi.put("lat", "37.03789");
        anseongsi.put("long", "127.30057");
        COORDINATES.put("경기도/안성시", anseongsi);

        Map<String, String> anyangsi = new HashMap<>();
        anyangsi.put("lat", "37.3925");
        anyangsi.put("long", "126.92694");
        COORDINATES.put("경기도/안양시", anyangsi);

        Map<String, String> yangjusi = new HashMap<>();
        yangjusi.put("lat", "37.81732");
        yangjusi.put("long", "127.046");
        COORDINATES.put("경기도/양주시", yangjusi);

        Map<String, String> yangpyeonggun = new HashMap<>();
        yangpyeonggun.put("lat", "37.4888");
        yangpyeonggun.put("long", "127.49222");
        COORDINATES.put("경기도/양평군", yangpyeonggun);

        Map<String, String> 여주si = new HashMap<>();
        여주si.put("lat", "37.29562");
        여주si.put("long", "127.63668");
        COORDINATES.put("경기도/여주시", 여주si);

        Map<String, String> 연cheongun = new HashMap<>();
        연cheongun.put("lat", "38.09404");
        연cheongun.put("long", "127.07577");
        COORDINATES.put("경기도/연천군", 연cheongun);

        Map<String, String> 오sansi = new HashMap<>();
        오sansi.put("lat", "37.15222");
        오sansi.put("long", "127.07056");
        COORDINATES.put("경기도/오산시", 오sansi);

        Map<String, String> 용insi = new HashMap<>();
        용insi.put("lat", "37.23825");
        용insi.put("long", "127.17795");
        COORDINATES.put("경기도/용인시", 용insi);

        Map<String, String> 의왕si = new HashMap<>();
        의왕si.put("lat", "37.345");
        의왕si.put("long", "126.97575");
        COORDINATES.put("경기도/의왕시", 의왕si);

        Map<String, String> 의jeong부si = new HashMap<>();
        의jeong부si.put("lat", "37.73865");
        의jeong부si.put("long", "127.0477");
        COORDINATES.put("경기도/의정부시", 의jeong부si);

        Map<String, String> 이cheonsi = new HashMap<>();
        이cheonsi.put("lat", "37.27917");
        이cheonsi.put("long", "127.4425");
        COORDINATES.put("경기도/이천시", 이cheonsi);

        Map<String, String> 파주si = new HashMap<>();
        파주si.put("lat", "37.75952");
        파주si.put("long", "126.77772");
        COORDINATES.put("경기도/파주시", 파주si);

        Map<String, String> pyeong택si = new HashMap<>();
        pyeong택si.put("lat", "36.99472");
        pyeong택si.put("long", "127.08889");
        COORDINATES.put("경기도/평택시", pyeong택si);

        Map<String, String> pocheonsi = new HashMap<>();
        pocheonsi.put("lat", "37.8937");
        pocheonsi.put("long", "127.20028");
        COORDINATES.put("경기도/포천시", pocheonsi);

        Map<String, String> hanamsi = new HashMap<>();
        hanamsi.put("lat", "37.53895");
        hanamsi.put("long", "127.2125");
        COORDINATES.put("경기도/하남시", hanamsi);

        Map<String, String> hwaseongsi = new HashMap<>();
        hwaseongsi.put("lat", "37.20025");
        hwaseongsi.put("long", "126.82909");
        COORDINATES.put("경기도/화성시", hwaseongsi);

        Map<String, String> won주si = new HashMap<>();
        won주si.put("lat", "37.32104");
        won주si.put("long", "127.92132");
        COORDINATES.put("강원도/원주시", won주si);

        Map<String, String> 춘cheonsi = new HashMap<>();
        춘cheonsi.put("lat", "37.88048");
        춘cheonsi.put("long", "127.72776");
        COORDINATES.put("강원도/춘천시", 춘cheonsi);

        Map<String, String> gangneungsi = new HashMap<>();
        gangneungsi.put("lat", "37.7519");
        gangneungsi.put("long", "128.87825");
        COORDINATES.put("강원도/강릉시", gangneungsi);

        Map<String, String> dong해si = new HashMap<>();
        dong해si.put("lat", "37.52345");
        dong해si.put("long", "129.11357");
        COORDINATES.put("강원도/동해시", dong해si);

        Map<String, String> 속초si = new HashMap<>();
        속초si.put("lat", "38.20725");
        속초si.put("long", "128.59275");
        COORDINATES.put("강원도/속초시", 속초si);

        Map<String, String> 삼척si = new HashMap<>();
        삼척si.put("lat", "37.45013");
        삼척si.put("long", "129.16626");
        COORDINATES.put("강원도/삼척시", 삼척si);

        Map<String, String> 홍cheongun = new HashMap<>();
        홍cheongun.put("lat", "37.6918");
        홍cheongun.put("long", "127.8857");
        COORDINATES.put("강원도/홍천군", 홍cheongun);

        Map<String, String> 태백si = new HashMap<>();
        태백si.put("lat", "37.1652");
        태백si.put("long", "128.9857");
        COORDINATES.put("강원도/태백시", 태백si);

        Map<String, String> cheolwongun = new HashMap<>();
        cheolwongun.put("lat", "38.24391");
        cheolwongun.put("long", "127.44522");
        COORDINATES.put("강원도/철원군", cheolwongun);

        Map<String, String> hoengseonggun = new HashMap<>();
        hoengseonggun.put("lat", "37.48817");
        hoengseonggun.put("long", "127.9857");
        COORDINATES.put("강원도/횡성군", hoengseonggun);

        Map<String, String> pyeongchanggun = new HashMap<>();
        pyeongchanggun.put("lat", "37.37028");
        pyeongchanggun.put("long", "128.39306");
        COORDINATES.put("강원도/평창군", pyeongchanggun);

        Map<String, String> yeong월gun = new HashMap<>();
        yeong월gun.put("lat", "37.1833");
        yeong월gun.put("long", "128.4615");
        COORDINATES.put("강원도/영월군", yeong월gun);

        Map<String, String> jeong선gun = new HashMap<>();
        jeong선gun.put("lat", "37.38911");
        jeong선gun.put("long", "128.72995");
        COORDINATES.put("강원도/정선군", jeong선gun);

        Map<String, String> injegun = new HashMap<>();
        injegun.put("lat", "38.04416");
        injegun.put("long", "128.27876");
        COORDINATES.put("강원도/인제군", injegun);

        Map<String, String> 고seonggun = new HashMap<>();
        고seonggun.put("lat", "38.37945");
        고seonggun.put("long", "128.46755");
        COORDINATES.put("강원도/고성군", 고seonggun);

        Map<String, String> yangyanggun = new HashMap<>();
        yangyanggun.put("lat", "38.06215");
        yangyanggun.put("long", "128.61471");
        COORDINATES.put("강원도/양양군", yangyanggun);

        Map<String, String> hwacheongun = new HashMap<>();
        hwacheongun.put("lat", "38.14212");
        hwacheongun.put("long", "127.67615");
        COORDINATES.put("강원도/화천군", hwacheongun);

        Map<String, String> yanggugun = new HashMap<>();
        yanggugun.put("lat", "38.10583");
        yanggugun.put("long", "127.98944");
        COORDINATES.put("강원도/양구군", yanggugun);

        Map<String, String> cheong주si = new HashMap<>();
        cheong주si.put("lat", "36.63722");
        cheong주si.put("long", "127.48972");
        COORDINATES.put("충청북도/청주시", cheong주si);

        Map<String, String> 충주si = new HashMap<>();
        충주si.put("lat", "37.01791");
        충주si.put("long", "127.87713");
        COORDINATES.put("충청북도/충주시", 충주si);

        Map<String, String> jecheonsi = new HashMap<>();
        jecheonsi.put("lat", "37.06206");
        jecheonsi.put("long", "128.14065");
        COORDINATES.put("충청북도/제천시", jecheonsi);

        Map<String, String> 보은gun = new HashMap<>();
        보은gun.put("lat", "36.49489");
        보은gun.put("long", "127.72865");
        COORDINATES.put("충청북도/보은군", 보은gun);

        Map<String, String> 옥cheongun = new HashMap<>();
        옥cheongun.put("lat", "36.3012");
        옥cheongun.put("long", "127.568");
        COORDINATES.put("충청북도/옥천군", 옥cheongun);

        Map<String, String> yeongdonggun = new HashMap<>();
        yeongdonggun.put("lat", "36.1645");
        yeongdonggun.put("long", "127.79018");
        COORDINATES.put("충청북도/영동군", yeongdonggun);

        Map<String, String> 증pyeonggun = new HashMap<>();
        증pyeonggun.put("lat", "36.78377");
        증pyeonggun.put("long", "127.59858");
        COORDINATES.put("충청북도/증평군", 증pyeonggun);

        Map<String, String> jincheongun = new HashMap<>();
        jincheongun.put("lat", "36.85667");
        jincheongun.put("long", "127.44333");
        COORDINATES.put("충청북도/진천군", jincheongun);

        Map<String, String> 괴sangun = new HashMap<>();
        괴sangun.put("lat", "36.77179");
        괴sangun.put("long", "127.81426");
        COORDINATES.put("충청북도/괴산군", 괴sangun);

        Map<String, String> 음seonggun = new HashMap<>();
        음seonggun.put("lat", "36.92602");
        음seonggun.put("long", "127.6807");
        COORDINATES.put("충청북도/음성군", 음seonggun);

        Map<String, String> 단yanggun = new HashMap<>();
        단yanggun.put("lat", "36.98615");
        단yanggun.put("long", "128.36945");
        COORDINATES.put("충청북도/단양군", 단yanggun);

        Map<String, String> cheonansi = new HashMap<>();
        cheonansi.put("lat", "36.80488");
        cheonansi.put("long", "127.19431");
        COORDINATES.put("충청남도/천안시", cheonansi);

        Map<String, String> 공주si = new HashMap<>();
        공주si.put("lat", "36.45556");
        공주si.put("long", "127.12472");
        COORDINATES.put("충청남도/공주시", 공주si);

        Map<String, String> 보령si = new HashMap<>();
        보령si.put("lat", "36.35649");
        보령si.put("long", "126.59444");
        COORDINATES.put("충청남도/보령시", 보령si);

        Map<String, String> 아sansi = new HashMap<>();
        아sansi.put("lat", "36.78361");
        아sansi.put("long", "127.00417");
        COORDINATES.put("충청남도/아산시", 아sansi);

        Map<String, String> seosansi = new HashMap<>();
        seosansi.put("lat", "36.78518");
        seosansi.put("long", "126.46568");
        COORDINATES.put("충청남도/서산시", seosansi);

        Map<String, String> 논sansi = new HashMap<>();
        논sansi.put("lat", "36.19774");
        논sansi.put("long", "127.12143");
        COORDINATES.put("충청남도/논산시", 논sansi);

        Map<String, String> 계룡si = new HashMap<>();
        계룡si.put("lat", "36.29304");
        계룡si.put("long", "127.22575");
        COORDINATES.put("충청남도/계룡시", 계룡si);

        Map<String, String> 당jinsi = new HashMap<>();
        당jinsi.put("lat", "36.91667");
        당jinsi.put("long", "126.66667");
        COORDINATES.put("충청남도/당진시", 당jinsi);

        Map<String, String> 금sangun = new HashMap<>();
        금sangun.put("lat", "36.13381");
        금sangun.put("long", "127.48062");
        COORDINATES.put("충청남도/금산군", 금sangun);

        Map<String, String> 부여gun = new HashMap<>();
        부여gun.put("lat", "36.26257");
        부여gun.put("long", "126.85802");
        COORDINATES.put("충청남도/부여군", 부여gun);

        Map<String, String> seocheongun = new HashMap<>();
        seocheongun.put("lat", "36.1082");
        seocheongun.put("long", "126.69722");
        COORDINATES.put("충청남도/서천군", seocheongun);

        Map<String, String> cheongyanggun = new HashMap<>();
        cheongyanggun.put("lat", "36.44586");
        cheongyanggun.put("long", "126.84288");
        COORDINATES.put("충청남도/청양군", cheongyanggun);

        Map<String, String> 홍seonggun = new HashMap<>();
        홍seonggun.put("lat", "36.56705");
        홍seonggun.put("long", "126.62626");
        COORDINATES.put("충청남도/홍성군", 홍seonggun);

        Map<String, String> 예sangun = new HashMap<>();
        예sangun.put("lat", "36.68218");
        예sangun.put("long", "126.79592");
        COORDINATES.put("충청남도/예산군", 예sangun);

        Map<String, String> 태angun = new HashMap<>();
        태angun.put("lat", "36.70036");
        태angun.put("long", "126.28391");
        COORDINATES.put("충청남도/태안군", 태angun);

        Map<String, String> po항si = new HashMap<>();
        po항si.put("lat", "36.08333");
        po항si.put("long", "129.36667");
        COORDINATES.put("경상북도/포항시", po항si);

        Map<String, String> 경주si = new HashMap<>();
        경주si.put("lat", "35.84278");
        경주si.put("long", "129.21167");
        COORDINATES.put("경상북도/경주시", 경주si);

        Map<String, String> 김cheonsi = new HashMap<>();
        김cheonsi.put("lat", "36.14481");
        김cheonsi.put("long", "128.11157");
        COORDINATES.put("경상북도/김천시", 김cheonsi);

        Map<String, String> andongsi = new HashMap<>();
        andongsi.put("lat", "36.56636");
        andongsi.put("long", "128.72275");
        COORDINATES.put("경상북도/안동시", andongsi);

        Map<String, String> gu미si = new HashMap<>();
        gu미si.put("lat", "36.21009");
        gu미si.put("long", "128.35442");
        COORDINATES.put("경상북도/구미시", gu미si);

        Map<String, String> yeong주si = new HashMap<>();
        yeong주si.put("lat", "36.87459");
        yeong주si.put("long", "128.58631");
        COORDINATES.put("경상북도/영주시", yeong주si);

        Map<String, String> yeongcheonsi = new HashMap<>();
        yeongcheonsi.put("lat", "36");
        yeongcheonsi.put("long", "129");
        COORDINATES.put("경상북도/영천시", yeongcheonsi);

        Map<String, String> 상주si = new HashMap<>();
        상주si.put("lat", "36.41667");
        상주si.put("long", "128.16667");
        COORDINATES.put("경상북도/상주시", 상주si);

        Map<String, String> mun경si = new HashMap<>();
        mun경si.put("lat", "36.59458");
        mun경si.put("long", "128.19946");
        COORDINATES.put("경상북도/문경시", mun경si);

        Map<String, String> 경sansi = new HashMap<>();
        경sansi.put("lat", "35.83333");
        경sansi.put("long", "128.8");
        COORDINATES.put("경상북도/경산시", 경sansi);

        Map<String, String> gun위gun = new HashMap<>();
        gun위gun.put("lat", "36.16995");
        gun위gun.put("long", "128.64705");
        COORDINATES.put("경상북도/군위군", gun위gun);

        Map<String, String> 의seonggun = new HashMap<>();
        의seonggun.put("lat", "36.36122");
        의seonggun.put("long", "128.61517");
        COORDINATES.put("경상북도/의성군", 의seonggun);

        Map<String, String> cheongsonggun = new HashMap<>();
        cheongsonggun.put("lat", "36.43288");
        cheongsonggun.put("long", "129.05159");
        COORDINATES.put("경상북도/청송군", cheongsonggun);

        Map<String, String> yeongyanggun = new HashMap<>();
        yeongyanggun.put("lat", "36.69592");
        yeongyanggun.put("long", "129.14196");
        COORDINATES.put("경상북도/영양군", yeongyanggun);

        Map<String, String> yeong덕gun = new HashMap<>();
        yeong덕gun.put("lat", "36.48125");
        yeong덕gun.put("long", "129.31078");
        COORDINATES.put("경상북도/영덕군", yeong덕gun);

        Map<String, String> cheongdogun = new HashMap<>();
        cheongdogun.put("lat", "35.67166");
        cheongdogun.put("long", "128.78509");
        COORDINATES.put("경상북도/청도군", cheongdogun);

        Map<String, String> 고령gun = new HashMap<>();
        고령gun.put("lat", "35.74959");
        고령gun.put("long", "128.29707");
        COORDINATES.put("경상북도/고령군", 고령gun);

        Map<String, String> seong주gun = new HashMap<>();
        seong주gun.put("lat", "35.91888");
        seong주gun.put("long", "128.28838");
        COORDINATES.put("경상북도/성주군", seong주gun);

        Map<String, String> 칠gokgun = new HashMap<>();
        칠gokgun.put("lat", "36.01512");
        칠gokgun.put("long", "128.46138");
        COORDINATES.put("경상북도/칠곡군", 칠gokgun);

        Map<String, String> 예cheongun = new HashMap<>();
        예cheongun.put("lat", "36.65272");
        예cheongun.put("long", "128.43007");
        COORDINATES.put("경상북도/예천군", 예cheongun);

        Map<String, String> bonghwagun = new HashMap<>();
        bonghwagun.put("lat", "36.88951");
        bonghwagun.put("long", "128.73573");
        COORDINATES.put("경상북도/봉화군", bonghwagun);

        Map<String, String> uljingun = new HashMap<>();
        uljingun.put("lat", "36.91968");
        uljingun.put("long", "129.31966");
        COORDINATES.put("경상북도/울진군", uljingun);

        Map<String, String> ulneunggun = new HashMap<>();
        ulneunggun.put("lat", "37.50442");
        ulneunggun.put("long", "130.86084");
        COORDINATES.put("경상북도/울릉군", ulneunggun);

        Map<String, String> changwonsi = new HashMap<>();
        changwonsi.put("lat", "35.27533");
        changwonsi.put("long", "128.65152");
        COORDINATES.put("경상남도/창원시", changwonsi);

        Map<String, String> 김해si = new HashMap<>();
        김해si.put("lat", "35.25");
        김해si.put("long", "128.86667");
        COORDINATES.put("경상남도/김해시", 김해si);

        Map<String, String> jin주si = new HashMap<>();
        jin주si.put("lat", "35.20445");
        jin주si.put("long", "128.12408");
        COORDINATES.put("경상남도/진주시", jin주si);

        Map<String, String> yangsansi = new HashMap<>();
        yangsansi.put("lat", "35.39866");
        yangsansi.put("long", "129.03612");
        COORDINATES.put("경상남도/양산시", yangsansi);

        Map<String, String> 거jesi = new HashMap<>();
        거jesi.put("lat", "34.9");
        거jesi.put("long", "128.66666");
        COORDINATES.put("경상남도/거제시", 거jesi);

        Map<String, String> 통yeongsi = new HashMap<>();
        통yeongsi.put("lat", "34.8736");
        통yeongsi.put("long", "128.39709");
        COORDINATES.put("경상남도/통영시", 통yeongsi);

        Map<String, String> 사cheonsi = new HashMap<>();
        사cheonsi.put("lat", "35.00385");
        사cheonsi.put("long", "128.06857");
        COORDINATES.put("경상남도/사천시", 사cheonsi);

        Map<String, String> 밀yangsi = new HashMap<>();
        밀yangsi.put("lat", "35.49333");
        밀yangsi.put("long", "128.74889");
        COORDINATES.put("경상남도/밀양시", 밀yangsi);

        Map<String, String> 함angun = new HashMap<>();
        함angun.put("lat", "35.29117");
        함angun.put("long", "128.4297");
        COORDINATES.put("경상남도/함안군", 함angun);

        Map<String, String> 거changgun = new HashMap<>();
        거changgun.put("lat", "35.68735");
        거changgun.put("long", "127.91142");
        COORDINATES.put("경상남도/거창군", 거changgun);

        Map<String, String> chang녕gun = new HashMap<>();
        chang녕gun.put("lat", "35.50822");
        chang녕gun.put("long", "128.4902");
        COORDINATES.put("경상남도/창녕군", chang녕gun);

        Map<String, String> goseonggun = new HashMap<>();
        goseonggun.put("lat", "35.01478");
        goseonggun.put("long", "128.28244");
        COORDINATES.put("경상남도/고성군", goseonggun);

        Map<String, String> hadonggun = new HashMap<>();
        hadonggun.put("lat", "35.13628");
        hadonggun.put("long", "127.77291");
        COORDINATES.put("경상남도/하동군", hadonggun);

        Map<String, String> hapcheongun = new HashMap<>();
        hapcheongun.put("lat", "35.5741");
        hapcheongun.put("long", "128.13841");
        COORDINATES.put("경상남도/합천군", hapcheongun);

        Map<String, String> nam해gun = new HashMap<>();
        nam해gun.put("lat", "34.80433");
        nam해gun.put("long", "127.92708");
        COORDINATES.put("경상남도/남해군", nam해gun);

        Map<String, String> 함yanggun = new HashMap<>();
        함yanggun.put("lat", "35.55233");
        함yanggun.put("long", "127.71196");
        COORDINATES.put("경상남도/함양군", 함yanggun);

        Map<String, String> sancheonggun = new HashMap<>();
        sancheonggun.put("lat", "35.36625");
        sancheonggun.put("long", "127.87065");
        COORDINATES.put("경상남도/산청군", sancheonggun);

        Map<String, String> 의령gun = new HashMap<>();
        의령gun.put("lat", "35.3923");
        의령gun.put("long", "128.26917");
        COORDINATES.put("경상남도/의령군", 의령gun);

        Map<String, String> jeon주si = new HashMap<>();
        jeon주si.put("lat", "35.82194");
        jeon주si.put("long", "127.14889");
        COORDINATES.put("전라북도/전주시", jeon주si);

        Map<String, String> 익sansi = new HashMap<>();
        익sansi.put("lat", "35.94389");
        익sansi.put("long", "126.95444");
        COORDINATES.put("전라북도/익산시", 익sansi);

        Map<String, String> gunsansi = new HashMap<>();
        gunsansi.put("lat", "35.93583");
        gunsansi.put("long", "126.68338");
        COORDINATES.put("전라북도/군산시", gunsansi);

        Map<String, String> jeongeupsi = new HashMap<>();
        jeongeupsi.put("lat", "35.6");
        jeongeupsi.put("long", "126.91667");
        COORDINATES.put("전라북도/정읍시", jeongeupsi);

        Map<String, String> 완주gun = new HashMap<>();
        완주gun.put("lat", "35.84509");
        완주gun.put("long", "127.14752");
        COORDINATES.put("전라북도/완주군", 완주gun);

        Map<String, String> 김jesi = new HashMap<>();
        김jesi.put("lat", "35.80701");
        김jesi.put("long", "126.90755");
        COORDINATES.put("전라북도/김제시", 김jesi);

        Map<String, String> namwonsi = new HashMap<>();
        namwonsi.put("lat", "35.42966");
        namwonsi.put("long", "127.43208");
        COORDINATES.put("전라북도/남원시", namwonsi);

        Map<String, String> 고changgun = new HashMap<>();
        고changgun.put("lat", "35.43483");
        고changgun.put("long", "126.70047");
        COORDINATES.put("전라북도/고창군", 고changgun);

        Map<String, String> 부angun = new HashMap<>();
        부angun.put("lat", "35.7");
        부angun.put("long", "126.66667");
        COORDINATES.put("전라북도/부안군", 부angun);

        Map<String, String> 임실gun = new HashMap<>();
        임실gun.put("lat", "35.6066");
        임실gun.put("long", "127.2301");
        COORDINATES.put("전라북도/임실군", 임실gun);

        Map<String, String> soonchanggun = new HashMap<>();
        soonchanggun.put("lat", "35.41667");
        soonchanggun.put("long", "127.16667");
        COORDINATES.put("전라북도/순창군", soonchanggun);

        Map<String, String> jinangun = new HashMap<>();
        jinangun.put("lat", "35.8216");
        jinangun.put("long", "127.41183");
        COORDINATES.put("전라북도/진안군", jinangun);

        Map<String, String> 장sugun = new HashMap<>();
        장sugun.put("lat", "35.66667");
        장sugun.put("long", "127.53333");
        COORDINATES.put("전라북도/장수군", 장sugun);

        Map<String, String> 무주gun = new HashMap<>();
        무주gun.put("lat", "35.93172");
        무주gun.put("long", "127.71118");
        COORDINATES.put("전라북도/무주군", 무주gun);

        Map<String, String> 여susi = new HashMap<>();
        여susi.put("lat", "34.77647");
        여susi.put("long", "127.64253");
        COORDINATES.put("전라남도/여수시", 여susi);

        Map<String, String> sooncheonsi = new HashMap<>();
        sooncheonsi.put("lat", "34.98951");
        sooncheonsi.put("long", "127.39551");
        COORDINATES.put("전라남도/순천시", sooncheonsi);

        Map<String, String> 목posi = new HashMap<>();
        목posi.put("lat", "34.80826");
        목posi.put("long", "126.3942");
        COORDINATES.put("전라남도/목포시", 목posi);

        Map<String, String> gwangyangsi = new HashMap<>();
        gwangyangsi.put("lat", "35.02926");
        gwangyangsi.put("long", "127.64882");
        COORDINATES.put("전라남도/광양시", gwangyangsi);

        Map<String, String> 나주si = new HashMap<>();
        나주si.put("lat", "35.05683");
        나주si.put("long", "126.67362");
        COORDINATES.put("전라남도/나주시", 나주si);

        Map<String, String> 무angun = new HashMap<>();
        무angun.put("lat", "34.95642");
        무angun.put("long", "126.44041");
        COORDINATES.put("전라남도/무안군", 무angun);

        Map<String, String> 해namgun = new HashMap<>();
        해namgun.put("lat", "34.54047");
        해namgun.put("long", "126.5187");
        COORDINATES.put("전라남도/해남군", 해namgun);

        Map<String, String> 고heunggun = new HashMap<>();
        고heunggun.put("lat", "34.58333");
        고heunggun.put("long", "127.33333");
        COORDINATES.put("전라남도/고흥군", 고heunggun);

        Map<String, String> hwasoongun = new HashMap<>();
        hwasoongun.put("lat", "35.00843");
        hwasoongun.put("long", "127.02576");
        COORDINATES.put("전라남도/화순군", hwasoongun);

        Map<String, String> yeong암gun = new HashMap<>();
        yeong암gun.put("lat", "34.7979");
        yeong암gun.put("long", "126.62651");
        COORDINATES.put("전라남도/영암군", yeong암gun);

        Map<String, String> yeonggwanggun = new HashMap<>();
        yeonggwanggun.put("lat", "35.28711");
        yeonggwanggun.put("long", "126.43616");
        COORDINATES.put("전라남도/영광군", yeonggwanggun);

        Map<String, String> 완dogun = new HashMap<>();
        완dogun.put("lat", "34.31182");
        완dogun.put("long", "126.73845");
        COORDINATES.put("전라남도/완도군", 완dogun);

        Map<String, String> 담yanggun = new HashMap<>();
        담yanggun.put("lat", "35.33976");
        담yanggun.put("long", "126.99125");
        COORDINATES.put("전라남도/담양군", 담yanggun);

        Map<String, String> 장seonggun = new HashMap<>();
        장seonggun.put("lat", "35.32734");
        장seonggun.put("long", "126.76817");
        COORDINATES.put("전라남도/장성군", 장seonggun);

        Map<String, String> 보seonggun = new HashMap<>();
        보seonggun.put("lat", "34.81426");
        보seonggun.put("long", "127.15765");
        COORDINATES.put("전라남도/보성군", 보seonggun);

        Map<String, String> 신angun = new HashMap<>();
        신angun.put("lat", "34.8262");
        신angun.put("long", "126.10863");
        COORDINATES.put("전라남도/신안군", 신angun);

        Map<String, String> 장heunggun = new HashMap<>();
        장heunggun.put("lat", "34.66667");
        장heunggun.put("long", "126.91667");
        COORDINATES.put("전라남도/장흥군", 장heunggun);

        Map<String, String> gangjingun = new HashMap<>();
        gangjingun.put("lat", "34.61787");
        gangjingun.put("long", "126.76758");
        COORDINATES.put("전라남도/강진군", gangjingun);

        Map<String, String> 함pyeonggun = new HashMap<>();
        함pyeonggun.put("lat", "35.11641");
        함pyeonggun.put("long", "126.53221");
        COORDINATES.put("전라남도/함평군", 함pyeonggun);

        Map<String, String> jindogun = new HashMap<>();
        jindogun.put("lat", "34.41018");
        jindogun.put("long", "126.1688");
        COORDINATES.put("전라남도/진도군", jindogun);

        Map<String, String> gokseonggun = new HashMap<>();
        gokseonggun.put("lat", "35.21449");
        gokseonggun.put("long", "127.2628");
        COORDINATES.put("전라남도/곡성군", gokseonggun);

        Map<String, String> gu례gun = new HashMap<>();
        gu례gun.put("lat", "35.20944");
        gu례gun.put("long", "127.46444");
        COORDINATES.put("전라남도/구례군", gu례gun);

        Map<String, String> je주si = new HashMap<>();
        je주si.put("lat", "33.50972");
        je주si.put("long", "126.52194");
        COORDINATES.put("제주특별자치도/제주시", je주si);

        Map<String, String> seo귀posi = new HashMap<>();
        seo귀posi.put("lat", "33.29307");
        seo귀posi.put("long", "126.49748");
        COORDINATES.put("제주특별자치도/서귀포시", seo귀posi);

    }
}

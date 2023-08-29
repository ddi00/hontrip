package com.multi.hontrip.user.dto;

import junit.framework.TestCase;
import org.junit.Test;

public class PageDTOTest extends TestCase {

    @Test
    public void test(){ //페이징 테스트
        PageDTO pageDTO = new PageDTO(250, 3); // 1,2,3,4,5
        assertTrue(pageDTO.getBeginPage()==1);
        assertTrue(pageDTO.getEndPage()==5);
        assertTrue(pageDTO.isShowPrev()==false);
        assertTrue(pageDTO.isShowNext()==true);

        PageDTO pageDTO2 = new PageDTO(250, 6); // 4,5,6,7,8
        assertTrue(pageDTO2.getBeginPage()==4);
        assertTrue(pageDTO2.getEndPage()==8);
        assertTrue(pageDTO2.isShowPrev()==true);
        assertTrue(pageDTO2.isShowNext()==true);

        PageDTO pageDTO3 = new PageDTO(250, 25); // 21,22,23,24,25
        assertTrue(pageDTO3.getBeginPage()==21);
        assertTrue(pageDTO3.getEndPage()==25);
        assertTrue(pageDTO3.isShowPrev()==true);
        assertTrue(pageDTO3.isShowNext()==false);
    }
}
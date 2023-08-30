package com.multi.hontrip.record.service;

import com.multi.hontrip.record.dao.RecordDAO;
import com.multi.hontrip.record.dto.CreatePostDTO;
import com.multi.hontrip.record.dto.PostImgDTO;
import com.multi.hontrip.record.dto.LocationDTO;
import com.multi.hontrip.record.dto.PostInfoDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RecordService {

    private final RecordDAO recordDAO;
    private final ServletContext servletContext;
    private String relativePath = "resources/img/recordImg/"; // 파일 저장 루트

    // 단일 파일 업로드
    public long upLoadPost( MultipartFile file, CreatePostDTO createPostDTO) {
        String savedName = file.getOriginalFilename(); // file 원본 이름 저장
        String uploadPath=servletContext.getRealPath("/")+relativePath+savedName;
        File target = new File(uploadPath); //해당 주소에 이미지 저장
        try {
            file.transferTo(target);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        createPostDTO.setThumbnail(relativePath+savedName);
        recordDAO.insertPost(createPostDTO);
        return createPostDTO.getId();
    }

    // 게시물 상세페이지
    public PostInfoDTO selectPostInfo(long id) {
        return recordDAO.selectPost(id);
    }

    // 게시물 수정
    public long updatePostInfo(MultipartFile file,
                               CreatePostDTO createPostDTO) {

        String savedName = file.getOriginalFilename(); // file 원본 이름 저장
        String uploadPath=servletContext.getRealPath("/")+relativePath+savedName;
        File target = new File(uploadPath);
        try {
            file.transferTo(target);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        createPostDTO.setThumbnail(relativePath+savedName);
        recordDAO.updatePost(createPostDTO);
        return createPostDTO.getId();
    }

    // 게시물 삭제
    public void deletePostInfo(long id) {
        recordDAO.deletePost(id);
    }

    // 다중 파일 업로드 파일 저장
    public List<String> setMultifiles(MultipartFile[] multifiles) { // 다중 파일 업로드 파일 저장
        String uploadPath = servletContext.getRealPath("/");

        List<String> multifilesUrl = new ArrayList<>();

        for (MultipartFile file : multifiles) {
            if (!file.isEmpty()) {
                try {
                    // 파일 저장 로직
                    String filename = file.getOriginalFilename();
                    // 저장할 경로 설정
                    String savePath = uploadPath+relativePath+ filename;

                    // 파일을 저장
                    Files.copy(file.getInputStream(), Paths.get(savePath), StandardCopyOption.REPLACE_EXISTING);

                    // 파일의 URL을 리스트에 추가
                    multifilesUrl.add(relativePath+filename);
                } catch (IOException e) { // 파일 처리 중 에러가 발생한 경우 예외 처리
                    e.printStackTrace();
                }
            }
        }
        return multifilesUrl;
    }

    // 다중 파일 업로드 db저장
    public void imgUrlsInsert(List<String> imgUrls, long recordId) {
        PostImgDTO postImgDTO = new PostImgDTO();
        for(String imgUrl : imgUrls) {
            postImgDTO.setImgUrl(imgUrl);
            postImgDTO.setRecordId(recordId);
            recordDAO.insertImg(postImgDTO);
        }
    }

    public List<PostImgDTO> selectPostImg(long recordId) {
        return recordDAO.selectImg(recordId);
    }

    public List<PostInfoDTO> getMyList(Long userId) {
        return recordDAO.getMyList(userId);
    }
    public List<PostInfoDTO> getListMyLocationClick(Long locationId, Long userId) {
        return recordDAO.getListMyLocationClick(locationId, userId);
    }
    public List<PostInfoDTO> getListMyLocationDrowDown(Long locationId, Long userId) {
        return recordDAO.getListMyLocationDrowDown(locationId, userId);
    }

    public List<LocationDTO> getMyMap(Long userId) {
        return recordDAO.getMyMap(userId);
    }

    public List<PostInfoDTO> getFeedList(int isVisible) {
        return recordDAO.getFeedList(isVisible);
    }


    public List<PostInfoDTO> getFeedListDropdownAll(String locationIdPattern) {
        return recordDAO.getFeedListDropdownAll(locationIdPattern);
    }

    public List<PostInfoDTO> getFeedListDropdown(String locationIdPattern, String locationIdSpecialId, String locationIdSpecialId2, String locationIdSpecialId3) {
        System.out.println("서비스단 확인 : " + locationIdPattern + locationIdSpecialId );
        return recordDAO.getFeedListDropdown(locationIdPattern, locationIdSpecialId, locationIdSpecialId2, locationIdSpecialId3);
    }

}

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
    private String relativePath="resources/img/recordImg/";

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

    public PostInfoDTO selectPostInfo(long id) {
        return recordDAO.selectPost(id);
    }


    public long updatePostInfo(MultipartFile file, CreatePostDTO createPostDTO) {

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

    public void deletePostInfo(long id) {
        recordDAO.deletePost(id);
    }

    public List<String> setMultifiles(MultipartFile[] multifiles) {
        String uploadPath=servletContext.getRealPath("/");

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

    public List<CreatePostDTO> getMyList() {
        return recordDAO.getMyList();
    }
    public List<CreatePostDTO> getListMyLocation(int locationId) {
        return recordDAO.getListMyLocation(locationId);
    }
    public List<CreatePostDTO> getListMyLocation2(String locationCity) {
        return recordDAO.getListMyLocation2(locationCity);
    }
    public List<PostInfoDTO> getFeedList(int isVisible) {
        return recordDAO.getFeedList(isVisible);
    }
    public List<LocationDTO> getMyMap() {
        return recordDAO.getMyMap();
    }

}

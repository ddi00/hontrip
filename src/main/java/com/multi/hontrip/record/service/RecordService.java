package com.multi.hontrip.record.service;

import com.multi.hontrip.record.dao.RecordDAO;
import com.multi.hontrip.record.dto.*;
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
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class RecordService {

    private final RecordDAO recordDAO;
    private final ServletContext servletContext;
    private String relativePath = "resources/img/recordImg/"; // 파일 저장 루트

    // 단일 파일 업로드
    public long upLoadPost( MultipartFile file, CreatePostDTO createPostDTO) {
        String originalFileName = file.getOriginalFilename();

        // 파일 저장 루트와 UUID를 사용하여 파일 이름 고유성 보장
        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
        String uuid = UUID.randomUUID().toString();
        String savedName = uuid + extension;

        String uploadPath = servletContext.getRealPath("/")+relativePath+savedName;
        System.out.println(uploadPath);
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

    // 게시물 조회수 증가 +1
    public void incrementPostViews(long id) {
        recordDAO.incrementPostViews(id);
    }

    // 게시물 수정
    public long updatePostInfo(//MultipartFile file,
                               CreatePostDTO createPostDTO) {

//        String savedName = file.getOriginalFilename(); // file 원본 이름 저장
//        String uploadPath=servletContext.getRealPath("/")+relativePath+savedName;
//        File target = new File(uploadPath);
//        try {
//            file.transferTo(target);
//        } catch (IOException e) {
//            throw new RuntimeException(e);
//        }
//        createPostDTO.setThumbnail(relativePath+savedName);
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
                    String originalFilename = file.getOriginalFilename();

                    // UUID를 사용하여 파일 이름 고유성 보장
                    String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
                    String uuid = UUID.randomUUID().toString();
                    String savedName = uuid + extension;

                    // 저장할 경로 설정
                    String savePath = uploadPath + relativePath + savedName;

                    // 파일을 저장
                    Files.copy(file.getInputStream(), Paths.get(savePath), StandardCopyOption.REPLACE_EXISTING);

                    // 파일의 URL을 리스트에 추가
                    multifilesUrl.add(relativePath + savedName);
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

    // 좋아요순 게시물 탑 10
    public List<PostInfoDTO> likeTopTen() {
        return recordDAO.likeTopTen();
    }

    // 내 게시물
    public List<PostInfoDTO> getMyList(Long userId) {
        return recordDAO.getMyList(userId);
    }

    // 스크롤 내 게시물
    public List<PostInfoDTO> getMyListWithScroll(PostScrollDTO postScrollDTO) {
        return recordDAO.getMyListWithScroll(postScrollDTO);
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

    public List<PostInfoDTO> getFeedList() {
        return recordDAO.getFeedList();
    }

    public List<PostInfoDTO> getFeedListWithScroll(PostScrollDTO postScrollDTO) {
        return recordDAO.getFeedListWithScroll(postScrollDTO);
    }


    public List<PostInfoDTO> getFeedListLocationButtonsAll(String locationIdPattern) {
        return recordDAO.getFeedListLocationButtonsAll(locationIdPattern);
    }

    public List<PostInfoDTO> getFeedListLocationButtons(String locationIdPattern, String locationIdSpecialId, String locationIdSpecialId2, String locationIdSpecialId3) {
        return recordDAO.getFeedListLocationButtons(locationIdPattern, locationIdSpecialId, locationIdSpecialId2, locationIdSpecialId3);
    }

    public List<PostInfoDTO> getFeedListLike( ) {
        return recordDAO.getFeedListLike();
    }

}

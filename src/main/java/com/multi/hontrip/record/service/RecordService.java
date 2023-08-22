package com.multi.hontrip.record.service;

import com.multi.hontrip.record.dao.RecordDAO;
import com.multi.hontrip.record.dto.CreatePostDTO;
import com.multi.hontrip.record.dto.LocationDTO;
import com.multi.hontrip.record.dto.PostInfoDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RecordService {

    private final RecordDAO recordDAO;

    public long upLoadPost(String uploadPath, MultipartFile file, CreatePostDTO createPostDTO) {
        String savedName = file.getOriginalFilename(); // file 원본 이름 저장
        File target = new File(uploadPath + "/" + savedName);
        try {
            file.transferTo(target);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        createPostDTO.setThumbnail(savedName);
        recordDAO.insertPost(createPostDTO);
        return createPostDTO.getId();
    }

    public PostInfoDTO selectPostInfo(long id) {
        return recordDAO.selectPost(id);
    }


    public long updatePostInfo(String uploadPath, MultipartFile file, CreatePostDTO createPostDTO) {
        String savedName = file.getOriginalFilename(); // file 원본 이름 저장
        File target = new File(uploadPath + "/" + savedName);
        try {
            file.transferTo(target);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        createPostDTO.setThumbnail(savedName);
        recordDAO.updatePost(createPostDTO);
        return createPostDTO.getId();
    }

    public void deletePostInfo(long id) {
        recordDAO.deletePost(id);
    }

    public List<CreatePostDTO> getMyList() {
        return recordDAO.getMyList();
    }
    public List<CreatePostDTO> getListMyLocation(int locationId) {
        return recordDAO.getListMyLocation(locationId);
    }
    public List<CreatePostDTO> getFeedList() {
        return recordDAO.getFeedList();
    }
    public List<LocationDTO> getMyMap() {
        return recordDAO.getMyMap();
    }

}

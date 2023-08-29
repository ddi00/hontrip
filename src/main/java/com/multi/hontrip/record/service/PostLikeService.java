package com.multi.hontrip.record.service;

import com.multi.hontrip.record.dao.PostLikeDAO;
import com.multi.hontrip.record.dto.PostLikeDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PostLikeService {

    private final PostLikeDAO postLikeDAO;

    public void likePost(PostLikeDTO postLikeDTO) {
        postLikeDAO.insertLike(postLikeDTO);
    }

    public void deleteLikePost(PostLikeDTO postLikeDTO) {
        postLikeDAO.deleteLike(postLikeDTO);
    }

    public List<PostLikeDTO> selectLikeList(long recordId) {
        return postLikeDAO.selectLike(recordId);
    }
}

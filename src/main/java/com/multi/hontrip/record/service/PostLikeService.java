package com.multi.hontrip.record.service;

import com.multi.hontrip.record.dao.PostLikeDAO;
import com.multi.hontrip.record.dto.PostLikeDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class PostLikeService {

    private final PostLikeDAO postLikeDAO;

    // 게시물 좋아요
    public void likePost(PostLikeDTO postLikeDTO) {
        postLikeDAO.insertLike(postLikeDTO);
    }

    public PostLikeDTO selectLike(PostLikeDTO postLikeDTO) {
        return postLikeDAO.selectLike(postLikeDTO);
    }
}

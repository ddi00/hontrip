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

    //좋아요
    public void likePost(PostLikeDTO postLikeDTO) {
        postLikeDAO.insertLike(postLikeDTO);
    }

    // 좋아요 취소
    public void deleteLikePost(PostLikeDTO postLikeDTO) {
        postLikeDAO.deleteLike(postLikeDTO);
    }

    // 좋아요 리스트
    public List<PostLikeDTO> selectLikeList(long recordId) {
        return postLikeDAO.selectLike(recordId);
    }

    // 현재 게시물에 좋아요를 누른 유저인지 확인
    public boolean checkUserLikedPost(long userId, long postId) {
        List<PostLikeDTO> likeUserList = selectLikeList(postId);

        for (PostLikeDTO dto : likeUserList) {
            if (dto.getUserId() == userId) {
                return true; // 유저가 좋아요를 눌렀을 경우
            }
        }

        return false; // 유저가 좋아요를 누르지 않았을 경우
    }
}

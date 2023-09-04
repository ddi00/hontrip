package com.multi.hontrip.record.controller;

import com.multi.hontrip.common.RequiredSessionCheck;
import com.multi.hontrip.record.dto.*;
import com.multi.hontrip.record.service.CommentService;
import com.multi.hontrip.record.service.LocationService;
import com.multi.hontrip.record.service.PostLikeService;
import com.multi.hontrip.record.service.RecordService;
import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("record")
@RequiredArgsConstructor
@PropertySource("classpath:properties/record/appkey.properties")
public class RecordContorller {
    private final RecordService recordService;
    private final CommentService commentService;
    private final LocationService locationService;
    private final PostLikeService postLikeService;

    @Value("${map.appkey}")
    private String MAP_KEY ; //카카오 인증 ID

    @GetMapping("createpost")// 게시물 작성폼에 위치 정보 가져오기
    @RequiredSessionCheck
    public String uploadPostView(Model model, HttpSession session) {
        List<LocationDTO> locationList = locationService.locationList();
        model.addAttribute("locationList", locationList);
        return "/record/createpost";
    }

    @PostMapping("createpost") // 게시물 작성
    public String uploadPost(HttpServletRequest request,
                             @RequestParam("file") MultipartFile file,
                             @RequestParam("multifiles")  MultipartFile[] multifiles,
                             CreatePostDTO createPostDTO) {
        List<String> multifilesUrl = recordService.setMultifiles(multifiles); //이미지 주소

        long postId = recordService.upLoadPost(file, createPostDTO); //id추출
        recordService.imgUrlsInsert(multifilesUrl, postId);
        return "redirect:/record/postinfo?id=" + postId;
    }

    @GetMapping("postinfo") // 게시물 상세 페이지 / 댓글 / 좋아요
    public String postInfo(@RequestParam("id") long id, Model model,
                           HttpServletRequest request, HttpServletResponse response) {
        PostInfoDTO postInfoDTO = recordService.selectPostInfo(id); // 게시물 상세 정보

        // 조회수 증가 관련 로직
        String postViewKey = "post_view_" + id;
        boolean hasViewed = false;

        // 조회수 중복 관련 로직
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (postViewKey.equals(cookie.getName())) {
                    hasViewed = true;
                    break;
                }
            }
        }

        if (!hasViewed) {
            recordService.incrementPostViews(id); // 조회수 증가 메서드 호출
            // 쿠키 추가
            Cookie viewCookie = new Cookie(postViewKey, "true");
            viewCookie.setMaxAge(24 * 60 * 60); // 쿠키 유효기간 24시간
            response.addCookie(viewCookie);

            postInfoDTO.setViews(postInfoDTO.getViews() + 1); // 조회수 증가
        }

        List<PostImgDTO> postImgList = recordService.selectPostImg(id); //게시물 이미지
        List<CommentDTO> commentList = commentService.selectPostComment(id); //게시물 댓글
        List<CommentDTO> reCommentList = commentService.reCommentList(commentList); //대댓글
        List<PostLikeDTO> likeUserList = postLikeService.selectLikeList(id); //좋아요 누른 유저

        long sessionUserId = 0; // 현재세션의 유저 id값
        boolean userLikedPost;

        // 현제 세션에 유저가 없더라도 상세페이지 확인 가능
        if (request.getSession().getAttribute("id") != null) {
            sessionUserId = (long)request.getSession().getAttribute("id");
            userLikedPost = postLikeService.checkUserLikedPost(sessionUserId, id);
        } else {
            userLikedPost = false;
        }

        if (userLikedPost) { // 좋아요를 누른 유저이면 ok
            model.addAttribute("userCheckLike", "ok");
        }
        model.addAttribute("postInfoDTO", postInfoDTO);
        model.addAttribute("commentList", commentList);
        model.addAttribute("postImgList", postImgList);
        model.addAttribute("reCommentList", reCommentList);
        model.addAttribute("likeUserList", likeUserList);
        return "/record/postinfo";
    }

    @PostMapping("update_post") // 게시물 수정 적용
    public String updatePostInfo(@RequestBody CreatePostDTO createPostDTO) {
        long postId = recordService.updatePostInfo(createPostDTO);
        return "redirect:/record/postinfo?id=" + postId; // 수정후 수정된 게시물 이동
    }

    @GetMapping("deletepost") // 게시물 삭제
    @RequiredSessionCheck
    public String deletePost(@RequestParam long id, HttpSession httpSession) {
        recordService.deletePostInfo(id);
        return "redirect:/record/mylist"; // 삭제후 내 피드로 이동
    }

    @ResponseBody
    @GetMapping("like_post") // 게시물 좋아요
    @RequiredSessionCheck
    public Map<String, Object> likeCount(PostLikeDTO postLikeDTO, HttpSession httpSession) {
        postLikeService.likePost(postLikeDTO);
        List<PostLikeDTO> likeUserList = postLikeService.selectLikeList(postLikeDTO.getRecordId());
        int likeCount = likeUserList.size();

        Map<String, Object> map = new HashMap<>();
        map.put("likeCount", likeCount);
        map.put("likeUserList", likeUserList);
        return map; // JSON 응답으로 댓글 수 리턴
    }

    @ResponseBody
    @GetMapping("delete_like_post") // 게시물 좋아요 삭제
    @RequiredSessionCheck
    public Map<String, Object> unLikedPost(PostLikeDTO postLikeDTO, HttpSession httpSession) {
        postLikeService.deleteLikePost(postLikeDTO);
        List<PostLikeDTO> likeUserList = postLikeService.selectLikeList(postLikeDTO.getRecordId());
        int likeCount = likeUserList.size();

        Map<String, Object> map = new HashMap<>();
        map.put("likeCount", likeCount);
        map.put("likeUserList", likeUserList);
        return map; // JSON 응답으로 댓글 수 리턴
    }

    @GetMapping("mylist") // 내 게시물 전체 가져오기
    public String getMyList(Model model, HttpSession session) {
        long  userId = (long) session.getAttribute("id");

        final int PAGE_ROW_COUNT = 6; // 한 페이지에 표시할 게시물 개수
        int pageNum = 1; // 페이지 번호
        int startRowNum = 0 + (pageNum - 1) * PAGE_ROW_COUNT; // 시작 row 번호
        int endRowNum = pageNum * PAGE_ROW_COUNT; // 마지막 row 번호
        int rowCount = PAGE_ROW_COUNT; // row 카운트

        // 페이지 조건에 맞는 리스트 불러올 재료
        PostScrollDTO postScrollDTO = new PostScrollDTO();
        postScrollDTO.setUserId(userId);
        postScrollDTO.setStartRowNum(startRowNum);
        postScrollDTO.setEndRowNum(endRowNum);
        postScrollDTO.setRowCount(rowCount);

        List<LocationDTO> getMyMap = recordService.getMyMap(userId); // 지도 정보 가져오기
        List<LocationDTO> locationList = locationService.locationList(); //드롭다운 컨테이너 지역 정보 가져오기
        model.addAttribute("mymap", getMyMap);
        model.addAttribute("locationList", locationList);
        model.addAttribute("appkey",MAP_KEY);

        List<PostInfoDTO> listSize = recordService.getMyList(userId);
        List<PostInfoDTO> mylist = recordService.getMyListWithScroll(postScrollDTO);
        // 내 게시물 수
        int totalRow = listSize.size();
        // 전체 페이지 수
        int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);

        model.addAttribute("totalPageCount", totalPageCount);
        model.addAttribute("totalRow", totalRow);
        model.addAttribute("pageNum", pageNum);

        model.addAttribute("mylist", mylist);
        return "/record/mylist"; // 기존의 뷰 이름 반환
    }

    @RequestMapping("re-post-page")
    public String myListWithScroll(@RequestParam int pageNum, Model model, HttpSession session) {
        long  userId = (long) session.getAttribute("id");
        final int PAGE_ROW_COUNT = 6; // 한 페이지에 표시할 게시물 개수

        int startRowNum = 0 + (pageNum - 1) * PAGE_ROW_COUNT; // 시작 row 번호
        int endRowNum = pageNum * PAGE_ROW_COUNT; // 마지막 row 번호
        int rowCount = PAGE_ROW_COUNT; // row 카운트

        PostScrollDTO postScrollDTO = new PostScrollDTO();
        postScrollDTO.setUserId(userId);
        postScrollDTO.setStartRowNum(startRowNum);
        postScrollDTO.setEndRowNum(endRowNum);
        postScrollDTO.setRowCount(rowCount);

        List<PostInfoDTO> mylist = recordService.getMyListWithScroll(postScrollDTO);
        // 내 게시물 수
        int totalRow = mylist.size();
        // 전체 페이지 수
        int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);

        model.addAttribute("totalPageCount", totalPageCount);
        model.addAttribute("totalRow", pageNum);
        model.addAttribute("pageNum", pageNum);

        model.addAttribute("mylist", mylist);
        return "/record/post_list_page";
    }


    @GetMapping("list_mylocation_click") //  마커클릭시 내 게시물 해당지역 리스트 가져오기
    public void getListMyLocationClick(@RequestParam("locationId") Long locationId, Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("id");
        List<PostInfoDTO> getListMyLocationClick = recordService.getListMyLocationClick(locationId, userId);
        List<LocationDTO> getMyMap = recordService.getMyMap(userId);
        List<LocationDTO> locationList = locationService.locationList(); //드롭다운 컨테이너 지역 정보 가져오기
        model.addAttribute("mylist", getListMyLocationClick); // mylist 모델에 데이터 추가
        model.addAttribute("mymap", getMyMap);
        model.addAttribute("locationList", locationList);
    }


    @GetMapping("list_mylocation_dropdown") // 드롭다운 선택 시 내 게시물 해당지역 리스트 가져오기
    public void getListMyLocationDrowDown(@RequestParam("locationId") Long locationId, Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("id");
        List<PostInfoDTO> getListMyLocationDrowDown = recordService.getListMyLocationDrowDown(locationId, userId);
        List<LocationDTO> getMyMap = recordService.getMyMap(userId);
        List<LocationDTO> locationList = locationService.locationList(); //드롭다운 컨테이너 지역 정보 가져오기
        model.addAttribute("mylist", getListMyLocationDrowDown); // mylist 모델에 데이터 추가
        model.addAttribute("mymap", getMyMap);
        model.addAttribute("locationList", locationList);
    }

    @GetMapping("feedlist") // 공유피드 리스트 가져오기
    public String getFeedList(Model model) {
        final int PAGE_ROW_COUNT = 6; // 한 페이지에 표시할 게시물 개수
        int pageNum = 1; // 페이지 번호
        int startRowNum = 0 + (pageNum - 1) * PAGE_ROW_COUNT; // 시작 row 번호
        int endRowNum = pageNum * PAGE_ROW_COUNT; // 마지막 row 번호
        int rowCount = PAGE_ROW_COUNT; // row 카운트

        // 페이지 조건에 맞는 리스트 불러올 재료
        PostScrollDTO postScrollDTO = new PostScrollDTO();
        postScrollDTO.setStartRowNum(startRowNum);
        postScrollDTO.setEndRowNum(endRowNum);
        postScrollDTO.setRowCount(rowCount);


        List<LocationDTO> locationList = locationService.locationList(); //드롭다운 컨테이너 지역 정보 가져오기
        model.addAttribute("locationList", locationList);



        List<PostInfoDTO> listSize = recordService.getFeedList();
        List<PostInfoDTO> feedlist = recordService.getFeedListWithScroll(postScrollDTO);
        // 내 게시물 수
        int totalRow = listSize.size();
        // 전체 페이지 수
        int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);

        model.addAttribute("totalPageCount", totalPageCount);
        model.addAttribute("totalRow", totalRow);
        model.addAttribute("pageNum", pageNum);

        model.addAttribute("feedlist", feedlist);


        return "/record/feedlist"; // feedlist.jsp 파일로 반환
    }

    @RequestMapping("re-post-page2")
    public String feedListWithScroll(@RequestParam int pageNum, Model model) {
        final int PAGE_ROW_COUNT = 6    ; // 한 페이지에 표시할 게시물 개수

        int startRowNum = 0 + (pageNum - 1) * PAGE_ROW_COUNT; // 시작 row 번호
        int endRowNum = pageNum * PAGE_ROW_COUNT; // 마지막 row 번호
        int rowCount = PAGE_ROW_COUNT; // row 카운트

        PostScrollDTO postScrollDTO = new PostScrollDTO();
        postScrollDTO.setStartRowNum(startRowNum);
        postScrollDTO.setEndRowNum(endRowNum);
        postScrollDTO.setRowCount(rowCount);

        List<PostInfoDTO> feedlist = recordService.getFeedListWithScroll(postScrollDTO);
        // 내 게시물 수
        int totalRow = feedlist.size();
        // 전체 페이지 수
        int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);

        model.addAttribute("totalPageCount", totalPageCount);
        model.addAttribute("totalRow", pageNum);
        model.addAttribute("pageNum", pageNum);

        model.addAttribute("feedlist", feedlist);


        return "/record/post_list_page2";
    }

    @GetMapping("feedlist_location_buttons") // 공유피드에서 지역 버튼 선택시 리스트 가져오기
    public void getFeedListLocationButtons(@RequestParam("locationIdPattern") String locationIdPattern,
                                           @RequestParam("locationIdSpecialId") String locationIdSpecialId,
                                           @RequestParam("locationIdSpecialId2") String locationIdSpecialId2,
                                           @RequestParam("locationIdSpecialId3") String locationIdSpecialId3,
                                           Model model) {
        List<PostInfoDTO> getFeedListLocationButtons;
        if (locationIdPattern.equals("")) {
            getFeedListLocationButtons = recordService.getFeedListLocationButtonsAll(locationIdPattern);
        } else {
            getFeedListLocationButtons = recordService.getFeedListLocationButtons(locationIdPattern, locationIdSpecialId, locationIdSpecialId2, locationIdSpecialId3);
        }
        model.addAttribute("feedListButtons", getFeedListLocationButtons);
    }

    @GetMapping("feedlist_like") // 공유피드 리스트 가져오기
    public void getFeedListLike(Model model) {
        List<PostInfoDTO> getFeedListLike = recordService.getFeedListLike();
        model.addAttribute("feedlist_like", getFeedListLike);
    }
}


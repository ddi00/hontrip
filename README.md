![Image](https://github.com/copidingz/hontrip/assets/131749616/ab773419-e524-4dce-bcf0-83253adb6ed3)
# 팀프로젝트 - hontrip - copidingz
### "혼자여도 외롭지 않은 여행"
##### 🚗 'hontip'은 혼자 여행하는 것을 즐기는 사람들을 위한 여행 커뮤니티입니다.
- 일상에서 여행의 설렘이 필요한 순간, 국내 어느 여행지에서든 우리의 플랫폼이 그 공백을 채워줄 것입니다. 
- 여행을 사랑하는 사람들이 모여 자신의 여행을 기록하고 계획하며 여행을 함께할 동행자를 찾을 수 있는 커뮤니티를 구축하는 것이 이 프로젝트의 핵심입니다.
- 코로나 이후 ‘즉흥 여행, ‘혼행족’ 등의 키워드가 부상하고 있으며, 1인 여행객의 비율이 압도적으로 높아졌습니다.
- 기존 여행 사이트들의 부족한 커뮤니티 기능과 안전 정보 제공을 보안하기 위해, 우리는 여행 동행자를 찾고, 개별 여행을 공유하며, 안전 정보와 응급시설 정보를 제공하는 혼행족을 위한 플랫폼을 개발하였습니다.


## 1. 제작기간
2023.07.24~2023.09.06 (1.5개월)

## 2. 사용기술
- <strong>Back-end</strong>
  - JAVA8
  - Spring Framework 5.0.1, Spring MVC
  - Junit5
  - Maven
  - Mybatis
  - IntelliJ
  - WebSocket
- <strong>Front-end</strong>
  - HTML
  - CSS
  - JavaScript
  - JQuery 3.6.4
  - BootStrap 5
  - Stomp
  - SockJS
- <strong>Collaboration</strong>
  - Git
  - Slack
- <strong>External API</strong>
  - 카카오맵 api
  - 공공데이터포털 행정안전부_재난문자방송 발령현황(지역별)
  - 공공데이터포털 한국관광공사_국문 관광정보 서비스_GW
  - 공공데이터포털 국토교통부_(TAGO)_국내항공운항정보

## 3. 기능구현 
- ##### [조선화] 회원가입, 채팅
  - 소셜로그인 및 마이페이지 구현
  - jsp tiles로 전체 뷰 생성 후 배포
  - 채팅리스트 및 채팅방 구현
  

- ##### [박영선] 여행기록
    - 지도API 호출 및 지도에 마커생성
    - 나의 여행기록 게시물 리스트
    - 드롭다운을 통한 게시물 리스트
    - 마커클릭을 통한 게시물 리스트
    - 여행기록 공유 게시물 리스트
    - 지역버튼을 통한 게시물 리스트
    - 좋아요 버튼을 통한 게시물 리스트
    - 여행기록 공유 게시물 무한스크롤 적용


- ##### [고영준] 여행기록
  - 기록 게시물 CRUD
  - 기록 게시물 이미지 멀티파일 업로드
  - 기록 게시물 댓글, 대댓글 CRUD
  - 기록 게시물 좋아요 CRUD, 좋아요 / 좋아요취소 (검증)
  - 기록 게시물 좋아요 상위 10개 메인페이지 표시
  - 내 피드 리스트 무한스크롤 기능
  - 내 피드, 게시물 상세, 게시물 작성, 게시물 수정 뷰
  - footer 뷰


- ##### [윤소영] 여행일정
    - 여행계획 CRUD, 계획 리스트
    - 여행지 api 호출, 파싱, DB 저장 및 여행지명, 지역명으로 검색 
    - 여행지 즐겨찾기 추가, 해제 및 즐겨찾기 수 상위 10개 여행지 메인페이지 표시 
    - 항공권 api 호출, 파싱, DB 저장 및 공항, 날짜로 검색
    - 일정 상세 페이지 여행지 및 항공권 검색, 리스트, 추가, 삭제
    - 여행계획 뷰 
   

- ##### [유채림] 여행일정
    - 여행계획 CRUD
    - 숙소 api 호출, 파싱, DB 저장 및 주소, 숙소명으로 검색
    - 응급시설 api 호출, 파싱, DB 저장 및 주소, 카테고리명으로 검색
    - 안전정보 api 지역명으로 실시간 호출
    - 일정 상세 페이지 숙소 검색, 리스트, 추가, 삭제
    - 안전정보 및 응급시설 모달로 조회


- ##### [양혜원] 동행인모집
    - 동행 게시글 작성
    - 동행 게시글 수정 및 삭제
    - 동행 신청 알림리스트 페이징, 소프트삭제, 불러오기
    - 동행신청, 채팅메세지, 동행 확정 실시간 알림
    - 동행 신청 알림과 채팅 연결
    - 채팅 기능 추가 및 CSS
    - 동행 수락 거절 기능


- ##### [강진구] 동행인모집
    - 사용자가 동행을 찾을 수 있는 게시판 구현
    - 긴 목록을 여러 페이지로 분할하여 표시하고, 필터 또는 검색 조건을 유지하여 페이지를 다시 로드할 때 이전 상태를 보존
    - 사용자가 동행 게시물을 연령, 지역 또는 조회수 순으로 필터링하고 검색할 수 있도록 검색 옵션을 제공
    - 동행 게시물을 선택하면 해당 게시물에 대한 댓글 및 답글을 읽을 수 있고, 새로운 댓글과 답글을 작성, 수정 및 삭제
    - 각 게시물의 조회 수 표시 및 동행 신청 현황을 게시물에 표시하여 사용자 신청 상태 확인 제공
    - 채팅 목록 select,리로드 추가 및 css


 

## ERD 설계
![Image](https://github.com/copidingz/hontrip/assets/131749616/2c71ac9f-9685-4231-8ef5-ad4922a3a867)



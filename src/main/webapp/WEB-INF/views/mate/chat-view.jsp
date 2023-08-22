<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<section class="wrapper bg-gray">
    <div class="container pt-10 pb-14 pb-md-16">
        <!-- 1. 새 채팅방 설정
                - 필요정보 : 상대방 id(내 아이디는 세션에서 꺼낸다)
        -->
        <h1>채팅방 만들기</h1>
        <form name="채팅방 생성폼" action="/hontrip/mate/create-chatroom" method="POST">
            채팅룸 이름 : <input type="text" name="chatRoomName" ><br>
            소유자 아이디: <input type="number" name="ownerId" value="2" \><br>
            게스트 아이디 : <input type="number" name="guestId" value="1"\><br>
            포스트 아이디 : <input type="number" name="postId" value="1"\><br>
            <button id="new_chat_room">채팅 만들기</button>
        </form>

        <br>
        <div>
            <h1>채팅방 참여하기</h1>
            <form name="채팅방 참여 폼" action="/hontrip/mate/join-chat/1" method="GET">
                아이디 : <input type="number" name="user_id"><br>    <!-- 1또는 2, 2가 주인 -->
                <button type="submit">채팅참여</button>
            </form>
        </div>
    </div>
</section>

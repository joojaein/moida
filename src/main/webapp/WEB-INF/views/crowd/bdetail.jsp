<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<main>
<link href="resources/css/basic.css" type="text/css" rel="stylesheet" />
<link href="/resources/css/rprtBox.css" type="text/css" rel="stylesheet" />
<link href="/resources/css/groupboarddetail.css" type="text/css" rel="stylesheet" />
<link href="/resources/css/backpage.css" type="text/css" rel="stylesheet" />
<script src="/resources/js/boarddetail.js"></script> 
<script src="/resources/js/backpage.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<div class="wrapper">
	<section class="main-head">
		<div>
		<nav>
			<div>
				<a href="main?crowd=${crowd.id}">정보</a>
			</div>
			<div>
				<a href="notice?t=0&crowd=${crowd.id}">공지사항</a>
			</div>
			<div>
				<a href="calendar?crowd=${crowd.id}">일정</a>
			</div>
			<div>
				<a href="board?t=1&crowd=${crowd.id}">게시판</a>
			</div>
			<div>
				<a href="album?t=2&crowd=${crowd.id}">사진첩</a>
			</div>
			<div>
				<a class="groupChat" href="groupchat?crowd=${crowd.id}">단체채팅</a>
			</div>
		</nav>
	</div>
	</section>
	<script type="text/javascript">
	$(document).ready(function(){
		var areaContent = document.querySelector(".content div");
		var textareaContent = areaContent.querySelector("textarea");
		textareaContent.style.height = "1px";
		textareaContent.style.height = (1+textareaContent.scrollHeight)+"px";
	});
	</script>
	<c:url value="boardedit" var="edit">
		<c:param name="crowd" value="${crowd.id}" />
		<c:param name="posts" value="${posts.id}" />
	</c:url>
	<input id="cid" type="hidden" value="${crowd.id}" /> 
	<input class="pi" type="hidden" value="${posts.id}" />
	<input id="uid" type="hidden" value="${uid}" />
	<section class="content-title">
			<div class="ct-box">
				<h3 name="title">${posts.title}</h3>
				<div class="profile-box">
					<div onclick="imgClick('${posts.writerId}');" class="photo"
						style="background: url('/get-img?folder=member-profile&file=${posts.img}') no-repeat center; background-size: cover;"></div>
					<div class="profile-info">
						<span class="name">작성자 ${posts.writerId}</span>
						<span class="reg-write">등록일  
						<fmt:formatDate value="${posts.regDate}" pattern="yyyy-MM-dd a HH:mm" />
						</span> <span>조회수 <span class="hit" style="color: red;">[${posts.hit}]</span>
						</span>
					</div>
				</div>
			</div>
		</section>
	<article class="content">
	<div>
		<c:forEach var="pc" items="${pc}">
			<c:choose>
				<c:when test="${empty pc.text}">
					<img src="/get-img?folder=crowd-postsImg&file=${pc.src}" /><br />
				</c:when>
				<c:otherwise>
					<textarea wrap="hard">${pc.text}</textarea>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		</div>
		<div>
		<sec:authorize access="isAuthenticated()">
			<c:choose>
				<c:when test="${uid eq posts.writerId}">
					<div class="writer-btn">
						<a href="${edit}"><input class="modifi" type="button" value="수정" /></a>
						<form method="post" action="/crowd/boarddelete" style="width: 10%; text-align: right;">
							<input type="hidden" name="id" value="${posts.id}" /> 
							<input type="hidden" name="board" value="board" /> 
							<input type="hidden" name="type" value="1" /> 
							<input type="hidden" name="crowdId" value="${crowd.id}" /> 
							<input class="delete" type="submit" value="삭제" style="margin-left: 5px" />
						</form>
					</div>
				</c:when>
				<c:when test="${mRole.groupRole <= 1}">
					<div class="writer-btn">
						<form method="post" action="/crowd/boarddelete" style="width: 10%; text-align: right;">
							<input type="hidden" name="id" value="${posts.id}" /> 
							<input type="hidden" name="board" value="board" />
							<input type="hidden" name="type" value="1" /> 
							<input type="hidden" name="crowdId" value="${crowd.id}" /> 
							<input class="delete" type="submit" value="삭제" style="margin-left: 5px" />
						</form>
					</div>
				</c:when>
			</c:choose>
			</sec:authorize>
	</div>
	</article>
	<section class="content-comment">
	<div class="comment-body">
	<sec:authentication property="principal" var="pinfo"/>
		<div class="comentlike">
			<div class="comment-sum"><span>댓글 </span><span class="cmtCnt">${posts.cmtCnt}</span></div>
				<div class="comment-sum like">
				<c:choose>
				<c:when test="${isGood eq 0}">
					좋아요<span class="likecnt" data-id="${isGood}">♡</span> <span style="color:#494949" class="goodcnt">${posts.goodcnt}</span>
				</c:when>
				<c:when test="${isGood eq 1}">
					좋아요<span class="likecnt" data-id="${isGood}">♥</span> <span style="color:#494949" class="goodcnt">${posts.goodcnt}</span>
				</c:when>
				</c:choose>
			</div>
		</div>
		<div class="comment-reg">
			<div class="comment-box">
				<input class="comment-input" type="text" placeholder="댓글" /> 
				<input class="comment-add-btn" type="button" value="등록" onclick="commentadd();" />
			</div>
		</div>
			<template id="tem2">
			<div class="cmt-box">
				<div class="comment-content">
					<input class="cmtid" type="hidden" /> 
					<input class="cmtimg" type="hidden" />
					<div class="profile-photo">
						<div class="writerimg">
							<div class="comment-photo"></div>
							<div class="profile-info"><span class="name"></span></div>
						</div>
						<div class="edit-btn">
						</div>
					</div>
					<div class="cc-box">
						<p></p>
						<div></div>
					</div>
				</div>
				<hr />
			</div>
			</template>
			<div class="temp-cmt">
			<c:forEach var="cmt" items="${cmt}">
				<div class="cmt-box">
					<div class="comment-content">
						<input class="cmtid" type="hidden" value="${cmt.id}"/>
						<input class="cmtimg" type="hidden" value="${cmt.img}"/>
							<div class="profile-photo">
							<div class="writerimg">
								<div class="comment-photo" style="background: url('/get-img?folder=member-profile&file=${cmt.img}') no-repeat center; background-size: cover;">
								</div>
								<div class="profile-info">
									<span class="name">${cmt.writerId}</span>
								</div>
								</div>
								<div class="edit-btn">
									<sec:authorize access="isAuthenticated()">
										<c:choose>
											<c:when test="${uid eq cmt.writerId}">
												<input class="comment-edit" type="button" value="수정" />
												<input class="comment-del" type="button" value="삭제" />
											</c:when>
											<c:when test="${mRole.groupRole <= 1}">
												<input class="comment-del" type="button" value="삭제" />
											</c:when>
											<c:otherwise>
											</c:otherwise>
										</c:choose>
									</sec:authorize>
								</div>
							</div>
							<div class="cc-box">
						<p>${cmt.content}</p>
						<div>
						<fmt:formatDate value="${cmt.regDate}" pattern="yyyy-MM-dd a HH:mm" />
						</div>
						</div>
					</div>
				<hr />
				</div>
			</c:forEach>
		</div>
		</div>
	</section>
	</div>
</main>
<a id="MOVE_BACK_BTN">목록으로</a>
<section class="rprt-box">
	<div class="rprt d-none">
		<h1>신고하기</h1>
		<div class="clear">
			<img class="clear-btn" src="../../../resources/images/clearbtn.png" />
		</div>
		<h3 class="rprt-title">신고사유</h3>
		<select>
			<option value="">사유 선택</option>
			<option value="욕설/반말/부적절한 언어">욕설/반말/부적절한 언어</option>
			<option value="회원 분란 유도">회원 분란 유도</option>
			<option value="음란성 게시물">음란성 게시물</option>
			<option value="광고성 게시물">광고성 게시물</option>
			<option value="회원 비방">회원 비방</option>
			<option value="지나친 정치/종교 논쟁">지나친 정치/종교 논쟁</option>
			<option value="명예훼손/저작권 침해">명예훼손/저작권 침해</option>
			<option value="초상권 침해/도촬">초상권 침해/도촬</option>
			<option value="도배성 게시물">도배성 게시물</option>
		</select>
		<h3 class="rprt-title">신고사유</h3>
		<textarea></textarea>
		<div class="rprt-btn">
			<input type="submit" value="신고하기" />
		</div>
	</div>
</section>

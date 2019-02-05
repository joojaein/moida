<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<main>
<link href="/resources/css/rprtBox.css" type="text/css" rel="stylesheet" />
<link href="/resources/css/groupalbum.css" type="text/css" rel="stylesheet" />
<script src="/resources/js/groupalbum.js"></script> 
<link href="/resources/css/groupsearch.css" type="text/css" rel="stylesheet" />
<script src="/resources/js/groupsearch.js"></script>
<div class="wrapper">
	<section class="main-head">
		<nav>
			<div>
				<a href="main">정보</a>
			</div>
			<div>
				<a href="notice">공지사항</a>
			</div>
			<div>
				<a href="calendar">일정</a>
			</div>
			<div>
				<a href="board">게시판</a>
			</div>
			<div>
				<a href="album">사진첩</a>
			</div>
			<div>
				<a href="album">단체채팅</a>
			</div>
		</nav>
	</section>
	<section class="sub-head">
	<div class="sub-head-box">
	<nav class="search-box">
		</nav>
			<div class="search">
				<div class="icon">
					<img src="../../../resources/images/Magnifying.png" />
				</div>
				<div class="field">
					<input type="search" placeholder="검색" />
				</div>
			</div>
			</div>
</section>
	<div>
		<article class="content">
			<div class="content-box">
				<div>
					<img src="../../../resources/images/twice.jpg" alt="">
					<div class="content-box-div">
						<span class="album-title">어디갔다왔지롱 <span style="color: red">[10]</span></span>
						<p style="margin: 0">이름</p>
						<p style="margin: 0">2019-01-09 오후 17:11</p>
					</div>
				</div>
				<div>
					<img src="../../../resources/images/twice.jpg" alt="">
					<div class="content-box-div">
						<span class="album-title">어디갔다왔지롱 <span style="color: red">[10]</span></span>
						<p style="margin: 0">이름</p>
						<p style="margin: 0">2019-01-09 오후 17:11</p>
					</div>
				</div>
			</div>
		</article>
	</div>
</div>
<hr />
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
</main>
<a id="MOVE_BACK_BTN" href="#">목록으로</a>
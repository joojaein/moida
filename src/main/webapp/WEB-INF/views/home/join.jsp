<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<main>
	<link href="/resources/css/homeEtc.css" type="text/css" rel="stylesheet" />
    <script src="/resources/js/homeJoin.js"> </script>
    
	<h1 class="etc-logo"><a href="/index">MOIDA</a></h1>
	<div class="left join">
	
		<input type="text" placeholder="ID"></br>
		<input type="text" placeholder="비밀번호"></br>
		<input type="text" placeholder="이름"></br>

		<div class="email-auth">	
			<input class="txt email" type="text" placeholder="이메일">
			<input class="btn btn-send" type="button" value="인증번호 발송"><br/>
			<input class="txt authNum d-none" placeholder="인증번호" type="text">
			<input class="btn btn-auth d-none" type="button" value="인 증"><br/>	
		</div>


		<div class="etc">
			<div class="div-date">
				<input placeholder="생년월일" class="date-etc" type="text" onfocus="(this.type='date')">
			</div>
			<div class="div-gender">
				<ul>
					<li class="li-gender"><div>남자</div><input type="radio" name="radio-gender"></li>
					<li class="li-gender"><div>여자</div><input type="radio" name="radio-gender"></li>
				</ul>
			</div>
		</div>

		<div class="etc-prof">
			<img class="img-prof" src="/resources/images/profileImage.png">
			<div class="txt-prof">
				<label class="fs18">Profile Message</label><br/>
				<textarea></textarea>
			</div>
		</div>
		
		<input class="btn btn-join fwb" type="button" value="가입하기"/>
	
	</div>
</main>
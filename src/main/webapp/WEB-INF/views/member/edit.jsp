<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<main>
	<link href="/resources/css/memberPage.css" type="text/css" rel="stylesheet" />
    <script src="/resources/js/memberEdit.js"> </script>
 
    <div class="member-edit">
	    <div class="profile">
	    	<div class="profile-img">	
		    	<img src="/resources/images/profile.png">
	 			<input style="display:none" type="file" />
   		    	<input class="btn" type="button">    	
	    	</div>
	    	<div class="id fs16 fwb">하하하</div>
	    </div>
	    
	    
	    <div class="etc">
       	    <hr class="hr-bold"/> 
		    <div class="div-msg">   
		    	<h1>Profile Message</h1>
		    	<textarea></textarea>
		    	<div class="right">
		    		<input class="btn" type="button" value="프로필변경"/>
	    		</div>
		    	
		    </div>
		    
	   	    
	   		<hr class="hr-bold"/>
		    <div class="div-pw">
  		    	<h1>비밀번호 변경</h1>
		    	<input class="pw" placeholder="기존 비밀번호"/>
		    	<input class="npw" placeholder="새로운 비밀번호"/>
		    	<input class="rpw" placeholder="비밀번호 재확인"/>
		    	<div class="right">
		    		<input class="btn" type="button" value="비밀번호 변경"/>
	    		</div>
		    	
		    </div>
		    
	   	   
   			<hr class="hr-bold"/>
	   		<div class="div-email">
  		    	<h1>이메일 변경</h1>
  		    	<div class="email-auth">	
					<input class="txt email" type="text" placeholder="이메일">
					<input class="btn btn-send" type="button" value="인증번호 발송"><br/>
					<input class="txt authNum d-none" placeholder="인증번호" type="text">
					<input class="btn btn-auth d-none" type="button" value="인 증"><br/>	
				</div>
				<div class="right">
		    		<input class="btn d-none" type="button" value="이메일 변경"/>
	    		</div>	
	   		</div>
   		</div>
   	</div>
</main>
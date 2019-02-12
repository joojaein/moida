<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" media="screen"
	href="/resources/css/search.css" />
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>

<script>
	$(function() {
		var calist = $(".calist");
		var alllist = $(".alllist");
		var sebu = $(".sebu");
		var indicator = $(".indicator");
		var cacontainer = $(".category-list-container");
		var decontainer = $(".detail-list-container");
		var mainul = $(".category-main-ul");
		var chk = false;
		var tagname = $(".tag-name");
		var contentbox = $(".content-box");
		
		var jsContainer = document.querySelector(".category-content-container");
		
		
		alllist.on("click", function(e){
			e.stopPropagation();
			window.location.href="/crowd/search";
		});
		
		tagname.click(function(evt) {
			var sebuchk = $(this).hasClass("category-name");
			var cid = $(this).data("cid");
			var tid = $(this).data("tid");
			
/* 			alert(cid);
			alert(tid); */
			var temp = document.getElementsByTagName("template")[0];
			jsContainer.innerHTML = "";

			if(tid==undefined){
				if(sebuchk){
					var target = evt.target;
					var tempThis;
					var jsUl =document.querySelector(".category-main-ul");
					var ulChildren = jsUl.querySelectorAll(".calist");
					for (var i = 0; i < ulChildren.length; i++) {
						if(ulChildren[i].innerText == target.innerText){
							tempThis = ulChildren[i].parentNode;
							console.log(" in : " +ulChildren[i].innerText)
						}
					}
					
					if (!chk) {
						mainul.find("li").find("ul").css({
							"visibility" : "hidden"
						});
						$(tempThis).find("ul").css({
							"visibility" : "visible"
						});
						cacontainer.addClass("height");
					} else {
						if (cacontainer.hasClass("height")
								&& ($(tempThis).find("ul")
										.css("visibility") == "hidden")) {
							mainul.find("li").find("ul").css({
								"visibility" : "hidden"
							});
							$(tempThis).find("ul").css({
								"visibility" : "visible"
							});
							return chk;
						} else if (cacontainer.hasClass("height")
								&& ($(tempThis).find("ul")
										.css("visibility") == "visible")) {

							mainul.find("li").find("ul").css({
								"visibility" : "hidden"
							});
							$(tempThis).find("ul").css({
								"visibility" : "visible"
							});
							cacontainer.removeClass("height");
						}

					}

					chk = !chk;
					
					
					
					
					
					
					//////////////////////////////////////////////////////
					
					//var testThis = ;
					
					
					
					/*
					
					
					alert(mainul.find("li").find("ul").data("id"));
					alert($(this).data("cid"));
					
					mainul.find("li").find("ul").css({"visibility" : "visible"});
					
					if(mainul.find("li").find("ul").data("id")!=$(this).data("cid")){
						mainul.find("li").find("ul").css({"visibility" : "hidden"});						
					}*/
		/* 			if(mainul.find("li").find("ul").data("id")==$(this).data("cid")){
						alert(mainul.find("li").data("id"));
						mainul.find("li").find("ul").css({"visibility" : "visible"});
					} */
					cacontainer.addClass("height");
					calist.removeClass("hide-calist");
					sebu.removeClass("active");
					indicator.removeClass("rotate");
					decontainer.animate({
						opacity : 0
					},100);
					
				}
				var cListRequest = new XMLHttpRequest();
				cListRequest.open("POST", "/crowd/categoryList", true);
				cListRequest.setRequestHeader("Content-Type",
						"application/x-www-form-urlencoded");
				cListRequest.onload = function() {
					var crowdCategoryList = JSON.parse(cListRequest.responseText);
					//카테고리 아이디만 받았을 경우
					for (var i = 0; i < crowdCategoryList.length; i++) {
						var tBox = document.importNode(temp.content, true);
	
						var tempH4 = tBox.querySelector("h4");
						tempH4.innerText = crowdCategoryList[i].name;
						var tempSpan1 = tBox.querySelector("span:nth-child(1)");
						tempSpan1.innerText = crowdCategoryList[i].content+"/카테고리:"+crowdCategoryList[i].categoryId;
						jsContainer.append(tBox);
					}
				}
				
				cListRequest.send("categoryId=" + cid);
				
			}else{
				var tListRequest = new XMLHttpRequest();
				tListRequest.open("POST","/crowd/tagList",true);
				tListRequest.setRequestHeader("Content-Type",
						"application/x-www-form-urlencoded");
				tListRequest.onload = function(){
					//태그아이디를 받았을 경우
					var crowdTagList = JSON.parse(tListRequest.responseText);
					console.log(crowdTagList);
					for (var i = 0; i < crowdTagList.length; i++) {
						var tBox = document.importNode(temp.content, true);
	
						var tempH4 = tBox.querySelector("h4");
						tempH4.innerText = crowdTagList[i].name;
						var tempSpan1 = tBox.querySelector("span:nth-child(1)");
						tempSpan1.innerText = crowdTagList[i].content+"/태그:"+crowdTagList[i].categoryId;
	
	
						jsContainer.append(tBox);
					}
					
				}
				
				tListRequest.send("tagId=" + tid);
			
			}
		})

		/*             tagname.click(function(){
		           	 	alert($(this).data("cid"));
		           		alert($(this).data("tid"));
		           	if((contentbox.data("cid")==$(this).data("cid"))&&(contentbox.data("tid")==$(this).data("tid"))){
		           		alert("cid가 같습니다.");
		           		contentbox.data("tid").toggleClass("d-none");
		           	} 
		           	var cid = $(this).data("cid");
		           	var tid = $(this).data("tid");

		           	$.ajax({
		           		type : "get",
		           		url : "/crowd/categoryList?l="+cid,
		           		success : function(data){
		           			var aaa = "<thead><tr>name</tr><td>내용</td></thead>"
		           			aaa += "<tbody>"
		    
		           				aaa += "<tr>";
		           				aaa += "<td>";
		           				aaa += cid;
		           				aaa += "</td>";
		           				aaa += "</tr>";          				
		           
		           			aaa += "</tbody>";
		           			contentbox.html(aaa);  

		           		},
		           		error : function(){
		           			alert("실패...");
		           		}
		           	})

			}) */

		mainul.find("li").click(function() {

	/*   if(mainul.find("li").find("ul").find("li").data("id")==mainul.find("li").find("ul").find("a").data("id")){
							  	alert(mainul.find("li").find("ul").find("li").find("a"));
							  } */
							if (!chk) {
								mainul.find("li").find("ul").css({
									"visibility" : "hidden"
								});
								$(this).find("ul").css({
									"visibility" : "visible"
								});
								cacontainer.addClass("height");
							} else {
								if (cacontainer.hasClass("height")
										&& ($(this).find("ul")
												.css("visibility") == "hidden")) {
									mainul.find("li").find("ul").css({
										"visibility" : "hidden"
									});
									$(this).find("ul").css({
										"visibility" : "visible"
									});
									return chk;
								} else if (cacontainer.hasClass("height")
										&& ($(this).find("ul")
												.css("visibility") == "visible")) {

									mainul.find("li").find("ul").css({
										"visibility" : "hidden"
									});
									$(this).find("ul").css({
										"visibility" : "visible"
									});
									cacontainer.removeClass("height");
								}

							}

							chk = !chk;

						})

		$("#bar").click(function() {
			calist.toggleClass("hide-calist");
			sebu.toggleClass("active");
			indicator.toggleClass("rotate");

			if (indicator.hasClass("rotate")) {
				decontainer.animate({
					opacity : 1
				}).css({"visibility": "visible"});
			} else {
				decontainer.animate({
					opacity : 0
				}).css({"visibility": "hidden"});
			}
			if (cacontainer.hasClass("height")) {
				cacontainer.removeClass("height");
				mainul.find("li").find("ul").css({
					"visibility" : "hidden"
				});
				chk = !chk;
				decontainer.animate({
					opacity : 1
				});
			}
		})
		$(".category-content-container").click(function() {
			sebu.removeClass("active");
			calist.removeClass("hide-calist");
			indicator.removeClass("rotate");
			decontainer.animate({
				opacity : 0
			});
		});

	})
</script>

<main>
<section>
<template>
		<div class="content-box" data-cid="${simple.categoryId}" data-tid="${crowdTag.tagId}">
		<div class="content-image">
			<a href="groupid"></a> <img src="/resources/images/tempImg.png"alt="">
		</div>
		<div class="content-detail">
			<h4>카테고리번호:태그번호:모임번호:</h4>
			<div>
				<span></span>
				<span>가입조건 :</span>
				<c:choose>
				<c:when test="${simple.gender==0}">
					<span>성별 : 남자/</span>
				</c:when>
				<c:when test="${simple.gender==1}">
					<span>성별 : 여자/</span>
				</c:when>
				<c:when test="${simple.gender==2}">
					<span>성별 : 모두/</span>
				</c:when>
				</c:choose>
				<span>지역 :</span>
			</div>
			<div class="member-cnt">
				<span>회원수 /명</span>
			</div>
		</div>
	</div>
	</template>
	<nav class="category-list-container">
		<div class="category-list">
			<ul class="category-main-ul">
				<li><a href="#" class="calist alllist">전체</a>
				<c:forEach var="category" items="${list}">
					<li><a href="#" data-id="${category.id}" class="calist">${category.name}</a>
						<ul data-id="${category.id}">
							<li><a class="tag-name" data-cid="${category.id}" href="#">전체/${category.id}</a></li>
							<c:forEach var="tag" items="${tlist}">
								<c:if test="${category.id == tag.categoryId}">
									<li><a class="tag-name" data-cid="${tag.categoryId}" data-tid="${tag.id}" href="#">${tag.name}/${tag.categoryId}/${tag.id}</a></li>
								</c:if>
								
							</c:forEach>
						</ul>
					</li>
				</c:forEach>
			</ul>
			<div class="indicator" id="bar"></div>
			<div class="sebu">
				<span>세부 카테고리</span>
			</div>
		</div>
	</nav>
</section>
<section class="detail-list-section">
	<div class="detail-list-container">
		<div class="grid-header">
			<div><a href="#" class="alllist">전체</a></div>
		</div>
		<div class="grid-category">

			<c:forEach var="category" items="${list}">
				<div><a class="tag-name category-name" data-cid="${category.id}" href="#">${category.name}</a></div>
			</c:forEach>
			
		</div>
	</div>
	<nav>
		<div class="calist-detail-list"></div>
	</nav>
</section>
<section class="category-content-container">
<c:forEach var="simple" items="${simpleDataList}">
<%-- <c:forEach var="crowdTag" items="${crowdTagList}"> --%>
<%-- <c:forEach var="tag" items="${tlist}"> --%>
	<div class="content-box" data-cid="${simple.categoryId}" data-tid="${crowdTag.tagId}">
		<div class="content-image">
			<a href="main?crowd=${simple.id}"></a> <img src="/resources/images/tempImg.png"alt="">
		</div>
		<div class="content-detail">
			<h4>${simple.name}/카테고리번호:${simple.categoryId}/태그번호:${tag.tagId} <%-- <c:forEach var="tag" items="${tlist}"> </c:forEach> --%>/모임번호:${simple.id}</h4>
			<div>
				<span>${simple.content}/</span>
				<span>가입조건 : 나이 ${simple.ageMin} ~ ${simple.ageMax}/</span>
				<c:choose>
				<c:when test="${simple.gender==0}">
					<span>성별 : 남자/</span>
				</c:when>
				<c:when test="${simple.gender==1}">
					<span>성별 : 여자/</span>
				</c:when>
				<c:when test="${simple.gender==2}">
					<span>성별 : 모두/</span>
				</c:when>
				</c:choose>
				<span>지역 : ${simple.areaSido}</span>
			</div>
			<div class="member-cnt">
				<span>회원수 ${simple.nowPerson}/${simple.maxPerson}명</span>
			</div>
		</div>
	</div>
	
	
</c:forEach>
<%-- </c:forEach> --%>
<%-- </c:forEach> --%>
</section>

</main>

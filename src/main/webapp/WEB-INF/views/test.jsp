<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script language="JavaScript" type="text/javascript" src="resources/plugins/jquery/jquery.min.js"></script>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h2> Ajax Test Page</h2>
	<div>
		<div>
			REPLAYER <input type='text' name='replyer' id='newReplyWriter'>
		</div>
		<div>
			REPLY TEXT <input type='text' name='replytext' id='newReplyText'>
		</div>
		<button id="replyAddBtn"> Add REPLY</button>
	</div>
	<ul id="replies"></ul>
	<div id = 'modDiv' style="display : none">
		<div class = 'modal-title'></div>
		<div>
			<input type='text' id='replytext'>
		</div>
		<div>
			<button type="button" id="replyModBtn">MoDiFy</button>
			<button type="button" id="replyDelBtn">DeLeTe</button>
			<button type="button" id="closeBtn">ClOsE</button>
		</div>
	</div>
	<ul class='pagination'></ul>
</body>
</html>

<script>
	var bno=2;
	getPageList(1);
	function getAllList(){
		$.getJSON("/replies/all/"+bno,function(data){
			console.log(data.length);
			var str="";
			$(data).each(function(){
				str+="<li data-rno='"+this.rno+"' class='replyLi'>" + this.rno+":"+this.replytext+"<button>mod</button>"+"</li>";
			});
			$("#replies").html(str);
		});
	}
	
	$("#replyAddBtn").on("click", function(){
		var replyer = $("#newReplyWriter").val();
		var replytext = $("#newReplyText").val();
		$.ajax({
			type : 'post',
			url : '/replies',
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : 'text',
			data : JSON.stringify({
				bno : bno,
				replyer : replyer,
				replytext : replytext
			}),
			success : function(result){
				if(result == 'SUCCESS'){
					alert("��� �Ǿ����ϴ�.");
					getAllList();
				}
				
			}
		});
	});
	
	$("#replyDelBtn").on("click", function(){
		var rno = $(".modal-title").html();
		var replytext = $("#replytext").val();
		$.ajax({
			type : 'delete',
			url : '/replies/'+rno,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "DELETE"
			},
			dataType : 'text',
			success : function(result){
				console.log("result : "+result);
				if(result == 'SUCCESS'){
					alert("���� �Ǿ����ϴ�.");
					$("#modDiv").hide("slow");
					getAllList();
				}	
			}
		});
	});
	
	$("#replyModBtn").on("click", function(){
		var rno = $(".modal-title").html();
		var replytext = $("#replytext").val();
		$.ajax({
			type : 'put',
			url : '/replies/'+rno,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : 'text',
			data : JSON.stringify({replytext : replytext}),
			success : function(result){
				if(result == 'SUCCESS'){
					alert("���� �Ǿ����ϴ�.");
					$("#modDiv").hide("slow");
					getPageList(replyPage);
				}
			}
		});
	});
	
	
	
	$("#replies").on("click",".replyLi button", function(){
		var reply = $(this).parent();
		var rno = reply.attr("data-rno");
		var replytext = reply.text();
		$(".modal-title").html(rno);
		$("#replytext").val(replytext);
		$("#modDiv").show("slow");
	});

	function getPageList(page){
		$.getJSON("/replies/"+bno+"/"+page, function(data){
			console.log(data.list.length);
			var str = "";
			$(data.list).each(function(){
				str+="<li data-rno='"+this.rno+"' class='replyLi'>" + this.rno+":"+this.replytext+"<button>mod</button>"+"</li>";
			});
			$("#replies").html(str);
			printPaging(data.pageMaker);
		})
	}
	
	function printPaging(pageMaker) {
        var str = "";
        if (pageMaker.prev) str += "<li><a href='" + (pageMaker.startPage - 1) + "'> << </a></li>";
        for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
           var strClass = pageMaker.cri.page == i ? 'class=active' : '';
           str += "<li " + strClass + "><a href='" + i + "'>" + i + "</a></li>";
        }
        if (pageMaker.next) str += "<li><a href='" + (pageMaker.endPage + 1) + "'> >> </a></li>";
        $(".pagination").html(str);
     }
	var replyPage = 1;
	$(".pagination").on("click","li a", function(event){
		event.preventDefault();
		replyPage = $(this).attr("href");
		getPageList(replyPage);
	});
</script>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ page session="false" %>
<%@include file="../include/header.jsp"%>
<script language="JavaScript" type="text/javascript" src="resources/plugins/jquery/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.1/handlebars.js"></script>
<section class="content">
	<div class="row">
		<!-- left column -->
		<div class="col-md-12">
			<!-- general form elements -->
		
			<div class="box box-info">
				<div class="box-header with-border">
					<h3 class="box-title">Read Board</h3>
					<div>
						<form role="form" action="modifyPage" method="post">
							<input type="hidden" name="bno" value="${boardVO.bno}">
							<input type='hidden' name='page' value="${cri.page}">
							<input type='hidden' name='perPageNum' value="${cri.perPageNum }">
							<input type='hidden' name='searchType' value="${cri.searchType }">
							<input type='hidden' name='keyword' value="${cri.keyword }">
						</form>
						<div class="box-body">
							<div class="box-body">
								<div class="form-group">
									<label for="inputTitle" class="col-sm-2-control-label">Title</label>
									<input type="Text" class="form-control" name="title" value="${boardVO.title }" readonly="readonly">		
								</div>
								
								<div class="form-group">
									<label for ="inputContent" class="col-sm-2-control-label"> Content</label>
									<textarea class="form-control" rows="3" name="content" readonly="readonly">${boardVO.content }</textarea>
								</div>
								
								<div class="form-group">
									<label for="input writer" class="col-sm-2-control-label">Writer</label>
									<input type="text" class="form-control" name="writer" value="${boardVO.writer}" readonly="readonly">											
								</div>
								
							</div>
							<div class="box-footer">
								<button type="submit" class="btn btn-warning">MODIFY</button>
								<button type="submit" class="btn btn-danger">REMOVE</button>
								<button type="submit" class="btn btn-primary">LIST ALL</button>
							</div>
							
						</div>
							
					</div>
				</div>
			</div>
				
		</div>
	</div>		
		<div class="row">
		<div class="col-md-12">
			
			<div class="box box-success">
				<div class="box-header">
					<h3 class="box-title"> Add New Reply</h3>
				</div>
				<div class="box-body">
					<label for="exampleInputEmail1">Writer</label>
					<input class="form-control" type="text" placeholder="USER ID" id="newReplyWriter">
					<label for="exampleInputEmail1">Reply Text</label>
					<input class="form-control" type="text" placeholder = "Reply Text" id="newReplyText">
				</div>
				<div class="box-footer">
					<button type="submit" class="btn btn-primary" id="replyAddBtn">ADD Reply </button>
				</div>
			</div>
			<ul class="timeline">
				<li class="time-label" id="repliesDiv">
					<span class="bg-green">Replies List</span>
				</li>
			</ul>
			<div class='text-center'>
				<ul id="pagination" class="pagination pagination-sm no-margin"></ul>
			</div>
		</div>
	</div>
	
	<ul id="replies">
	</ul>
	
	<script id="template" type="text/x-handlebars-template">
	{{#each .}}
		<li class="replyLi" data-rno={{rno}}>
		<i class="fa fa-comments bg-blue"></i>
		 <div class="timeline-item" >
 			<span class="time">
               <i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
            </span>
  		<h3 class="timeline-header"><strong>{{rno}}</strong> -{{replyer}}</h3>
 	 	<div class="timeline-body">{{replytext}} </div>
    	<div class="timeline-footer">
	    <a class="btn btn-primary btn-xs" 
	    data-toggle="modal" data-target="#modifyModal">Modify</a>
    </div>
  </div>			
</li>
	{{/each}}
	</script>
</section>	

<script> 
   $(document).ready(function(){
      var formObj = $("form[role='form']");
      console.log(formObj);
      $(".btn-warning").on("click", function(){
        formObj.attr("method","get");
        formObj.attr("action", "/sboard/modifyPage");
         formObj.submit();
      });
      $(".btn-danger").on("click", function(){
        formObj.attr("action", "/sboard/removePage");
         formObj.submit();
      });
      $(".btn-primary").on("click", function(){
         formObj.attr("method","get");
         formObj.attr("action","/sboard/list");
         formObj.submit();
      });
   });
</script>


<script>
	var bno=${boardVO.bno};
	var replyPage=1;
	$('#repliesDiv').on("click",function(){
		if($(".timeline li").size > 1){
			return;
		}
		console.log("click");
		getPage("/replies/"+bno+"/1");
	});
	

   $(".pagination").on("click","li a", function(event){
      event.preventDefault();
      replyPage = $(this).attr("href");
      getPage("/replies/"+bno+"/"+replyPage);
   });
   
   Handlebars.registerHelper("prettifyDate",function(timeValue){
	    var dateObj = new Date(timeValue);
	    var year = dateObj.getFullYear();
	    var month = dateObj.getMonth()+1;
	    var date = dateObj.getDate();
	    return year+"/"+month+"/"+date;
	   });
	   
	
   function getPage(pageInfo){
	   $.getJSON(pageInfo, function(data){
		   printData(data.list, $("#repliesDiv"),$('#template'));
		   printPaging(data.pageMaker, $(".pagination"));
		   //$("#modifyModal").modal('hide');
	   });
   }

   var printPaging = function(pageMaker, target){
	      var str = "";
	      if(pageMaker.prev){
	         str +="<li><a href='"+(pageMaker.startPage-1)+"'><< </a></li>";		         
	      }
	      for(var i=pageMaker.startPage, len = pageMaker.endPage; i<=len; i++){
	         var strClass= pageMaker.cri.page == i?'class=active' : '';
	         str += "<li "+strClass+"><a href='"+i+"'>"+i+"</a></li>";
	      }
	      if(pageMaker.next){
	         str += "<li><a href = '"+(pageMaker.endPage+1)+"'> >> </a></li>";
	      }
	      target.html(str); 
	   }   
	   
	var printData = function (replyArr, target, templateObject) {
		var source=$("#template").html();
		var template = Handlebars.compile(source);
		var html = template(replyArr);
		$('.replyLi').remove();
		target.after(html);	
	}
	
	</script>
</body>
</html>
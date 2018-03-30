<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ page session="false" %>
<%@include file="../include/header.jsp"%>
<script language="JavaScript" type="text/javascript" src="resources/plugins/jquery/jquery.min.js"></script>

<!-- Main content -->
<section class="content">
	<div class="row">
		<!-- left column -->
		<div class="col-md-12">
			<!-- general form elements -->
		
				<div class="box box-info">
					<div class="box-header with-border">
						<h3 class="box-title">Read Board</h3>
						<div>
							<form role="form" method="post">
								<input type="hidden" name="bno" value="${boardVO.bno}">
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
	</div>
	<!-- /.row -->
</section>
<!-- /.content -->
<!-- /.content-wrapper -->

<%@include file="../include/footer.jsp"%>

<script>
	
   $(document).ready(function(){
      var formObj = $("form[role='form']");
      console.log(formObj);
      $(".btn-warning").on("click", function(){
         formObj.attr("action", "/board/modify");
         formObj.attr("method", "get");
         formObj.submit();
      });
      $(".btn-danger").on("click", function(){
         formObj.attr("action", "/board/remove");
         formObj.submit();
      });
      $(".btn-primary").on("click", function(){
         self.location = "/board/listAll";
      });
   });
</script>


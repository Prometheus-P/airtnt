<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/javascript">
		alert("${msg}");
		var url = "${url}";
		if(url == "stay"){
			window.history.back();
		}else{
			location.href=url;
		}
		//history.back(-2)
</script>	
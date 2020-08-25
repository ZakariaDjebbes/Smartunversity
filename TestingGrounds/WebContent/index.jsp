<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  action="CallServlet" method="post" enctype="multipart/form-data">
		<label>Username</label>
		<input type="text" name="user">
		<label>Password</label>
		<input type="password" name="pass">
		<label>Fichier justificiation</label>
		<input type="file" name="file">
		<input type="submit" value="Submit">
	</form>
</body>
</html>
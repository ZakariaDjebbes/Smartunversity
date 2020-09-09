<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-light navbar-expand-lg fixed-top bg-white clean-navbar">
	<div class="container">
		<a class="navbar-brand logo" href="index.jsp">
			<img src="assets/img/Logo/logo.png" style="width: 50px;" class="nav-brand-img">
			Faculté&nbsp;<span class="text-success"><strong>NTIC</strong></span>&nbsp;
		</a>
		<button class="navbar-toggler" data-toggle="collapse" data-target="#navcol-1">
			<span class="sr-only">Toggle navigation</span><span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navcol-1">
			<ul class="nav navbar-nav ml-auto">
				<li class="nav-item" role="presentation">
					<a class="nav-link" href="index.jsp">Acceuil</a>
				</li>
				<li class="nav-item" role="presentation">
					<a class="nav-link" href="nous-contacter.jsp">Nous contacter</a>
				</li>
				<li class="nav-item" role="presentation">
					<a class="nav-link" href="login.jsp">Se connecter</a>
				</li>
				<li class="nav-item dropdown">
					<a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#">
						<i class="icon-globe fa-lg"></i>
					</a>
					<div class="dropdown-menu" role="menu">
						<a class="dropdown-item" href="#">Français</a>
						<a class="dropdown-item" href="#">English</a>
					</div>
				</li>
			</ul>
		</div>
	</div>
</nav>
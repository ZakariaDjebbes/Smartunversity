<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="shared/keepLogged.jsp" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>About Us - Brand</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
    <link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/Data-Table.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.15/css/dataTables.bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css">
    <link rel="stylesheet" href="assets/css/Pretty-Search-Form.css">
    <link rel="stylesheet" href="assets/css/style.css">
</head>

<body>
	<jsp:include page="shared/header.jsp"></jsp:include>
    <main class="page">
        <section class="clean-block clean-form dark">
            <div class="container">
                <div class="block-heading">
                    <h1 class="text-success">Nous Contacter</h1>
                </div>
                <div class="row">
                    <div class="col-12 col-md-6">
                        <p class="text-center text-secondary">Formulaire de contact</p>
                        <form class="form-special">
                            <div class="form-group"><label>Nom</label><input class="form-control" type="text" placeholder="Votre nom"></div>
                            <div class="form-group"><label>Email</label><input class="form-control" type="text" placeholder="exmple@exemple.exp"></div>
                            <div class="form-group"><label>Sujet</label><input class="form-control" type="text" placeholder="Le sujet de votre contact"></div>
                            <div class="form-group"><label>Message</label><textarea class="form-control" placeholder="Donnez plus d'informations..."></textarea></div>
                            <div class="form-group"><button class="btn btn-outline-success btn-block" type="button">Envoyer</button></div>
                        </form>
                    </div>
                    <div class="col-12 col-md-6 col-border-left col-border-top-sm">
                        <p class="text-center text-secondary">Retrouvez nous sur goole Maps</p><iframe allowfullscreen="" frameborder="0" width="100%" height="400" src="https://www.google.com/maps/embed/v1/place?key=AIzaSyBDYzmh4BZ7H_FLAYlfA0mTCnyoGOArtQk&amp;q=Universite+Constantine+2+Abdelhamid+Mehri&amp;zoom=14"></iframe>
                        <ul
                            class="list-unstyled text-secondary">
                            <li class="text-left"><i class="fa fa-location-arrow fa-lg map-icon"></i>&nbsp;Universite Constantine 2 Abdelhamid Mehri -Nouvelle Ville, Constantine, AlgÃ©rie.</li>
                            <li><i class="fa fa-phone fa-lg map-icon"></i>0526653212</li>
                            <li><i class="fa fa-envelope-o fa-lg map-icon"></i>Zakaria.Djebbes@gmail.com</li>
                            </ul>
                    </div>
                </div>
            </div>
        </section>
    </main>
	<jsp:include page="shared/footer.jsp"></jsp:include>
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.15/js/dataTables.bootstrap.min.js"></script>
    <script src="assets/js/smoothproducts.min.js"></script>
    <script src="assets/js/theme.js"></script>
    <script src="assets/js/Table-With-Search.js"></script>
</body>

</html>
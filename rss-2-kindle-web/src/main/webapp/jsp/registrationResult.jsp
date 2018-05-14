<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>RSS-2-KINDLE Service</title>
    <meta name="viewport" content="width = device-width, initial-scale = 1.0">

    <!-- Custom fonts for this template -->
    <link href="../vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">

    <!-- Bootstrap -->
    <link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom css -->
    <link href="../css/signin.css" rel="stylesheet">
    <link href="../css/freelancer.min.css" rel="stylesheet">

</head>

<body id="page-top">
<div class="container">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg bg-secondary fixed-top text-uppercase" id="mainNav">
        <div class="container">
            <a class="navbar-brand js-scroll-trigger" href="../index.html#page-top">RSS-2-KINDLE</a>
            <button class="navbar-toggler navbar-toggler-right text-uppercase bg-primary text-white rounded" type="button"
                    data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive"
                    aria-expanded="false" aria-label="Toggle navigation">
                Menu
                <i class="fa fa-bars"></i>
            </button>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item mx-0 mx-lg-1">
                        <a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="login">Sign In</a>
                    </li>
                    <li class="nav-item mx-0 mx-lg-1">
                        <a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="../index.html#portfolio">Portfolio</a>
                    </li>
                    <li class="nav-item mx-0 mx-lg-1">
                        <a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="../index.html#about">About</a>
                    </li>
                    <li class="nav-item mx-0 mx-lg-1">
                        <a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger"
                           href="../index.html#contact">Contact</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <header class="masthead bg-primary text-white text-center">
        <div class="container">
            <h1>Thank you for using RSS-2-KINDLE service!</h1>
            <p class="lead">User <span style="color: red;">${username}</span> has been registered successfully.
                The confirmation will be sent to email <span style="color: red;">${email}</span>.
                You can start working with your account right now if you sign in</p>
            <div class="row">
                <div class="col-lg-8">
                    <p><a id="btn_signin" class="btn btn-outline-light btn-block btn-lg" href="login" role="button">Sign in</a></p>
                </div>
            </div>
        </div>
    </header>

    <!-- Footer -->
    <footer class="footer text-center">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-5 mb-lg-0">
                    <h4 class="text-uppercase mb-4">Location</h4>
                    <p class="lead mb-0">Wellington
                        <br>New Zealand, 6022</p>
                </div>
                <div class="col-md-4 mb-5 mb-lg-0">
                    <h4 class="text-uppercase mb-4">Around the Web</h4>
                    <ul class="list-inline mb-0">
                        <li class="list-inline-item">
                            <a class="btn btn-outline-light btn-social text-center rounded-circle" href="#">
                                <i class="fa fa-fw fa-facebook"></i>
                            </a>
                        </li>
                        <%--
                                            <li class="list-inline-item">
                                                <a class="btn btn-outline-light btn-social text-center rounded-circle" href="#">
                                                    <i class="fa fa-fw fa-google-plus"></i>
                                                </a>
                                            </li>
                        --%>
                        <li class="list-inline-item">
                            <a class="btn btn-outline-light btn-social text-center rounded-circle" href="#">
                                <i class="fa fa-fw fa-twitter"></i>
                            </a>
                        </li>
                        <li class="list-inline-item">
                            <a class="btn btn-outline-light btn-social text-center rounded-circle" href="#">
                                <i class="fa fa-fw fa-linkedin"></i>
                            </a>
                        </li>
                        <%--
                                            <li class="list-inline-item">
                                                <a class="btn btn-outline-light btn-social text-center rounded-circle" href="#">
                                                    <i class="fa fa-fw fa-dribbble"></i>
                                                </a>
                                            </li>
                        --%>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h4 class="text-uppercase mb-4">About Roundkick Studio</h4>
                    <p class="lead mb-0">Wellcome to <a href="https://roundkick.studio">Roundkick Studio</a>. We develop
                        software for people</p>
                </div>
            </div>
        </div>
    </footer>

    <div class="copyright py-4 text-center text-white">
        <div class="container">
            <small>Copyright &copy; <a href="https://roundkick.studio">Roundkick Studio</a> 2018</small>
        </div>
    </div>

    <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
    <div class="scroll-to-top d-lg-none position-fixed ">
        <a class="js-scroll-trigger d-block text-center text-white rounded" href="#page-top">
            <i class="fa fa-chevron-up"></i>
        </a>
    </div>

</div> <!-- /container -->

</body>
</html>
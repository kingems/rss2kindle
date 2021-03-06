<%--
  User: eurohlam
  Date: 2/12/17
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="_include.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>RSS-2-KINDLE Run Services </title>
    <meta name="viewport" content="width = device-width, initial-scale = 1.0">

    <!-- Bootstrap -->
    <link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="../vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet"
          type="text/css">

    <!-- Theme CSS -->
    <link href="../css/freelancer.min.css" rel="stylesheet">

    <!-- Custom css -->
    <link href="../css/simple-sidebar.css" rel="stylesheet">

    <!-- JQuery -->
    <script src="../vendor/jquery/jquery.min.js"></script>

</head>
<body id="page-top">
<script>
    var rootURL = 'rest/service/${username}';
    $(document).ready(function () {
        $("#run_all").click(function () {
            runPollingForUser();
        });

        //Show ajax error messages
        $(document).ajaxError(function (event, request, settings, thrownError) {
            $('#alerts_panel').html('<div class="alert alert-danger alert-dismissible" role="alert">'
                + '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'
                + '<strong>Error! </strong>Ajax error: code:' + request.status + ' calling url: ' + settings.url + ' method: ' + settings.type + ' ' + thrownError + '</div>');
        });
    });

    function runPollingForUser() {
        $.getJSON(rootURL, function (data) {
            $('#alerts_panel').html('<div class="alert alert-success alert-dismissible" role="alert">'
                + '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'
                + '<strong>Success! </strong>Polling process has been launched: ' + data.status + '</div>');
            return true;
        });
    }
</script>

<div class="container-fluid">
    <%@include file="_header.jsp" %>

    <div id="wrapper" class="row">

        <%@include file="_aside.jsp" %>

        <main id="page-content-wrapper" style="padding-bottom: 10rem; padding-left: 2rem;">
            <div class="container-fluid">
                <h1 class="page-header">Polling subscriptions</h1>
                <section class="container-fluid">
                    <div id="alerts_panel" class="row"></div>
                    <div class="alert alert-info row" role="alert">
                        All subscriptions are scheduled for polling every day at 02:00 am.
                        If you wish to poll you subscriptions right now just push the button below
                    </div>
                    <div class="text-center row">
                        <button id="run_all" type="button" class="btn btn-primary btn-xl">
                            <i class="fa fa-download mr-2"></i>
                            Poll my subscriptions immediately
                        </button>
                    </div>
                </section>
            </div>
        </main>
    </div>

    <jsp:include page="_footer.jsp"/>
</div>


<!-- Bootstrap core JavaScript -->
<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Plugin JavaScript -->
<script src="../vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="../vendor/magnific-popup/jquery.magnific-popup.min.js"></script>

<!-- Custom scripts for this template -->
<script src="../js/freelancer.min.js"></script>

</body>
</html>
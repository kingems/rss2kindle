<%--
  User: eurohlam
  Date: 19/10/2017
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="_include.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>RSS-2-KINDLE Subscribers Management</title>

    <meta name="viewport" content="width = device-width, initial-scale = 1.0">
    <security:csrfMetaTags/>

    <!-- Bootstrap -->
    <link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="../vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">

    <!-- Theme CSS -->
    <link href="../css/freelancer.css" rel="stylesheet">

    <!-- Custom css -->
    <link href="../css/simple-sidebar.css" rel="stylesheet">

    <!-- JQuery -->
    <script src="../vendor/jquery/jquery.min.js"></script>

</head>
<body id="page-top">
<script>
    var username = '${username}';
    var rootURL = 'rest/profile/';
    var userData;
    var csrf_token = $("meta[name='_csrf']").attr("content");
    var csrf_header = $("meta[name='_csrf_header']").attr("content");
    var csrf_headers = {};
    csrf_headers[csrf_header] = csrf_token;

    $(document).ready(function () {

        reloadSubscribersTable();

        //show subscribers table for edit
        function reloadSubscribersTable() {
            $.getJSON(rootURL + username, function (data) {
                userData = data;
                var table = '<table class="table table-hover"><thead>' +
                    '<tr><th>#</th>' +
                    '<th>name</th>' +
                    '<th>email</th>' +
                    '<th>status</th>' +
                    '<th>action</th></tr></thead><tbody>';

                $.each(data.subscribers, function (i, item) {
                    var tr;
                    if (item.status === 'suspended')
                        tr = '<tr class="table-danger"><td>';
                    else
                        tr = '<tr class="table-light"><td>';

                    table += tr + (i + 1) + '</td><td>'
                        + item.name + '</td><td>'
                        + item.email + '</td><td>'
                        + item.status + '</td><td>'
                        + '<div class="btn-group" role="group">'
                        + '<button id="btn_update" type="button" class="btn btn-primary" data-toggle="modal" data-target="#updateModal" data-name="' + item.name + '" data-email="' + item.email + '" data-status="' + item.status + '">Update</button>';

                    if (item.status === 'suspended')
                        table += '<button id="btn_resume" type="button" class="btn btn-warning" data-toggle="modal" data-target="#resumeModal" data-name="' + item.name + '" data-email="' + item.email + '">Resume</button>'
                    else
                        table += '<button id="btn_suspend" type="button" class="btn btn-warning" data-toggle="modal" data-target="#suspendModal" data-name="' + item.name + '" data-email="' + item.email + '">Suspend</button>';

                    table += '<button id="btn_remove" type="button" class="btn btn-danger" data-toggle="modal" data-target="#removeModal" data-name="' + item.name + '" data-email="' + item.email + '">Remove</button></div></td></tr>';

                });
                table += '</tbody></table>';
                $('#edit').html(table);
            });
        }

        //activate the first tab by default
        //TODO: change active tab in depends on input parameter
        $('#operationsTab a:first').tab('show');

        //show modal for update
        $('#updateModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget); // Button that triggered the modal
            var email = button.data('email'); // Extract info from data-* attributes
            var name = button.data('name');
            var modal = $(this);
            modal.find('.modal-title').text('Update subscriber ' + name);
            $('#update_subscriber_name').val(name);
            $('#update_subscriber_email').val(email);
            $('#update_subscriber_status').val(button.data('status'));

            var rssTable = '';
            $.each(userData.subscribers, function (i, item) {
                if (item.email === email) {
                    var rss = item.rsslist;
                    for (j = 0; j < rss.length; j++) {
                        rssTable = rssTable + '<option value="' + rss[j].rss + '">' + rss[j].rss + '</option>';
                    }
                }
            });
            $('#update_subscriber_rsslist').html(rssTable);
        });

        $('#btn_update_subscriber_addrss').click(function (event) {
            var _update_subscriber_addrss = $('#update_subscriber_addrss');
            var rss = _update_subscriber_addrss.val();
            _update_subscriber_addrss.popover(
                {
                    content: 'Entered text does not look like a valid URL. Please correct it and try again',
                    trigger: 'manual',
                    placement: 'auto'
                });
            _update_subscriber_addrss.popover('hide');
            if (validateURL(rss)) {
                $('#update_subscriber_rsslist').append('<option value = "' + rss + '">' + rss + '</option>');
            }
            else {
                _update_subscriber_addrss.data('bs.popover').config.content = rss + ' does not look like a valid URL. Please correct it and try again';
                _update_subscriber_addrss.popover('show');
            }
        });

        $('#btn_update_subscriber_deleterss').click(function (event) {
            $('#update_subscriber_rsslist option:selected').remove();
        });


        //show modal for suspend
        $('#suspendModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget); // Button that triggered the modal
            var email = button.data('email'); // Extract info from data-* attributes
            var name = button.data('name');
            var modal = $(this);
            modal.find('.modal-title').text('Suspend subscriber ' + name);
            $('#suspend_subscriber_email').val(email);
            $('#suspend_subscriber_name').val(name);
            $('#suspend_alert_box').html('<strong>Warning!</strong> You are going to suspend subscriber <strong>' + name + '</strong> associated with email <strong>' + email + '</strong>.</br>Do you confirm?');
        });

        //show modal for resume
        $('#resumeModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget); // Button that triggered the modal
            var email = button.data('email'); // Extract info from data-* attributes
            var name = button.data('name');
            var modal = $(this);
            modal.find('.modal-title').text('Resume subscriber ' + name);
            $('#resume_subscriber_email').val(email);
            $('#resume_subscriber_name').val(name);
            $('#resume_alert_box').html('<strong>Warning!</strong> You are going to resume subscriber <strong>' + name + '</strong> associated with email <strong>' + email + '</strong>.</br>Do you confirm?');
        });

        //show modal for remove
        $('#removeModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget); // Button that triggered the modal
            var email = button.data('email'); // Extract info from data-* attributes
            var name = button.data('name');
            var modal = $(this);
            modal.find('.modal-title').text('Remove subscriber ' + name);
            $('#remove_subscriber_name').val(name);
            $('#remove_subscriber_email').val(email);
            $('#remove_alert_box').html('<strong>Warning!</strong> You are going to remove subscriber <strong>' + name + '</strong> associated with email <strong>' + email + '</strong>.</br>Do you confirm?');
        });

        //update subscriber on submit
        $('#update_subscriber_form').submit(function (e) {
            e.preventDefault();
            var email = $('#update_subscriber_email').val();
            var name = $('#update_subscriber_name').val();
            var status = $('#update_subscriber_status').val();
            //validate rss list
            var _update_subscriber_rsslist = $('#update_subscriber_rsslist');
            _update_subscriber_rsslist.popover('dispose');
            if ($('#update_subscriber_rsslist option').length === 0) {
                _update_subscriber_rsslist.popover(
                    {
                        content: 'At least one RSS is required',
                        trigger: 'manual',
                        placement: 'auto'
                    });
                _update_subscriber_rsslist.popover('show');

                return false;
            }

            var updateJson = '{' +
                'email: "' + email + '",' +
                'name: "' + name + '",' +
                'status: "' + status + '",' +
                'rsslist: [ ';
            $('#update_subscriber_rsslist option').each(function () {
                updateJson += '{ rss: "' + $(this).val() + '", status: "active"},';
            });
            updateJson = updateJson.substr(0, updateJson.length - 1) + ']}';

            $.ajax({
                url: rootURL + username + '/update',
                contentType: 'application/json',
                type: 'PUT',
                data: updateJson,
                dataType: 'json',
                headers: csrf_headers
            })
                .done(function (data) {
                    showAlert('success', 'Subscriber <strong>' + name + '</strong> has been updated successfully');
                    return true;
                })
                .fail(function () {
                    showAlert('error', 'Subscriber <strong>' + name + '</strong> update fail');
                    return false;
                })
                .always(function () {
                    $('#updateModal').modal('hide');
                    reloadSubscribersTable();
                });
        });

        //suspend subscriber on submit
        $('#suspend_subscriber_form').submit(function (e) {
            var email = $('#suspend_subscriber_email').val();
            var name = $('#suspend_subscriber_name').val();
            e.preventDefault();
            $.getJSON(rootURL + username + '/' + email + '/suspend', function (data) {
            })
                .done(function () {
                    showAlert('success', 'Subscriber <strong>' + name + '</strong> has been suspended');
                    return true;
                })
                .fail(function () {
                    showAlert('error', 'Subscriber <strong>' + name + '</strong> suspending fail');
                    return false;
                })
                .always(function () {
                    $('#suspendModal').modal('hide');
                    reloadSubscribersTable();
                });
        });

        //resume subscriber on submit
        $('#resume_subscriber_form').submit(function (e) {
            var email = $('#resume_subscriber_email').val();
            var name = $('#resume_subscriber_name').val();
            e.preventDefault();
            $.getJSON(rootURL + username + '/' + email + '/resume', function (data) {
            })
                .done(function () {
                    showAlert('success', 'Subscriber <strong>' + name + '</strong> has been resumed');
                    return true;
                })
                .fail(function () {
                    showAlert('error', 'Subscriber <strong>' + name + '</strong> resuming fail');
                    return false;
                })
                .always(function () {
                    $('#resumeModal').modal('hide');
                    reloadSubscribersTable();
                });

        });

        //add new subscriber on submit
        $('#new_subscriber_form').submit(function (e) {
            e.preventDefault();
            var _new_subscriber_email = $('#new_subscriber_email');
            var _new_subscriber_rsslist = $('#new_subscriber_rsslist');
            var email = _new_subscriber_email.val();
            var name = $('#new_subscriber_name').val();
            var status = $('#new_subscriber_status').val();

            //create validation popovers
            _new_subscriber_email.popover(
                {
                    content: 'Subscriber with such email already exists',
                    trigger: 'manual',
                    placement: 'auto'
                });
            _new_subscriber_rsslist.popover(
                {
                    content: 'At least one RSS is required',
                    trigger: 'manual',
                    placement: 'auto'
                });

            //validate email
            var isEmailValid = true;
            $.each(userData.subscribers, function (i, item) {
                if (item.email === email) {
                    //we need to update content directly via jquery
                    _new_subscriber_email.data('bs.popover').config.content = 'Subscriber with email ' + email + ' already exists';
                    isEmailValid = false;
                    return false;
                }
            });
            if (!isEmailValid) {
                _new_subscriber_email.popover('show');
                return false;
            }
            _new_subscriber_email.popover('hide');

            //validate rss list
            if ($('#new_subscriber_rsslist option').length === 0) {
                _new_subscriber_rsslist.popover('show');
                return false;
            }
            _new_subscriber_rsslist.popover('hide');

            //prepare json
            var updateJson = '{' +
                'email: "' + email + '",' +
                'name: "' + name + '",' +
                'status: "active",' +
                'rsslist: [ ';
            $('#new_subscriber_rsslist option').each(function () {
                updateJson += '{ rss: "' + $(this).val() + '", status: "active"},';
            });
            updateJson = updateJson.substr(0, updateJson.length - 1) + ']}';

            $.ajax({
                url: rootURL + username + '/new',
                contentType: 'application/json',
                type: 'PUT',
                data: updateJson,
                dataType: 'json',
                headers: csrf_headers
            })
                .done(function () {
                    showAlert('success', 'New subscriber <strong>' + name + '</strong> has been added successfully');
                    return true;
                })
                .fail(function () {
                    showAlert('error', 'New subscriber <strong>' + name + '</strong> creation fail');
                    return false;
                })
                .always(function () {
                    reloadSubscribersTable();
                });
        });

        $('#btn_new_subscriber_addrss').click(function (event) {
            var _new_subscriber_addrss=$('#new_subscriber_addrss');
            var rss = _new_subscriber_addrss.val();
            _new_subscriber_addrss.popover(
                {
                    content: 'Entered text does not look like a valid URL. Please correct it and try again',
                    trigger: 'manual',
                    placement: 'auto'
                });
            _new_subscriber_addrss.popover('hide');
            if (validateURL(rss)) {
                $('#new_subscriber_rsslist').append('<option value = "' + rss + '">' + rss + '</option>');
            }
            else {
                _new_subscriber_addrss.data('bs.popover').config.content = rss + ' does not look like a valid URL. Please correct it and try again';
                _new_subscriber_addrss.popover('show');
            }
        });

        $('#btn_new_subscriber_deleterss').click(function (event) {
            $('#new_subscriber_rsslist option:selected').remove();
        });

        //remove subscriber on submit
        $('#remove_subscriber_form').submit(function (e) {
            var email = $('#remove_subscriber_email').val();
            var name = $('#remove_subscriber_name').val();
            e.preventDefault();
            $.ajax({
                url: rootURL + username + '/' + email + '/remove',
                type: 'DELETE',
                dataType: 'json',
                headers: csrf_headers,
                success: function (data) {
                }
            })
                .done(function () {
                    showAlert('success', 'Subscriber <strong>' + name + '</strong> has been removed');
                    return true;
                })
                .fail(function () {
                    showAlert('error', 'Subscriber <strong>' + name + '</strong> removing fail');
                    return false;
                })
                .always(function () {
                    $('#removeModal').modal('hide');
                    reloadSubscribersTable();
                });
        });

        //Show ajax error messages
        $(document).ajaxError(function (event, request, settings, thrownError) {
            showAlert('error', 'Ajax error: code:' + request.status + ": " + request.responseText + " calling url: " + settings.url + " method: " + settings.type + " " + thrownError);
        });


    });//end of $(document).ready(function ())

    function showAlert(type, text) {
        if (type == 'error') {
            $('#alerts_panel').html('<div class="alert alert-danger alert-dismissible" role="alert">'
                + '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'
                + '<strong>Error! </strong>' + text + '</div>');
        } else if (type == 'warning') {
            $('#alerts_panel').html('<div class="alert alert-warning alert-dismissible" role="alert">'
                + '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'
                + '<strong>Warning! </strong>' + text + '</div>');
        } else {
            $('#alerts_panel').html('<div class="alert alert-success alert-dismissible" role="alert">'
                + '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'
                + '<strong>Success! </strong> ' + text + '</div>');
        }
    }

    function validateURL(url) {
        var regexp = /https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/g;
        return url.match(regexp);
    }

</script>

<div class="container-fluid">
    <%@include file="_header.jsp" %>

    <div id="wrapper" class="row">

        <%@include file="_aside.jsp"%>

        <main id="page-content-wrapper">
            <ul class="nav nav-tabs" id="operationsTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link" id="edit-tab" data-toggle="tab" href="#edit" role="tab" aria-controls="profile"
                       aria-selected="false">Edit subscribers</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" id="new-tab" data-toggle="tab" href="#new" role="tab"
                       aria-controls="home" aria-selected="true">New subscriber</a>
                </li>
            </ul>
            <div class="row" style="padding-top: 3rem; padding-bottom: 15rem; padding-left: 2rem">
                <div class="tab-content" id="operationsTabContent">
                    <div id="alerts_panel"></div>
                    <div class="tab-pane fade active"  id="new" role="tabpanel" aria-labelledby="new-tab">
                        <h2 class="sub-header">Add new subscriber</h2>
                        <form method="get" id="new_subscriber_form" action="#page-top">
                            <div class="form-group">
                                <label for="new_subscriber_email">Email</label>
                                <input type="email" id="new_subscriber_email" required class="form-control"/>
                            </div>
                            <div class="form-group">
                                <label for="new_subscriber_name">Name</label>
                                <input type="text" id="new_subscriber_name" required class="form-control"/>
                            </div>
                            <div class="form-group">
                                <label for="new_subscriber_rsslist">Subscriptions</label>
                                <select class="form-control" id="new_subscriber_rsslist" size="5"></select>
                                <div class="form-group">
                                    <label for="new_subscriber_addrss" class="control-label">Add new subscription
                                        (RSS):</label>
                                    <input type="url" class="form-control" id="new_subscriber_addrss"/>
                                    <div class="btn-group-xs" role="group">
                                        <button type="button" class="btn btn-primary" id="btn_new_subscriber_addrss">+
                                        </button>
                                        <button type="button" class="btn btn-primary" id="btn_new_subscriber_deleterss">
                                            -
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <%--<label for="starttime">Start date</label>--%>
                                <%--<p><input type="date" id="starttime" class="form-control"/></p>--%>
                                <input type="submit" value="Create" class="btn btn-primary"/>
                            </div>
                        </form>
                    </div>
                    <div class="tab-pane fade" id="edit" role="tabpanel" aria-labelledby="edit-tab">
                        <h2 class="sub-header">Edit subscriber</h2>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <%@include file="_footer.jsp" %>
</div>

<!--Modal windows -->
<!-- Update modal -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="updateModalLabel">Update subscriber and subscriptions</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <form method="get" action="#" id="update_subscriber_form">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="update_subscriber_email" class="control-label">Subscriber email:</label>
                        <input type="email" class="form-control" id="update_subscriber_email" readonly/>
                        <label for="update_subscriber_status" class="control-label">Status:</label>
                        <input type="text" class="form-control" id="update_subscriber_status" readonly/>
                    </div>
                    <div class="form-group">
                        <label for="update_subscriber_name" class="control-label">Subscriber name:</label>
                        <input type="text" class="form-control" id="update_subscriber_name" required/>
                    </div>
                    <div class="form-group">
                        <label for="update_subscriber_rsslist" class="control-label">Subscriptions:</label>
                        <select class="form-control" id="update_subscriber_rsslist" size="7"></select>
                        <div class="form-group">
                            <label for="update_subscriber_addrss" class="control-label">Add new subscription
                                (RSS):</label>
                            <input type="url" class="form-control" id="update_subscriber_addrss"/>
                            <div class="btn-group-xs" role="group">
                                <button type="button" class="btn btn-primary" id="btn_update_subscriber_addrss">+
                                </button>
                                <button type="button" class="btn btn-primary" id="btn_update_subscriber_deleterss">-
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Update</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Suspend modal -->
<div class="modal fade" id="suspendModal" tabindex="-1" role="dialog" aria-labelledby="suspendModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="suspendModalLabel">Suspend subscriber</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <form method="get" id="suspend_subscriber_form" action="#">
                <div class="modal-body">
                    <div id="suspend_alert_box" class="alert alert-warning" role="alert"></div>
                    <input hidden type="text" id="suspend_subscriber_name"/>
                    <input hidden type="email" id="suspend_subscriber_email"/>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary" name="btn_suspend">Suspend</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Resume modal -->
<div class="modal fade" id="resumeModal" tabindex="-1" role="dialog" aria-labelledby="resumeModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="resumeModalLabel">Suspend subscriber</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <form method="get" id="resume_subscriber_form" action="#">
                <div class="modal-body">
                    <div id="resume_alert_box" class="alert alert-warning" role="alert"></div>
                    <input hidden type="text" id="resume_subscriber_name"/>
                    <input hidden type="email" id="resume_subscriber_email"/>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary" name="btn_resume">Resume</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Remove modal -->
<div class="modal fade" id="removeModal" tabindex="-1" role="dialog" aria-labelledby="removeModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="removeModalLabel">Remove subscriber</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <form method="get" id="remove_subscriber_form" action="#">
                <div class="modal-body">
                    <div id="remove_alert_box" class="alert alert-danger" role="alert"></div>
                    <input hidden type="text" id="remove_subscriber_name"/>
                    <input hidden type="email" id="remove_subscriber_email"/>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary" id="btn_remove">Remove</button>
                </div>
            </form>
        </div>
    </div>
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
<%@ page import="org.roag.model.Roles" %><%--
Created by eurohlam on 12.05.18
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<aside id="sidebar-wrapper">
    <ul class="nav flex-column sidebar-nav text-uppercase">
        <%
            if (roles.contains(Roles.ROLE_ADMIN.toString())) {
        %>
                <li class="nav-item"><a class="nav-link" href="admin/users">Users</a></li>
        <%
            }
        %>
        <li class="nav-item"><a class="nav-link" href="profile">My Profile</a></li>
        <li class="nav-item"><a class="nav-link" href="subscribers">Subscribers</a></li>
        <li class="nav-item"><a class="nav-link" href="service">Services</a></li>
    </ul>
</aside>

<%@page isErrorPage="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="headernologout.html" %>

<div id="content">
    <div id="trader">
        <h2>An error occurred.</h2>
        <% if (session.getAttribute("error") != null) {%> 
        <p class="error"><%= session.getAttribute("error")%></p>
        <% session.setAttribute("error", null); } else {%>
        <p class="error">An error occure, please try again to connect.</p>
        <%}%>
    </div>
</div>
<%@include file="footer.html" %>
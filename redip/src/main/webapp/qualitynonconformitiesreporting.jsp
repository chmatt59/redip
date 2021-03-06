<%-- 
    Document   : qualitynonconformitiesreporting
    Created on : 2 oct. 2012, 22:47:23
    Author     : bcivel
--%>

<%@page import="com.redip.service.impl.QualityNonconformitiesReportingServiceImpl"%>
<%@page import="com.redip.dao.IQualityNonconformitiesReportingDAO"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="com.redip.dao.impl.QualityNonconformitiesReportingDAOImpl"%>
<%@page import="com.redip.service.IQualityNonconformitiesReportingService"%>
<%@page import="java.awt.Component"%>
<%@page import="java.awt.BorderLayout"%>
<%@page import="javax.swing.JFrame"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="com.keypoint.PngEncoder"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.mail.util.ByteArrayDataSource"%>
<%@page import="javax.activation.DataSource"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="style.css">
        <link type="text/css" rel="stylesheet" href="css/jquery-te-1.4.0.css">
        <link type="text/css" rel="stylesheet" href="css/jPaginate/style.css">
        <style media="screen" type="text/css">
            @import "css/demo_page.css";
            @import "css/demo_table.css";
            @import "css/demo_table_jui.css";
            @import "css/themes/base/jquery-ui.css";
            @import "css/themes/smoothness/jquery-ui-1.7.2.custom.css";
        </style>
        <link rel="shortcut icon" type="image/x-icon" href="pictures/favicon.ico" >
        <script type="text/javascript" src="javascript/jquery.js"></script>
        <script type="text/javascript" src="javascript/jquery-ui.min.js"></script>
        <script type="text/javascript" src="javascript/jquery.jeditable.mini.js"></script>
        <script type="text/javascript" src="javascript/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="javascript/jquery.dataTables.editable.js"></script>
        <script type="text/javascript" src="javascript/jquery.validate.min.js"></script>
        <script type="text/javascript" src="javascript/jquery.paginate.js"></script>
        <script type="text/javascript" src="javascript/jquery.datepicker.addons.js"></script>
        <script type="text/javascript" src="javascript/jquery-te-1.4.0.min.js" charset="utf-8"></script>
    </head>
    <body id="wrapper">
        <script>
            $(function() {
                $( 'input' ).filter('.dateClass').datepicker({dateFormat: 'yy-mm-dd'});
                
            });
        </script>
        <%@ include file="static.jsp" %>  

        <%
                
            String fromWeek = "";
            if (request.getParameter("fromWeek") != null) {
                fromWeek = request.getParameter("fromWeek");
            }
            String toWeek = "";
            if (request.getParameter("toWeek") != null) {
                toWeek = request.getParameter("toWeek");
            }
            
            ApplicationContext appContext = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
            IQualityNonconformitiesReportingService nonconformitiesReportingService = appContext.getBean(IQualityNonconformitiesReportingService.class);
            
            
        %>
        <br>
        <div class="ncdescriptionfirstpart" style="vertical-align: central">
        <form action="qualitynonconformitiesreporting.jsp" method="get" name="reporting">
            <table>
                <tr><td id="wob" style="width: 50px; font-weight: bold;">From Week</td>
                    <td class="simpleline" style="width:127px;">
                        <select name="fromWeek" style="width:127px;" 
                          id="fromWeek" class="wob" value="<%=fromWeek%>">
                            <option value="1">sem39</option>
                            <option value="2">sem40</option>
                            <option value="3">sem41</option>
                            <option value="4">sem42</option>
                            <option value="5">sem43</option>
                        </select>
                        
                    </td>
                    <td class="wob" style="width: 70px; font-weight: bold;">To Week</td>
                    <td class="simpleline" style="width:127px;">
                        <select name="toWeek" style="width:127px;" 
                          id="toWeek" class="wob" value="<%=toWeek%>">
                        <option value="1">sem39</option>
                            <option value="2">sem40</option>
                            <option value="3">sem41</option>
                            <option value="4">sem42</option>
                            <option value="5">sem43</option>
                        </select>
                    </td>
                    <td  class="wob"><input id="loadbutton" class="button" type="submit" name="Load" value="Load"></td>
                </tr>
            </table>    
        </form>
  </div>
                        <br>
     <div style="float:left; width:1200px" >
        <div style="float:left"><img src="GeneratePicture?graph=nc_opened&fromWeek=<%=fromWeek%>&toWeek=<%=toWeek%>">
        </div>
        <div style="float:right"><img src="GeneratePicture?graph=nc_week_opened&fromWeek=<%=fromWeek%>&toWeek=<%=toWeek%>">
        </div>
     </div>
     <div>
        <div style="float:left"><img src="GeneratePicture?graph=nc_week_closed&fromWeek=<%=fromWeek%>&toWeek=<%=toWeek%>">
        </div>
        <div style="float:right"><img src="GeneratePicture?graph=nc_week_team&fromWeek=<%=fromWeek%>&toWeek=<%=toWeek%>">
        </div>
     </div>  
    </body>
</html>

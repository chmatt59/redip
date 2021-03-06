<%-- 
    Document   : qualitynonconformities
    Created on : 23 août 2012, 13:14:26
    Author     : bcivel
--%>
<%@page import="com.redip.entity.Invariant"%>
<%@page import="com.redip.service.IInvariantService"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.Date"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.redip.entity.QualityNonconformities"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.redip.service.impl.QualityNonconformitiesServiceImpl"%>
<%@page import="com.redip.dao.impl.QualityNonconformitiesDAOImpl"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.redip.dao.IQualityNonconformitiesDAO"%>
<%@page import="com.redip.service.IQualityNonconformitiesService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>NonConformitiesRootCause</title>
        <link rel="stylesheet" type="text/css" href="style.css">
        <link type="text/css" rel="stylesheet" href="css/jquery-te-1.4.0.css">
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
        <script type="text/javascript" src="javascript/jquery.datepicker.addons.js"></script>
        <script type="text/javascript" src="javascript/jquery.dataTables.rowReordering.js"></script>
        <script type="text/javascript" src="javascript/jquery-te-1.4.0.min.js" charset="utf-8"></script>
    
        <script>
	$(function() {
		$( 'input' ).filter('.dateClass').datepicker({dateFormat: 'yy-mm-dd'});
                
	});
	</script>
        <script>
	$(function() {
		$( 'input' ).filter('.timeClass').timepicker();
	});
	</script>
<script type="text/javascript">      
            $(document).ready(function(){
                $('#nonConformityRootCause').dataTable({
                    "aaSorting": [[ 0, "desc" ]],
//                    "sDom": '<"top"p>',
                    "bServerSide": true,
                    "sAjaxSource": "NonConformityRootCause",
                    "bJQueryUI": true,
                    "bProcessing": true,
                    "bPaginate": true,
                    "bAutoWidth": false,
                    "sPaginationType": "full_numbers",
                    "bSearchable": true, "aTargets": [ 0 ],
                    "aoColumns": [
                        {"sName": "Idqualitynonconformities", "sWidth": "5%"},
                        {"sName": "ProblemTitle", "sWidth": "30%"},
                        {"sName": "ProblemDescription", "sWidth": "30%"},
                        {"sName": "Status", "sWidth": "10%"},
                        {"sName": "Severity", "sWidth": "10%"},
                        {"sName": "Edit", "sWidth": "5%"}
                    ]
                }
            ).makeEditable({
                    sAddURL: "NonConformityAddRootCause",
                    sAddHttpMethod: "POST",
                    

                    oAddNewRowButtonOptions: {
                        label: "Add Root Cause...",
                        icons: {primary:'ui-icon-plus'}
                    },
                    sDeleteHttpMethod: "POST",
                    sDeleteURL: "DeleteUser",
                    sAddDeleteToolbarSelector: ".dataTables_length",
                    oDeleteRowButtonOptions: {
                        label: "Remove",
                        icons: {primary:'ui-icon-trash'}
                    },
                    sUpdateURL: "UpdateNonConformity",
                    fnOnEdited: function(status){
                        $(".dataTables_processing").css('visibility', 'hidden');
                    },
                    oAddNewRowFormOptions: {
				title: 'Add NonConformity',
                                show: "blind",
                                hide: "explode",
                                width: "1000px"
                            },
                    "aoColumns": [
                        {   onchange: 'submit',
                            placeholder:''  },
                        {onchange: 'submit',
                            placeholder:''},
                        {onchange: 'submit',
                            placeholder:''},
                        {loadtext: 'loading...',
                            type: 'select',
                            onblur: 'submit',
                            data: "{'OPEN':'OPEN','ANALYSE':'ANALYSE','TO BE VALIDATED':'TO BE VALIDATED','PENDING':'PENDING','CLOSED':'CLOSED'}" ,
                            placeholder:''},
                        {loadtext: 'loading...',
                            type: 'select',
                            onblur: 'submit',
                            data: "{'1 - HIGH':'1 - HIGH','2 - MEDIUM':'2 - MEDIUM','3 - LOW':'3 - LOW'}" ,
                            placeholder:''}, 
                        { },
                        { },
                        { }
                    ]
                })
            });
            
        </script>
    </head>
    <body  id="wrapper">
        <%@ include file="static.jsp" %>
        <br>
        <div>
        <div style="width: 80%;  font: 90% sans-serif">
            <table id="nonConformityRootCause" class="display">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Root Cause</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Severity</th>
                        <th>Edit</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
                <br><br>
       </div><br>
       <div>
            <form id="formAddNewRow" action="#" title="Add Root Cause" style="width:350px" method="post">
                <br>
               
                <div style="width: 310px; float:left">
                    <label for="rootcauseCategory" style="font-weight:bold">rootcauseCategory</label>
                    <input id="rootcauseCategory" name="rootcauseCategory" style="width:210px;" 
                            class="ncdetailstext">
                </div>
                <div style="width: 250px; float:left">
                <label for="rootcauseDescription" style="font-weight:bold">rootcauseDescription</label>
                <input id="rootcauseDescription" name="rootcauseDescription" style="width:150px;" 
                                    class="ncdetailstext"
                                    >
                </div>
                <label for="component" style="font-weight:bold">component</label>
                <input type="text" name="component" id="component" style="width:100px"/>
                <label for="responsabilities" style="font-weight:bold">responsabilities</label>
                <input type="text" name="responsabilities" id="responsabilities" style="width:100px"/>
                
                <br /><br>
                <label for="status" style="font-weight:bold">status</label>
                <input type="text" name="status" id="status" class="ncdetailstext" style="width:400px"/>
                
                <br /><br><br>
                <div style="width: 900px; clear:both">
                <label for="severity" style="font-weight:bold">severity</label>
                <input type="text" name="severity" class="ncdetailstext" id="severity" style="width:700px;"/>
                </div>
                
                <br /><br />
                <button id="btnAddNewRowOk">Add</button>
                <button id="btnAddNewRowCancel">Cancel</button>
            </form>
        </div>

    </body>
</html>
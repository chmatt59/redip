/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.redip.servlet;

import com.redip.servlet.nonconformity.NonConformityDetails;
import com.redip.entity.QualityNonconformities;
import com.redip.entity.QualityNonconformitiesAction;
import com.redip.log.Logger;
import com.redip.service.IQualityNonconformitiesActionService;
import com.redip.service.IQualityNonconformitiesService;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Level;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 * @author bcivel
 */
public class NonConformityAction extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String echo = request.getParameter("sEcho");
        String sStart = request.getParameter("iDisplayStart");
        String sAmount = request.getParameter("iDisplayLength");
        String sCol = request.getParameter("iSortCol_0");
        String sdir = request.getParameter("sSortDir_0");
        String dir = "asc";
        String[] cols = {"Idqualitynonconformities", "Country", "Application", "ProblemCategory",
            "ProblemDescription", "StartDate", " ", " ", " ", "ImpactOrCost", "TeamContacted", "Severity", " ", " ", " ", "Status"};

        int start = 0;
        int amount = 0;
        int col = 0;

        if (sStart != null) {
            start = Integer.parseInt(sStart);
            if (start < 0) {
                start = 0;
            }
        }
        if (sAmount != null) {
            amount = Integer.parseInt(sAmount);
            if (amount < 10 || amount > 100) {
                amount = 10;
            }
        }
        if (sCol != null) {
            col = Integer.parseInt(sCol);
            if (col < 0 || col > 5) {
                col = 0;
            }
        }
        if (sdir != null) {
            if (!sdir.equals("asc")) {
                dir = "desc";
            }
        }
        String colName = cols[col];

        JSONArray data = new JSONArray(); //data that will be shown in the table

        ApplicationContext appContext = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
        IQualityNonconformitiesActionService qualityNonconformitiesService = appContext.getBean(IQualityNonconformitiesActionService.class);

//        QualityNonconformities numberOfNC = qualityNonconformitiesService.getNumberOfNonconformities();
//        List<QualityNonconformities> nonconformitieslist = qualityNonconformitiesService.getAllNonconformities(start, amount, colName, dir);
        List<QualityNonconformitiesAction> nonconformitieslist = qualityNonconformitiesService.findQualityNonconformitiesByCriteria();
        try {
            JSONObject jsonResponse = new JSONObject();

            for (QualityNonconformitiesAction listofnonconformities : nonconformitieslist) {
                JSONArray row = new JSONArray();
                //"<a href=\'javascript:popup(\"qualitynonconformitydetails.jsp?ncid="+listofnonconformities.getIdqualitynonconformities()+"\")\'>"+listofnonconformities.getIdqualitynonconformities()+"</a>"
                row.put(listofnonconformities.getPriority())
                        .put(listofnonconformities.getQualityNonconformities().getProblemTitle())
                        .put(listofnonconformities.getQualityNonconformities().getProblemDescription())
                        //                        .put(listofnonconformities.getRootCauseCategory())
                        //                        .put(listofnonconformities.getRootCauseDescription())
                        //                        .put(listofnonconformities.getResponsabilities())
                        .put(listofnonconformities.getStatus())
                        //                        .put(listofnonconformities.getComments())
                        .put(listofnonconformities.getIdQualityNonconformities())
                        .put("<a href=\"qualitynonconformitydetails.jsp?ncid=" + listofnonconformities.getIdQualityNonconformities() + "\">edit</a>");
                data.put(row);
            }
            jsonResponse.put("aaData", data);
            jsonResponse.put("sEcho", echo);
//            jsonResponse.put("iTotalRecords", numberOfNC.getCount());
            jsonResponse.put("iDisplayLength", data.length());
//            jsonResponse.put("iTotalDisplayRecords", numberOfNC.getCount());

            response.setContentType("application/json");
            response.getWriter().print(jsonResponse.toString());
        } catch (JSONException e) {
            Logger.log(NonConformityDetails.class.getName(), Level.FATAL, "" + e);
            response.setContentType("text/html");
            response.getWriter().print(e.getMessage());
        }
    }
}

package net.ruixin.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * Created by Administrator on 2016/9/26.
 */
public class TestServlet extends HttpServlet{
//    Map<String, String> users = new HashMap<String, String>();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
//        response.setContentType("applicationContext/JSON,encoding=utf-8");
        int age = Integer.parseInt(request.getParameter("age"));
        if(age <18) {
            PrintWriter out = response.getWriter();
            out.print("{\"msg\":\"您的年龄小于18，不可注册。\"}");
            out.flush();
            out.close();

        } else {

            String username = request.getParameter("username");
            String gender = request.getParameter("gender");
            String experience = request.getParameter("experience");
            Map<String, String> users = new HashMap<String, String>();
            users.put("username", username);
            users.put("age", age + "");
            users.put("gender", gender);
            users.put("experience", experience);

            BufferedWriter bw = null;
            File textFile = new File("F://Users.txt");
            try {
                bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(textFile, true), "utf-8"));
                for (Map.Entry<String, String> entry : users.entrySet()) {
                    String temp = "key=" + entry.getKey() + "; and value=" + entry.getValue();
                    System.out.println(temp);
                    bw.append(temp);
                    bw.newLine();
                    bw.flush();
                }

            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } finally {
                if (bw != null) {
                    bw.close();
                }
            }

            response.sendRedirect("success.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       this.doGet(request,response);


    }
}

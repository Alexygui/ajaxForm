<%-- Created by IntelliJ IDEA. --%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title></title>

    <script src="/js/jquery.js" type="text/javascript"></script>
    <script src="/js/jquery.form.js" type="text/javascript"></script>
    <script type="text/javascript">
      $(function () {
        // username jquery验证
        $("#username").blur(function () {
          var $parent = $(this).parent();
          $parent.find('.information').remove();
          if(this.value == "") {
            $parent.append("<span class='information onError'>用户名不能为空</span>");
          } else if(this.value.length !=10){
            $parent.append("<span class='information onError'>请输入10个字符串长度的用户名</span>");
          } else {
            $parent.append("<span class='information onOK'>OK</span>");
          }
        });
        //验证年龄
        $("#age").blur(function () {
          var $parent = $(this).parent();
          $parent.find('.information').remove();
          if(this.value == '' || !/^\d{1,2}$/.test(this.value)) {
            $parent.append("<span class='information onError'>请输入小于100的数字</span>");
          }  else {
            $parent.append("<span class='information onOK'>OK</span>");
          }
          //ajax验证年龄
          $.ajax({
            type:"get",
            url : "TestServlet.do?age="+$("#age").val(),
            dataType : "json",
            success: function (data) {
              if(data != "") {
                $("#msg").html("<span class='information onError'>年龄：" + data.msg+"</span>");
              }
            },
            error: function (jqXHR) {
              if(jqXHR.status != 200 && jqXHR.status != 0) {
                $("#msg").html("<span class='information onError'>出现错误：" + jqXHR.status+"</span>");
              } else {
                $("#msg").html("年龄验证通过！");
              }
            }
          });

        });

//        //ajax提交
//        $("#send").click(function () {
//          $.ajax({
//            type:"get",
//            url : "TestServlet.do?age="+$("#cage").val()+
//                  "&username="+$("#cusername").val()+
//                  "&gender=" +$("#cgender").val()+
//                  "&experience="+$("#cexperience").val(),
//            dataType : "json",
//            success: function (data) {
//              $("#information").html(data.msg);
//            },
//            error: function (jqXHR) {
//              if(jqXHR.status != 200) {
//                $("#information").html("出现错误：" + jqXHR.status);
//              } else {
//                $("#information").html("注册成功！");
//              }
//            }
//          });
//        });
        
        //form提交
        $("#send").click(function () {
          $('form :input').blur();
          var $errorNum = $('form .onError').length;
          if($errorNum){
            return false;
          }
        });


      });

    </script>
  </head>
  <body>
  <form  id="loginForm" action="/TestServlet.do" method="post">
    <p>
      <label for="username">姓名</label>
      <em>* </em><input id="username" name="username" size="25"/>
    </p>
    <p>
      <label for="age">年龄</label>
      <em>* </em><input id="age" name="age" size="25"/>
    </p>
    <p>
      <label for="gender">性别</label>
      <em>* </em><select id="gender" name="gender">
      <option selected="selected" value="男">男</option>
      <option value="女">女</option>
    </select>
    </p>
    <p>
      <label for="experience">个人经历</label>
      <textarea id="experience" name="experience" cols="20"></textarea>
    </p>

    <input type="submit" id="send" value="提交">
    <div id="msg"></div>
  </form>
  </body>
</html>
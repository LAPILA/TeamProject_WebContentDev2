<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.RequestDispatcher" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ include file="./SQLconstants.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>메인</title>
    <meta charset="UTF-8">
    <style>
        @font-face {
            font-family: 'Roboto';
            src: url('Robotofont/Roboto-Medium.ttf') format('truetype');
        }

        body {
            font-family: 'Roboto', sans-serif;
            margin: 0 auto;
        }

        .my_div { width: 500px;    height: 500px;} 

        .my_bg { background-image: url("images/전체 배경.png"); background-size: 100% 100%;}

        .search-input-text {
            left: 8px;
            top: 6px; /* 원하는 위치로 조정 */
            border: none; /* 테두리 제거 */
            background-color: transparent; /* 배경색 투명으로 설정 */
            font-size: 16px; /* 폰트 크기 설정 */
            outline: none; /* 포커스 효과 제거 */
            position: absolute;
            cursor: pointer;
        }

        .dropdown {
          display: inline-block;
          position: relative;
        }

        .dropdown-options {
          display: none;
          position: absolute;
          overflow: auto;
        }

        .dropdown:hover .dropdown-options {
          display: block;
        }

        

    </style>

    <%
      String userID = request.getParameter("userID");
    %>

    <script type="text/javascript">

      function alertID(){
        alert("<%= userID %>");
        if (<%= userID %> == null) {
          <%= userID %> = "";  // 기본값 설정
        }
      }

      function getmquery( parameter )	
	 		{
			  // 현재 URL을 가져옴
        var urlParams = new URLSearchParams(window.location.search);

        // 파라미터의 값을 반환하거나 없으면 null 반환
        return urlParams.get(parameter);
		  }

      function buttonset(parameter){         
        

        var myParameter = getmquery('mquery');
        if(myParameter == null){
          document.getElementById("recommendOn").style.display = "block";
          document.getElementById("recommendOff").style.display = "none";
          document.getElementById("newOn").style.display = "none";
          document.getElementById("topOn").style.display = "none";
        }

        
      }

      function loginset(){         
        

        var myParameter = getmquery('userID');
        if(myParameter == null || myParameter == ""){
          document.getElementById("loginbutton").style.display = "block";
          document.getElementById("logoutbutton").style.display = "none";
          document.getElementById("signupbutton").style.display = "block";
        }
        else{
          document.getElementById("loginbutton").style.display = "none";
          document.getElementById("logoutbutton").style.display = "block";
          document.getElementById("signupbutton").style.display = "none";
        }

        
      }

      function move( url )	
	 		{
			  document.formm.action = url;
			  document.formm.submit();
		  }

    </script>


</head>


    <!--어째서 하나하나 직접 폰트를 지정해줘야 하는거야아아ㅏㄲ 왜 한번에 안돼ㅜㅜ-->
    <body onLoad = "buttonset(); loginset()" style= "width: 1440px; height: 4215px; position: relative; font-family: 'Roboto'" class="my_div my_bg">
    <!--헤더-->
    <div style="width: 1440px; height: 200px; left: 0px; top: 0px; position: absolute">
      <img style="width: 1440px; height: 200px; left: 0px; top: 0px; position: absolute" src="images/헤더.png" />
    </div>

    <!--로고-->
    <form method="post" action="main.jsp">
      <button style="width: 320px; height: 160px; left: 546px; top: 20px; position: absolute; background-image: url('images/로고.png'); border: none; background-size: cover; background-color: transparent; cursor: pointer;"></button>
      <input type="hidden" name="userID" value = "<%= userID %>">
    </form>
    
    <!--로그인-->
    <form id = loginbutton method="post" action="login.jsp">
      <button  style="width: 88px; height: 42px; left: 1187px; top: 14px; position: absolute; background: black; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25); border-radius: 10px; overflow: hidden; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer;">
        <div style="width: 69px; text-align: center; color: white; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 33.60px; word-wrap: break-word">Login</div>
      </button>
      <input type="hidden" name="userID" value = "<%= userID %>">
    </form>

    <!--로그아웃-->
    <form id = logoutbutton method="post" action="main.jsp">
      <button  style="width: 100px; height: 42px; left: 1187px; top: 60px; position: absolute; background: black; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25); border-radius: 10px; overflow: hidden; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer;">
        <div style="width: 400px; text-align: center; color: white; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 33.60px; word-wrap: break-word">Logout</div>
      </button>
      <input type="hidden" name="userID" value = "">
    </form>

    <!--회원가입-->
    <form id = signupbutton method="post" action="signup.jsp">
      <button  style="width: 136px; height: 41px; left: 1290px; top: 14px; position: absolute; background: #FFFFF3; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25); border-radius: 10px; overflow: hidden; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer;">
        <div style="width: 94px; text-align: center; color: black; font-size: 24px; font-family: 'Roboto', sans-serif;; font-weight: 500; line-height: 33.60px; word-wrap: break-word">Sign up</div>
      </button>
      <input type="hidden" name="userID" value = "<%= userID %>">
    </form>

    <!-- 검색창 -->
    <div style="width: 238px; height: 29px; left: 934px; top: 20px; position: absolute">
      <div style="width: 238px; height: 29px; left: 0px; top: 0px; position: absolute; background: white; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25) inset; border-radius: 99px">
        <form method="get" action="search.jsp">
          <input type="text" name="searchQuery" size="20" class="search-input-text">
          <input type="hidden" name="userID" value = "<%= userID %>">
          <button type="submit" style="width: 18.67px; height: 22.75px; left: 213.71px; top: 3.30px; position: absolute; background-image: url('images/검색버튼.png'); border: none; background-size: cover; background-color: transparent; cursor: pointer;"></button>
        </form>
      </div>
    </div>
    
    <!--배경-->
    <div style="width: 1440px; height: 4013px; left: 0px; top: 200px; position: absolute; opacity: 0.85; background: #A6A6A6"></div>
    <img style="width: 1440px; height: 3968px; left: 0px; top: 245px; position: absolute" src="images/배경.png" />
    <div style="width: 1264px; height: 3266px; left: 88px; top: 949px; position: absolute; opacity: 0.85; background: #DFD1E2"></div>


    <!--배너 오른쪽 버튼-->
    <button style="width: 96px; height: 120px; left: 1310px; top: 534px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
      <img style="width: 96px; height: 120px; left: 0px; top: 0px; position: absolute" src="images/wpf_next_right.png"/>
    </button>

    <!--배너 왼쪽 버튼-->
    <button style="width: 96px; height: 120px; left: 34px; top: 534px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
      <img style="width: 96px; height: 120px; left: 0px; top: 0px; position: absolute" src="images/wpf_next_right.png"/>
    </button>

    <!--배너-->
    <button style="position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
      <img style="width: 1100px; height: 618.75px; left: 170px; top: 285px; position: absolute; border-radius: 50px" src="images/배너.png" />
    </button>

    <!--메인화면 카테고리-->
    <div style="width: 999px; height: 50px; left: 220px; top: 291px; position: absolute">
      <div style="width: 999px; height: 50px; left: 0px; top: 0px; position: absolute; opacity: 0.50; background: white; border-radius: 8px"></div>
      
      <form id="buttonForm" action="main.jsp" method="GET">
        <!--recommend-->
        <input type="hidden" id="button" name="mquery">
        <input type="hidden" name="userID" value = "<%= userID %>">
        <button id = recommendOn onclick = "buttonOnOff(this)" value = "recommend" style="width: 333px; height: 50px; left: 0px; top: 0px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
          <div style="width: 333px; height: 50px; left: 0px; top: 0px; position: absolute; background: black; box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.05); border-radius: 8px"></div>
          <div style="width: 239.76px; left: 46.62px; top: 3px; position: absolute; text-align: center; color: white; font-size: 30px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 45px; word-wrap: break-word">Recommend</div>
        </button>
        <button id = recommendOff onclick = "buttonOnOff(this)" value = "recommend" style="width: 333px; height: 50px; left: 0px; top: 0px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
          <div style="width: 333px; height: 50px; left: 0px; top: 0px; position: absolute; background-color: transparent; box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.05); border-radius: 8px"></div>
          <div style="width: 239.76px; left: 46.62px; top: 3px; position: absolute; text-align: center; color: black; font-size: 30px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 45px; word-wrap: break-word">Recommend</div>
        </button>
        <!--Top-->
        <button id = topOn onclick = "buttonOnOff(this)" value = "top" style="width: 333px; height: 50px; left: 333px; top: 0px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
          <div style="width: 333px; height: 50px; left: 0px; top: 0px; position: absolute; background: black; box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.05); border-radius: 8px"></div>
          <div style="width: 71.93px; left: 131px; top: 3px; position: absolute; text-align: center; color: white; font-size: 30px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 45px; word-wrap: break-word">Top</div>
        </button>
        <button id = topOff onclick = "buttonOnOff(this)" value = "top" style="width: 333px; height: 50px; left: 333px; top: 0px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
          <div style="width: 333px; height: 50px; left: 0px; top: 0px; position: absolute;  background-color: transparent; box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.05); border-radius: 8px"></div>
          <div style="width: 71.93px; left: 131px; top: 3px; position: absolute; text-align: center; color: black; font-size: 30px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 45px; word-wrap: break-word">Top</div>
        </button>
        <!--New-->
        <button id = newOn onclick = "buttonOnOff(this)" value = "new" style="width: 333px; height: 50px; left: 666px; top: 0px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
          <div style="width: 333px; height: 50px; left: 0px; top: 0px; position: absolute; background: black; box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.05); border-radius: 8px"></div>
          <div style="width: 68.83px; height: 45px; left: 133px; top: 2px; position: absolute; text-align: center; color: white; font-size: 30px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 45px; word-wrap: break-word">New</div>
        </button>
        <button id = newOff onclick = "buttonOnOff(this)" value = "new" style="width: 333px; height: 50px; left: 666px; top: 0px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
          <div style="width: 333px; height: 50px; left: 0px; top: 0px; position: absolute; background-color: transparent; box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.05); border-radius: 8px"></div>
          <div style="width: 68.83px; height: 45px; left: 133px; top: 2px; position: absolute; text-align: center; color: black; font-size: 30px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 45px; word-wrap: break-word">New</div>
        </button>
        <script type="text/javascript">
          function buttonOnOff(clickedButton){
            var clickedButtonId = clickedButton.id;
            var buttonValue = clickedButton.value;
            document.getElementById("button").value = buttonValue;
            document.getElementById("buttonForm").submit(); // 폼을 제출하여 값 전달     
          }
        </script>
      </form>
    </div>

    <!--카테고리-->
    <div style="width: 1440px; height: 48px; left: 0px; top: 199px; position: absolute">
      <div style="width: 1440px; height: 47px; left: 0px; top: 1px; position: absolute; background: #B86CF3"></div>
      <!--프로필-->
      <form id="profilebutton" action="profile.jsp" method="POST">
        <button style="width: 480px; height: 48px; left: 960px; top: 0px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
          <div style="width: 480px; height: 48px; left: 0px; top: 0px; position: absolute; opacity: 0.85; background: #DEDEDE; box-shadow: 0px 5px 4px rgba(0, 0, 0, 0.25); border-radius: 5px"></div>
          <div style="left: 189px; top: 8px; position: absolute; text-align: center; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 600; line-height: 33.60px; word-wrap: break-word">Profile</div>
        </button>
        <input type="hidden" name="userID" value = "<%= userID %>">
      </form>
      <!--카테고리-->
      <div class="dropdown" style="width: 480px; height: 48px; left: 480px; top: 0px; position: absolute;">
        <button style="width: 480px; height: 48px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
          <div style="width: 480px; height: 48px; left: 0px; top: 0px; position: absolute; opacity: 0.85; background: #DEDEDE; box-shadow: 0px 5px 4px rgba(0, 0, 0, 0.25); border-radius: 5px"></div>
          <div style="left: 176px; top: 7px; position: absolute; text-align: center; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 600; line-height: 33.60px; word-wrap: break-word">Categories</div>
        </button>        
        <!--장르 카테고리-->
        <div style="width: 480px; height: 270px; top: 48px; position: absolute" class="dropdown-options">
          <div style="width: 480px; height: 270px; left: 0px; top: 0px; position: absolute; background: #D8CDE1; border-radius: 10px"></div>
          <div style="width: 460px; height: 246.43px; left: 10px; top: 10px; position: absolute; background: rgba(245.28, 243.36, 253.94, 0.43); border-radius: 10px"></div>
          <div style="width: 2px; height: 231px; left: 238px; top: 17px; position: absolute; background: #605C5C"></div>
          <form id="actionbutton" action="search.jsp" method="POST">
            <button style="border: none; background-size: cover; background-color: transparent; cursor: pointer;">
              <div style="left: 17px; top: 17px; position: absolute; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; text-decoration: underline; line-height: 33.60px; word-wrap: break-word">Action</div>
            </button>
            <input type="hidden" name="category" value = "Action">
            <input type="hidden" name="userID" value = "<%= userID %>">
          </form>
          <form id="actionbutton" action="search.jsp" method="POST">
            <button style="border: none; background-size: cover; background-color: transparent; cursor: pointer;">
              <div style="left: 17px; top: 64px; position: absolute; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; text-decoration: underline; line-height: 33.60px; word-wrap: break-word">Adventure</div>
            </button>
            <input type="hidden" name="category" value = "Adventure">
            <input type="hidden" name="userID" value = "<%= userID %>">
          </form>
          <form id="actionbutton" action="search.jsp" method="POST">
            <button style="border: none; background-size: cover; background-color: transparent; cursor: pointer;">
              <div style="left: 17px; top: 109px; position: absolute; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; text-decoration: underline; line-height: 33.60px; word-wrap: break-word">Horror</div>
            </button>
            <input type="hidden" name="category" value = "Horror">
            <input type="hidden" name="userID" value = "<%= userID %>">
          </form>
          <form id="actionbutton" action="search.jsp" method="POST">
            <button style="border: none; background-size: cover; background-color: transparent; cursor: pointer;">
              <div style="left: 17px; top: 154px; position: absolute; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; text-decoration: underline; line-height: 33.60px; word-wrap: break-word">RPG</div>
            </button>
            <input type="hidden" name="category" value = "RPG">
            <input type="hidden" name="userID" value = "<%= userID %>">
          </form>
          <form id="actionbutton" action="search.jsp" method="POST">
            <button style="border: none; background-size: cover; background-color: transparent; cursor: pointer;">
              <div style="left: 17px; top: 199px; position: absolute; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; text-decoration: underline; line-height: 33.60px; word-wrap: break-word">Shooter</div>
            </button>
            <input type="hidden" name="category" value = "Shooter">
            <input type="hidden" name="userID" value = "<%= userID %>">
          </form>
        </div>
        
      </div>
      <!--메인-->
      <button style="width: 480px; height: 48px; left: 0px; top: 0px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;" class="dropdown">
        <div style="width: 480px; height: 48px; left: 0px; top: 0px; position: absolute; opacity: 0.85; background: #DEDEDE; box-shadow: 0px 5px 4px rgba(0, 0, 0, 0.25); border-radius: 5px"></div>
        <div style="width: 133.46px; left: 173.27px; top: 7px; position: absolute; text-align: center; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 600; line-height: 33.60px; word-wrap: break-word">Main</div>
      </button>
    </div>

    <%
      request.setCharacterEncoding("UTF-8");
      String mQuery = request.getParameter("mquery");
      mQuery = (mQuery == null || mQuery.isEmpty()) ? "%" : mQuery.trim();

      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;

      try {
        // MySQL 드라이버 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);

        String query = "";
        

        //검은 카테고리 변환
        if("new".equals(mQuery))
        {
          //out.println("<script>alert('new');</script>");
          out.println("<script>document.getElementById(\"newOn\").style.display = \"block\";</script>");
          out.println("<script>document.getElementById(\"newOff\").style.display = \"none\";</script>");
          out.println("<script>document.getElementById(\"recommendOn\").style.display = \"none\";</script>");
          out.println("<script>document.getElementById(\"recommendOff\").style.display = \"block\";</script>");
          out.println("<script>document.getElementById(\"topOn\").style.display = \"none\";</script>");
          out.println("<script>document.getElementById(\"topOff\").style.display = \"block\"</script>");

          query = "SELECT g.게임ID, g.게임명, g.가격, g.출시일, g.이미지URL, g.시스템사양, g.연령등급, d.개발사명 FROM 게임 g JOIN 개발사 d ON g.개발사ID = d.개발사ID ORDER BY g.출시일 DESC LIMIT 10;";
        }

        if("top".equals(mQuery))
        {
          //out.println("<script>alert('top');</script>");
          out.println("<script>document.getElementById(\"topOn\").style.display = \"block\";</script>");
          out.println("<script>document.getElementById(\"topOff\").style.display = \"none\";</script>");
          out.println("<script>document.getElementById(\"recommendOn\").style.display = \"none\";</script>");
          out.println("<script>document.getElementById(\"recommendOff\").style.display = \"block\";</script>");
          out.println("<script>document.getElementById(\"newOn\").style.display = \"none\";</script>");
          out.println("<script>document.getElementById(\"newOff\").style.display = \"block\"</script>");

          query = "SELECT g.게임ID, g.게임명, g.가격, g.출시일, g.이미지URL, g.시스템사양, g.연령등급, d.개발사명, COUNT(b.게임ID) AS 구매수량 FROM 게임 g JOIN 개발사 d ON g.개발사ID = d.개발사ID JOIN 구매한게임 b ON g.게임ID = b.게임ID GROUP BY g.게임ID, g.게임명, g.가격, g.출시일, g.이미지URL, g.시스템사양, g.연령등급, d.개발사명 ORDER BY 구매수량 DESC LIMIT 10;";
        }

        if("recommend".equals(mQuery) || "%".equals(mQuery))
        {
          //out.println("<script>alert('recommend');</script>");
          out.println("<script>document.getElementById(\"recommendOn\").style.display = \"block\";</script>");
          out.println("<script>document.getElementById(\"recommendOff\").style.display = \"none\";</script>");
          out.println("<script>document.getElementById(\"newOn\").style.display = \"none\";</script>");
          out.println("<script>document.getElementById(\"newOff\").style.display = \"block\";</script>");
          out.println("<script>document.getElementById(\"topOn\").style.display = \"none\";</script>");
          out.println("<script>document.getElementById(\"topOff\").style.display = \"block\"</script>");

          query = "SELECT g.게임ID, g.게임명, g.가격, g.출시일, g.이미지URL, g.시스템사양, g.연령등급, d.개발사명 FROM 게임 g JOIN 개발사 d ON g.개발사ID = d.개발사ID JOIN 추천게임 r ON g.게임ID = r.게임ID LIMIT 10;";
        }

        pstmt = con.prepareStatement(query);
        rs = pstmt.executeQuery();

        int count = 0;

        while(rs.next()) {
          count++;

          String leftPosition = "238px";
          String topPosition = ((count - 1) * 316 + 1008) + "px";
          

          out.println("<form id=\"actionbutton\" action=\"buy.jsp\" method=\"POST\">");
          out.println("<button style=\"width: 963px; height: 300px; left:" + leftPosition + "; top:" + topPosition + "; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;\">");
          out.println("<div style=\"width: 963px; height: 300px; left: 0; top: 0; position: absolute; opacity: 0.50; background: white; border-radius: 8px\"></div>");
          out.println("<div style=\"left: 736px; top: 256px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word\">출시일 "+ rs.getString("출시일") +"</div>");
          out.println("<div style=\"left: 315px; top: 122px; position: absolute; text-align: center; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word\">" + rs.getFloat("가격") + "</div>");
          out.println("<div style=\"left: 313px; top: 48px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word\">" + rs.getString("개발사명") + "</div>");
          out.println("<div style=\"width: 500px; height: 31px; left: 313px; top: 9px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word\">" + rs.getString("게임명") +"<br/></div>");
          out.println("<img style=\"width: 300px; height: 300px; left: 0px; top: 0px; position: absolute\" src=\""+ rs.getString("이미지URL") +"\"/>");
          out.println("</button>");
          // 구매창으로 정보 넘기기
          String gameID = rs.getString("게임ID");
          String gamename = rs.getString("게임명");
          String price = rs.getString("가격");
          String date = rs.getString("출시일");
          String imgURL = rs.getString("이미지URL");
          String requirement = rs.getString("시스템사양");
          String age = rs.getString("연령등급");
          String developer = rs.getString("개발사명");
          out.println("<input type=\"hidden\" name=\"gameID\" value=\"" + gameID + "\">");
          out.println("<input type=\"hidden\" name=\"gamename\" value=\"" + gamename + "\">");
          out.println("<input type=\"hidden\" name=\"price\" value=\"" + price + "\">");
          out.println("<input type=\"hidden\" name=\"date\" value=\"" + date + "\">");
          out.println("<input type=\"hidden\" name=\"imgURL\" value=\"" + imgURL + "\">");
          out.println("<input type=\"hidden\" name=\"requirement\" value=\"" + requirement + "\">");
          out.println("<input type=\"hidden\" name=\"age\" value=\"" + age + "\">");
          out.println("<input type=\"hidden\" name=\"developer\" value=\"" + developer + "\">");
          out.println("<input type=\"hidden\" name=\"userID\" value=\"" + userID + "\">");
          out.println("</form>");
        }


      } catch (ClassNotFoundException e) {
        out.println("JDBC 드라이버 로딩 실패: " + e.getMessage());
      } catch (SQLException e) {
        out.println("데이터베이스 연결/쿼리 오류: " + e.getMessage());
      } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ex) { ex.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }
      }
    
    %>



    

    </body>
    </html>

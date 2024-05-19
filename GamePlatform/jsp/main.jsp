<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.RequestDispatcher" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ include file="./SQLconstants.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>메인</title>
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
    <script type="text/javascript">
      function buttonset(clickedButton){
        document.getElementById("recommendOn").style.display = "block";
        document.getElementById("recommendOff").style.display = "none";
        document.getElementById("newOn").style.display = "none";
        document.getElementById("topOn").style.display = "none";

        var mquery = 'Recommend';
      }

      function move( url )	
	 		{
			  document.formm.action = url;
			  document.formm.submit();
		  }
      
    </script>


</head>

    <!--어째서 하나하나 직접 폰트를 지정해줘야 하는거야아아ㅏㄲ 왜 한번에 안돼ㅜㅜ-->
    <body onLoad = "buttonset()" style= "width: 1440px; height: 4215px; position: relative; font-family: 'Roboto'" class="my_div my_bg">
    <!--헤더-->
    <div style="width: 1440px; height: 200px; left: 0px; top: 0px; position: absolute">
      <img style="width: 1440px; height: 200px; left: 0px; top: 0px; position: absolute" src="images/헤더.png" />
    </div>

    <!--로고-->
    <form method="post" action="main.jsp">
      <button onclick="javascript:move( './main.jsp' );" style="width: 320px; height: 160px; left: 546px; top: 20px; position: absolute; background-image: url('images/로고.png'); border: none; background-size: cover; background-color: transparent; cursor: pointer;"></button>
    </form>
    
    <!--로그인-->
    <button type="button" onclick="location.href='login.jsp'" style="width: 88px; height: 42px; left: 1187px; top: 14px; position: absolute; background: black; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25); border-radius: 10px; overflow: hidden; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer;">
      <div style="width: 69px; text-align: center; color: white; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 33.60px; word-wrap: break-word">Login</div>
    </button>

    <!--회원가입-->
    <button type="button" onclick="location.href='signup.jsp'" style="width: 136px; height: 41px; left: 1290px; top: 14px; position: absolute; background: #FFFFF3; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25); border-radius: 10px; overflow: hidden; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer;">
      <div style="width: 94px; text-align: center; color: black; font-size: 24px; font-family: 'Roboto', sans-serif;; font-weight: 500; line-height: 33.60px; word-wrap: break-word">Sign up</div>
    </button>

    <!-- 검색창 -->
    <div style="width: 238px; height: 29px; left: 934px; top: 20px; position: absolute">
      <div style="width: 238px; height: 29px; left: 0px; top: 0px; position: absolute; background: white; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25) inset; border-radius: 99px">
        <form method="get" action="search.jsp">
          <input type="text" name="searchQuery" size="20" class="search-input-text">
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
      <!--recommend-->
      <button id = recommendOn onclick = "buttonOnOff(this)" style="width: 333px; height: 50px; left: 0px; top: 0px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
        <div style="width: 333px; height: 50px; left: 0px; top: 0px; position: absolute; background: black; box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.05); border-radius: 8px"></div>
        <div style="width: 239.76px; left: 46.62px; top: 3px; position: absolute; text-align: center; color: white; font-size: 30px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 45px; word-wrap: break-word">Recommend</div>
      </button>
      <button id = recommendOff onclick = "buttonOnOff(this)" style="width: 333px; height: 50px; left: 0px; top: 0px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
        <div style="width: 333px; height: 50px; left: 0px; top: 0px; position: absolute; background-color: transparent; box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.05); border-radius: 8px"></div>
        <div style="width: 239.76px; left: 46.62px; top: 3px; position: absolute; text-align: center; color: black; font-size: 30px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 45px; word-wrap: break-word">Recommend</div>
      </button>
      <!--Top-->
      <button id = topOn onclick = "buttonOnOff(this)" style="width: 333px; height: 50px; left: 333px; top: 0px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
        <div style="width: 333px; height: 50px; left: 0px; top: 0px; position: absolute; background: black; box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.05); border-radius: 8px"></div>
        <div style="width: 71.93px; left: 131px; top: 3px; position: absolute; text-align: center; color: white; font-size: 30px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 45px; word-wrap: break-word">Top</div>
      </button>
      <button id = topOff onclick = "buttonOnOff(this)" style="width: 333px; height: 50px; left: 333px; top: 0px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
        <div style="width: 333px; height: 50px; left: 0px; top: 0px; position: absolute;  background-color: transparent; box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.05); border-radius: 8px"></div>
        <div style="width: 71.93px; left: 131px; top: 3px; position: absolute; text-align: center; color: black; font-size: 30px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 45px; word-wrap: break-word">Top</div>
      </button>
      <!--New-->
      <button id = newOn onclick = "buttonOnOff(this)"style="width: 333px; height: 50px; left: 666px; top: 0px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
        <div style="width: 333px; height: 50px; left: 0px; top: 0px; position: absolute; background: black; box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.05); border-radius: 8px"></div>
        <div style="width: 68.83px; height: 45px; left: 133px; top: 2px; position: absolute; text-align: center; color: white; font-size: 30px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 45px; word-wrap: break-word">New</div>
      </button>
      <button id = newOff onclick = "buttonOnOff(this)"style="width: 333px; height: 50px; left: 666px; top: 0px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
        <div style="width: 333px; height: 50px; left: 0px; top: 0px; position: absolute; background-color: transparent; box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.05); border-radius: 8px"></div>
        <div style="width: 68.83px; height: 45px; left: 133px; top: 2px; position: absolute; text-align: center; color: black; font-size: 30px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 45px; word-wrap: break-word">New</div>
      </button>
      <script type="text/javascript">
        function buttonOnOff(clickedButton){
          var clickedButtonId = clickedButton.id;
          if(clickedButtonId == "topOn" || clickedButtonId == "topOff"){ //top
            document.getElementById("topOn").style.display = "block";
            document.getElementById("topOff").style.display = "none";
            document.getElementById("recommendOn").style.display = "none";
            document.getElementById("recommendOff").style.display = "block";
            document.getElementById("newOn").style.display = "none";
            document.getElementById("newOff").style.display = "block";

            mquery = 'top';
          }

          if(clickedButtonId == "newOn" || clickedButtonId == "newOff"){ //new
            document.getElementById("newOn").style.display = "block";
            document.getElementById("newOff").style.display = "none";
            document.getElementById("recommendOn").style.display = "none";
            document.getElementById("recommendOff").style.display = "block";
            document.getElementById("topOn").style.display = "none";
            document.getElementById("topOff").style.display = "block";

            mquery = 'new';
          }

          if(clickedButtonId == "recommendOn" || clickedButtonId == "recommendOff"){ //recommend
            document.getElementById("recommendOn").style.display = "block";
            document.getElementById("recommendOff").style.display = "none";
            document.getElementById("newOn").style.display = "none";
            document.getElementById("newOff").style.display = "block";
            document.getElementById("topOn").style.display = "none";
            document.getElementById("topOff").style.display = "block";

            mquery = 'recommend';
          }
      
        }
      </script>
    </div>

    <!--카테고리-->
    <div style="width: 1440px; height: 48px; left: 0px; top: 199px; position: absolute">
      <div style="width: 1440px; height: 47px; left: 0px; top: 1px; position: absolute; background: #B86CF3"></div>
      <!--프로필-->
      <button style="width: 480px; height: 48px; left: 960px; top: 0px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
        <div style="width: 480px; height: 48px; left: 0px; top: 0px; position: absolute; opacity: 0.85; background: #DEDEDE; box-shadow: 0px 5px 4px rgba(0, 0, 0, 0.25); border-radius: 5px"></div>
        <div style="left: 189px; top: 8px; position: absolute; text-align: center; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 600; line-height: 33.60px; word-wrap: break-word">Profile</div>
      </button>
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
          <button style="border: none; background-size: cover; background-color: transparent; cursor: pointer;">
            <div style="left: 17px; top: 17px; position: absolute; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; text-decoration: underline; line-height: 33.60px; word-wrap: break-word">Action</div>
          </button>
          <button style="border: none; background-size: cover; background-color: transparent; cursor: pointer;">
            <div style="left: 17px; top: 64px; position: absolute; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; text-decoration: underline; line-height: 33.60px; word-wrap: break-word">Adventure</div>
          </button>
          <button style="border: none; background-size: cover; background-color: transparent; cursor: pointer;">
            <div style="left: 17px; top: 109px; position: absolute; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; text-decoration: underline; line-height: 33.60px; word-wrap: break-word">Horror</div>
          </button>
          <button style="border: none; background-size: cover; background-color: transparent; cursor: pointer;">
            <div style="left: 17px; top: 154px; position: absolute; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; text-decoration: underline; line-height: 33.60px; word-wrap: break-word">RPG</div>
          </button>
          <button style="border: none; background-size: cover; background-color: transparent; cursor: pointer;">
            <div style="left: 17px; top: 199px; position: absolute; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; text-decoration: underline; line-height: 33.60px; word-wrap: break-word">Shooter</div>
          </button>
        </div>
        
      </div>
      <!--메인-->
      <button style="width: 480px; height: 48px; left: 0px; top: 0px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;" class="dropdown">
        <div style="width: 480px; height: 48px; left: 0px; top: 0px; position: absolute; opacity: 0.85; background: #DEDEDE; box-shadow: 0px 5px 4px rgba(0, 0, 0, 0.25); border-radius: 5px"></div>
        <div style="width: 133.46px; left: 173.27px; top: 7px; position: absolute; text-align: center; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 600; line-height: 33.60px; word-wrap: break-word">Main</div>
      </button>
    </div>

    <%
      String mQuery = request.getParameter("mquery");
      mQuery = (mQuery == null || mQuery.isEmpty()) ? "%" : mQuery.trim();

      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;

      try {
        // MySQL 드라이버 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);

        if(mQuery == "new")
        {
          out.println("<script>alert('new'); history.back();</script>");
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



    <!--추천1-->
    <button style="width: 963px; height: 300px; left: 238px; top: 1008px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
      <div style="width: 963px; height: 300px; left: 0px; top: 0px; position: absolute; opacity: 0.50; background: white; border-radius: 8px"></div>
      <div style="left: 736px; top: 256px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">출시일 2022-02-25</div>
      <div style="left: 315px; top: 256px; position: absolute; text-align: center; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">★★★★☆ 4.47</div>
      <div style="left: 315px; top: 172px; position: absolute; color: black; text-align: left; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">Action<br/>RPG</div>
      <div style="left: 315px; top: 122px; position: absolute; text-align: center; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">59.99$</div>
      <div style="left: 313px; top: 48px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">프롬소프트웨어</div>
      <div style="width: 500px; height: 31px; left: 313px; top: 9px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">엘든 링 ELDEN RING<br/></div>
      <img style="width: 300px; height: 300px; left: 0px; top: 0px; position: absolute" src="images/엘든링.png" />
    </button>

    <!--추천2-->
    <button style="width: 963px; height: 300px; left: 238px; top: 1324px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
      <div style="width: 963px; height: 300px; left: 0px; top: 0px; position: absolute; opacity: 0.50; background: white; border-radius: 8px"></div>
      <div style="left: 737px; top: 256px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">출시일 1996-03-22</div>
      <div style="left: 315px; top: 256px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">★★★★☆ 4.5</div>
      <div style="left: 315px; top: 172px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word; text-align: left;">Action<br/>Horror</div>
      <div style="left: 315px; top: 122px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">59.99$</div>
      <div style="left: 313px; top: 48px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">캡콤</div>
      <div style="width: 500px; height: 31px; left: 313px; top: 9px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">바이오하자드</div>
      <img style="width: 300px; height: 300px; left: 0px; top: 0px; position: absolute" src="images/바이오하자드.png" />
    </button>

    <!--추천3-->
    <button style="width: 963px; height: 300px; left: 238px; top: 1640px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
        <div style="width: 963px; height: 300px; left: 0px; top: 0px; position: absolute; opacity: 0.50; background: white; border-radius: 8px"></div>
        <div style="left: 737px; top: 256px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">출시일 1987-12-17</div>
        <div style="left: 315px; top: 256px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">★★☆☆☆ 2.5</div>
        <div style="left: 315px; top: 189px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word; text-align: left;">Action</div>
        <div style="left: 315px; top: 122px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">29.99$</div>
        <div style="left: 313px; top: 48px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">캡콤</div>
        <div style="width: 500px; height: 31px; left: 313px; top: 9px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">록맨</div>
        <img style="width: 300px; height: 300px; left: 0px; top: 0px; position: absolute" src="images/록맨.png" />
    </button>

    <!--추천4-->
    <button style="width: 963px; height: 300px; left: 238px; top: 1956px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
        <div style="width: 963px; height: 300px; left: 0px; top: 0px; position: absolute; opacity: 0.50; background: white; border-radius: 8px"></div>
        <div style="left: 737px; top: 256px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">출시일 1987-12-17</div>
        <div style="left: 315px; top: 256px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">★★☆☆☆ 2.5</div>
        <div style="left: 315px; top: 189px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word; text-align: left;">Action</div>
        <div style="left: 315px; top: 122px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">29.99$</div>
        <div style="left: 313px; top: 48px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">캡콤</div>
        <div style="width: 500px; height: 31px; left: 313px; top: 9px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">록맨</div>
        <img style="width: 300px; height: 300px; left: 0px; top: 0px; position: absolute" src="images/록맨.png" />
    </button>

    <!--추천5-->
    <button style="width: 963px; height: 300px; left: 240px; top: 2272px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
        <div style="width: 963px; height: 300px; left: 0px; top: 0px; position: absolute; opacity: 0.50; background: white; border-radius: 8px"></div>
        <div style="left: 737px; top: 256px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">출시일 1987-12-17</div>
        <div style="left: 315px; top: 256px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">★★☆☆☆ 2.5</div>
        <div style="left: 315px; top: 189px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word; text-align: left;">Action</div>
        <div style="left: 315px; top: 122px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">29.99$</div>
        <div style="left: 313px; top: 48px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">캡콤</div>
        <div style="width: 500px; height: 31px; left: 313px; top: 9px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">록맨</div>
        <img style="width: 300px; height: 300px; left: 0px; top: 0px; position: absolute" src="images/록맨.png" />
    </button>

    <!--추천6-->
    <button style="width: 963px; height: 300px; left: 238px; top: 2588px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
        <div style="width: 963px; height: 300px; left: 0px; top: 0px; position: absolute; opacity: 0.50; background: white; border-radius: 8px"></div>
        <div style="left: 737px; top: 256px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">출시일 1987-12-17</div>
        <div style="left: 315px; top: 256px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">★★☆☆☆ 2.5</div>
        <div style="left: 315px; top: 189px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word; text-align: left;">Action</div>
        <div style="left: 315px; top: 122px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">29.99$</div>
        <div style="left: 313px; top: 48px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">캡콤</div>
        <div style="width: 500px; height: 31px; left: 313px; top: 9px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">록맨</div>
        <img style="width: 300px; height: 300px; left: 0px; top: 0px; position: absolute" src="images/록맨.png" />
    </button>

    <!--추천7-->
    <button style="width: 963px; height: 300px; left: 240px; top: 2904px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
        <div style="width: 963px; height: 300px; left: 0px; top: 0px; position: absolute; opacity: 0.50; background: white; border-radius: 8px"></div>
        <div style="left: 737px; top: 256px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">출시일 1987-12-17</div>
        <div style="left: 315px; top: 256px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">★★☆☆☆ 2.5</div>
        <div style="left: 315px; top: 189px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word; text-align: left;">Action</div>
        <div style="left: 315px; top: 122px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">29.99$</div>
        <div style="left: 313px; top: 48px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">캡콤</div>
        <div style="width: 500px; height: 31px; left: 313px; top: 9px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">록맨</div>
        <img style="width: 300px; height: 300px; left: 0px; top: 0px; position: absolute" src="images/록맨.png" />
    </button>

    <!--추천8-->
    <button style="width: 963px; height: 300px; left: 238px; top: 3220px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
        <div style="width: 963px; height: 300px; left: 0px; top: 0px; position: absolute; opacity: 0.50; background: white; border-radius: 8px"></div>
        <div style="left: 737px; top: 256px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">출시일 1987-12-17</div>
        <div style="left: 315px; top: 256px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">★★☆☆☆ 2.5</div>
        <div style="left: 315px; top: 189px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word; text-align: left;">Action</div>
        <div style="left: 315px; top: 122px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">29.99$</div>
        <div style="left: 313px; top: 48px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">캡콤</div>
        <div style="width: 500px; height: 31px; left: 313px; top: 9px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">록맨</div>
        <img style="width: 300px; height: 300px; left: 0px; top: 0px; position: absolute" src="images/록맨.png" />
    </button>

    <!--추천9-->
    <button style="width: 963px; height: 300px; left: 238px; top: 3536px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
        <div style="width: 963px; height: 300px; left: 0px; top: 0px; position: absolute; opacity: 0.50; background: white; border-radius: 8px"></div>
        <div style="left: 737px; top: 256px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">출시일 1987-12-17</div>
        <div style="left: 315px; top: 256px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">★★☆☆☆ 2.5</div>
        <div style="left: 315px; top: 189px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word; text-align: left;">Action</div>
        <div style="left: 315px; top: 122px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">29.99$</div>
        <div style="left: 313px; top: 48px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">캡콤</div>
        <div style="width: 500px; height: 31px; left: 313px; top: 9px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">록맨</div>
        <img style="width: 300px; height: 300px; left: 0px; top: 0px; position: absolute" src="images/록맨.png" />
    </button>

    <!--추천10-->
    <button style="width: 963px; height: 300px; left: 238px; top: 3852px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
        <div style="width: 963px; height: 300px; left: 0px; top: 0px; position: absolute; opacity: 0.50; background: white; border-radius: 8px"></div>
        <div style="left: 737px; top: 256px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">출시일 1987-12-17</div>
        <div style="left: 315px; top: 256px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">★★☆☆☆ 2.5</div>
        <div style="left: 315px; top: 189px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word; text-align: left;">Action</div>
        <div style="left: 315px; top: 122px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">29.99$</div>
        <div style="left: 313px; top: 48px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">캡콤</div>
        <div style="width: 500px; height: 31px; left: 313px; top: 9px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word">록맨</div>
        <img style="width: 300px; height: 300px; left: 0px; top: 0px; position: absolute" src="images/록맨.png" />
    </button>

    </body>
    </html>

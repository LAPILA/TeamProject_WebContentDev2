<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.RequestDispatcher" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./SQLconstants.jsp"%>
<!DOCTYPE html>
<html>
    <head>
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
    
            .my_div { width: 1440px;    height: 1024px;} 
    
            .my_bg { background-image: url("images/전체 배경.png"); background-size: cover;}
    
            .input-text {
                left: 20px;
                top: 45px; /* 원하는 위치로 조정 */
                border: none; /* 테두리 제거 */
                background-color: transparent; /* 배경색 투명으로 설정 */
                font-size: 40px; /* 폰트 크기 설정 */
                outline: none; /* 포커스 효과 제거 */
                position: absolute;
                cursor: pointer;
            }

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
    
    
        </style>

        <%
            request.setCharacterEncoding("UTF-8");
            String userID = request.getParameter("userID");
            String gameID = request.getParameter("gameID");           
            String gamename = request.getParameter("gamename"); 
            String price = request.getParameter("price"); 
            String date = request.getParameter("date"); 
            String imgURL = request.getParameter("imgURL"); 
            String requirement = request.getParameter("requirement"); 
            String age = request.getParameter("age"); 
            String developer = request.getParameter("developer"); 
            

            if (userID == null) {
                userID = "";  // 기본값 설정
            }
            if (gameID == null) {
                gameID = "";  // 기본값 설정
            }
        %>

        <script type="text/javascript">

            function alertID(){
                alert("유저: <%= userID %> 게임: <%= gameID %>");
            }
      
        </script>
    
    </head>
<body style="width: 1440px; height: 1024; position: relative;" class="my_div my_bg" onLoad="alertID()">
        <!--헤더-->
        <div style="width: 1440px; height: 200px; left: 0px; top: 0px; position: absolute">
            <img style="width: 1440px; height: 200px; left: 0px; top: 0px; position: absolute" src="images/헤더.png" />
        </div>
  
        <!-- 로고 -->
        <form method="post" action="main.jsp">
            <button style="width: 320px; height: 160px; left: 546px; top: 20px; position: absolute; background-image: url('images/로고.png'); border: none; background-size: cover; background-color: transparent; cursor: pointer;"></button>
            <input type="hidden" name="userID" value = "<%= userID %>">
        </form>

        <!--로그인-->
        <form method="post" action="login.jsp">
            <button style="width: 88px; height: 42px; left: 1187px; top: 14px; position: absolute; background: black; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25); border-radius: 10px; overflow: hidden; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer;">
                <div style="width: 69px; text-align: center; color: white; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 33.60px; word-wrap: break-word">Login</div>
            </button>
            <input type="hidden" name="userID" value = "<%= userID %>">
        </form>

        <!--로그아웃-->
        <button style="width: 100px; height: 42px; left: 1187px; top: 60px; position: absolute; background: black; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25); border-radius: 10px; overflow: hidden; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer;">
            <div style="width: 400px; text-align: center; color: white; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 33.60px; word-wrap: break-word">Logout</div>
        </button>

        <!--회원가입-->
        <form method="post" action="signup.jsp">
            <button style="width: 136px; height: 41px; left: 1290px; top: 14px; position: absolute; background: #FFFFF3; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25); border-radius: 10px; overflow: hidden; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer;">
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

        <div style="width: 1440px; height: 826px; left: 0px; top: 198px; position: absolute; opacity: 0.85; background: #B3B3B3"></div>
        <div style="width: 1200px; height: 600px; left: 120px; top: 311px; position: absolute">
            <div style="width: 1200px; height: 600px; left: 0px; top: 0px; position: absolute; background: #E9E9E9; box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.05); border-radius: 8px"></div>
            <button style="width: 171px; height: 77px; padding: 10px; left: 814px; top: 484px; position: absolute; background: black; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25); border-radius: 10px; overflow: hidden; justify-content: center; align-items: center; gap: 10px; display: inline-flex">
              <div style="width: 80px; text-align: center; color: white; font-size: 40px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 56px; word-wrap: break-word">Buy</div>
            </button>
            <img style="width: 600px; height: 600px; left: 0px; top: 0px; position: absolute; border-radius: 8px" src="<%= imgURL %>"/>
            <div style="width: 528px; height: 49px; left: 624px; top: 25px; position: absolute; color: black; font-size: 30px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 42px; word-wrap: break-word">
                <%                    
                    out.print(gamename);
                %>
            </div>
            <div style="left: 624px; top: 91px; position: absolute; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 33.60px; word-wrap: break-word">
                <%                    
                    out.print(developer);
                %>
            </div>
            <!--<div style="width: 300px; height: 34px; left: 624px; top: 142px; position: absolute; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 33.60px; word-wrap: break-word">Action / RPG</div>-->
            <div style="left: 624px; top: 193px; position: absolute; text-align: center; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 33.60px; word-wrap: break-word">
                <%                    
                    out.print(price + "$");
                %>
            </div>
            <div style="left: 624px; top: 244px; position: absolute; text-align: center; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 33.60px; word-wrap: break-word">
                <%                    
                    out.print(requirement);
                %>
            </div>
            <div style="left: 624px; top: 295px; position: absolute; text-align: center; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 33.60px; word-wrap: break-word">
                <%                    
                    out.print("연령등급 : " + age);
                %>
            </div>
            <div style="left: 624px; top: 346px; position: absolute; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 33.60px; word-wrap: break-word">
                <%                    
                    out.print("출시일 " + date);
                %>
            </div>
        </div>
    
    </body>
</html>
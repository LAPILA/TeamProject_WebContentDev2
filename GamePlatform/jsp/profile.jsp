<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.RequestDispatcher" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./SQLconstants.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        

        <style>
            @font-face {
                font-family: 'Roboto';
                src: url('Robotofont/Roboto-Medium.ttf') format('truetype');
            }
            body {
                font-family: 'Roboto', sans-serif;
                margin: 0 auto;
            }
            .my_div { width: 500px; height: 500px; }
            .my_bg { background-image: url("images/전체 배경.png"); background-size: 100% 100%; }
            .search-input-text {
                left: 8px;
                top: 6px;
                border: none;
                background-color: transparent;
                font-size: 16px;
                outline: none;
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
            .game-info { margin-bottom: 20px; border-bottom: 1px solid #ccc; padding-bottom: 10px; }
            img { margin-top: 10px; height: 150px; width: auto; }

        </style>

        <%
            request.setCharacterEncoding("UTF-8");
            String userID = request.getParameter("userID");
            if (userID == null) {
                userID = "";  // 기본값 설정
            }
        %>


        <script type="text/javascript">

            function move( url )	
	 	    {
		    	document.formm.action = url;
		    	document.formm.submit();
		    }

            function alertID(){
                alert("<%= userID %>");
            }
      
        </script>
    </head>
    <body onLoad="alertID()" style="width: 1440px; height: 1024px; position: relative; font-family: 'Roboto'" class="my_div my_bg">
        
        <!-- 헤더 -->
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
        <form method="post" action="main.jsp">
            <button style="width: 100px; height: 42px; left: 1187px; top: 60px; position: absolute; background: black; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25); border-radius: 10px; overflow: hidden; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer;">
                <div style="width: 400px; text-align: center; color: white; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 33.60px; word-wrap: break-word">Logout</div>
            </button>
            <input type="hidden" name="userID" value = "">
        </form>

        <!--회원가입-->
        <form method="post" action="signup.jsp">
            <button style="width: 136px; height: 41px; left: 1290px; top: 14px; position: absolute; background: #FFFFF3; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25); border-radius: 10px; overflow: hidden; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer;">
                <div style="width: 94px; text-align: center; color: black; font-size: 24px; font-family: 'Roboto', sans-serif;; font-weight: 500; line-height: 33.60px; word-wrap: break-word">Sign up</div>
            </button>
            <input type="hidden" name="userID" value = "<%= userID %>">
        </form>

       <!-- 검색창 -->
        <div style="width: 260px; height: 35px; left: 900px; top: 18px; position: absolute">
            <div style="width: 260px; height: 35px; left: 0px; top: 0px; position: absolute; background: white; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25) inset; border-radius: 99px">
                <form method="get" action="search.jsp">
                    <input type="text" name="searchQuery" size="20" class="search-input-text">
                    <input type="hidden" name="userID" value = "<%= userID %>">
                    <button type="submit" style="width: 22px; height: 22px; left: 230px; top: 5px; position: absolute; background-image: url('images/검색버튼.png'); border: none; background-size: cover; background-color: transparent; cursor: pointer;"></button>
                </form>
            </div>
        </div>
        
        <!-- 검색 결과 배경 -->
        <div style="width: 1440px; height: 824px; left: 0px; top: 200px; position: absolute; opacity: 0.85; background: #A6A6A6">
            <img style="width: 1440px; height: 824px; left: 0px; top: 0px; position: absolute" src="images/검색배경.png" />
        </div>
        <!-- 라이브러리 : -->
        <div style="width: 220px; height: 36px; left: 82px; top: 270px; position: absolute; color: black; font-size: 30px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 42px; word-wrap: break-word">Library : </div>
        
        <!-- 검색 결과 창 -->
        <div style="width: 1275px; height: 630px; left: 82px; top: 310px; position: relative; opacity: 0.85; background: #DFD1E2; border-radius: 8px; overflow-y: auto; overflow-x: hidden;">
            <%
                userID = (userID == null || userID.isEmpty()) ? "" : userID.trim();

                Connection con = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    // MySQL 드라이버 연결
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);

                    String query = "SELECT g.게임ID, g.게임명, g.가격, g.출시일, g.이미지URL, g.시스템사양, g.연령등급, d.개발사명 " +
                                   "FROM 게임 g JOIN 개발사 d ON g.개발사ID = d.개발사ID JOIN 구매한게임 b ON g.게임ID = b.게임ID JOIN 회원 u ON b.회원ID = u.회원ID " +
                                   "WHERE u.회원ID LIKE ?";
                    pstmt = con.prepareStatement(query);
                    pstmt.setString(1,  userID);
                    rs = pstmt.executeQuery();

                    int count = 0;
                    while (rs.next()) {
                        count++;
                        String leftPosition = (count % 2 == 1) ? "0px" : "645px";
                        String topPosition = (count % 2 == 1) ? ((count - 1) / 2 * 215) + "px" : ((count - 2) / 2 * 215) + "px";

                        out.println("<div style='width: 630px; height: 200px; left: " + leftPosition + "; top: " + topPosition + "; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;'>");
                        out.println("    <div style='width: 630px; height: 200px; left: 0px; top: 0px; position: absolute; opacity: 0.50; background: white; border-radius: 8px'></div>");
                        out.println("    <div style='left: 203px; top: 20px; position: absolute; text-align: center; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word'>" + rs.getString("게임명") + "<br/></div>");
                        out.println("    <div style='left: 204px; top: 100px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word; text-align: left;'>" + rs.getString("개발사명") + "<br/>" + rs.getString("시스템사양") + "</div>");
                        out.println("    <div style='left: 203px; top: 57px; position: absolute; text-align: center; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word'>" + rs.getFloat("가격") + "</div>");
                        out.println("    <img style='width: 160px; height: 160px; left: 26px; top: 20px; position: absolute' src='" + rs.getString("이미지URL") + "' />");
                        out.println("</div>");
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
        </div>
        <!-- 카테고리 -->
        <div style="width: 1440px; height: 48px; left: 0px; top: 199px; position: absolute">
            <div style="width: 1440px; height: 47px; left: 0px; top: 1px; position: absolute; background: #B86CF3"></div>
            <!-- 프로필 -->
            <button style="width: 480px; height: 48px; left: 960px; top: 0px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
                <div style="width: 480px; height: 48px; left: 0px; top: 0px; position: absolute; opacity: 0.85; background: #DEDEDE; box-shadow: 0px 5px 4px rgba(0, 0, 0, 0.25); border-radius: 5px"></div>
                <div style="left: 189px; top: 8px; position: absolute; text-align: center; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 600; line-height: 33.60px; word-wrap: break-word">Profile</div>
            </button>
            <!-- 카테고리 -->
            <div class="dropdown" style="width: 480px; height: 48px; left: 480px; top: 0px; position: absolute;">
                <button style="width: 480px; height: 48px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;">
                    <div style="width: 480px; height: 48px; left: 0px; top: 0px; position: absolute; opacity: 0.85; background: #DEDEDE; box-shadow: 0px 5px 4px rgba(0, 0, 0, 0.25); border-radius: 5px"></div>
                    <div style="left: 176px; top: 7px; position: absolute; text-align: center; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 600; line-height: 33.60px; word-wrap: break-word">Categories</div>
                </button>
                <!-- 장르 카테고리 -->
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
            <!-- 메인 -->
            <form id="mainbutton" action="main.jsp" method="POST">
                <button style="width: 480px; height: 48px; left: 0px; top: 0px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;" class="dropdown">
                    <div style="width: 480px; height: 48px; left: 0px; top: 0px; position: absolute; opacity: 0.85; background: #DEDEDE; box-shadow: 0px 5px 4px rgba(0, 0, 0, 0.25); border-radius: 5px"></div>
                    <div style="width: 133.46px; left: 173.27px; top: 7px; position: absolute; text-align: center; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 600; line-height: 33.60px; word-wrap: break-word">Main</div>
                </button>
                <input type="hidden" name="userID" value = "<%= userID %>">
            </form>
        </div>
    </body>
</html>
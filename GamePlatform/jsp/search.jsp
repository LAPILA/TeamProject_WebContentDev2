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
    </head>
    <body style="width: 1440px; height: 1024px; position: relative; font-family: 'Roboto'" class="my_div my_bg">
        <!-- 헤더 -->
        <div style="width: 1440px; height: 200px; left: 0px; top: 0px; position: absolute">
            <img style="width: 1440px; height: 200px; left: 0px; top: 0px; position: absolute" src="images/헤더.png" />
        </div>
        <!-- 로고 -->
        <button style="width: 320px; height: 160px; left: 546px; top: 20px; position: absolute; background-image: url('images/로고.png'); border: none; background-size: cover; background-color: transparent; cursor: pointer;"></button>
        <!-- 로그인 -->
        <button style="width: 88px; height: 42px; left: 1187px; top: 14px; position: absolute; background: black; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25); border-radius: 10px; overflow: hidden; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer;">
            <div style="width: 69px; text-align: center; color: white; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 33.60px; word-wrap: break-word">Login</div>
        </button>
        <!-- 회원가입 -->
        <button style="width: 136px; height: 41px; left: 1290px; top: 14px; position: absolute; background: #FFFFF3; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25); border-radius: 10px; overflow: hidden; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer;">
            <div style="width: 94px; text-align: center; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 33.60px; word-wrap: break-word">Sign up</div>
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
        <!-- 검색 결과 배경 -->
<div style="width: 1440px; height: 824px; left: 0px; top: 200px; position: absolute; background: url('images/검색배경.png') no-repeat center center; background-size: cover;">
</div>

<!-- 현재 검색 내용 -->
<div style="width: 220px; height: 36px; left: 82px; top: 270px; position: absolute; color: black; font-size: 30px; font-family: 'Roboto', sans-serif; font-weight: 500;">
    Search Results :
</div>

<!-- 검색 결과 창 -->
<div style="width: 1275px; height: 630px; left: 82px; top: 310px; position: relative; background: rgba(223, 209, 226, 0.85); border-radius: 8px; overflow-y: auto;">
    <% 
    String searchQuery = request.getParameter("searchQuery");
    searchQuery = (searchQuery == null || searchQuery.isEmpty()) ? "%" : "%" + searchQuery.trim() + "%";

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);
        String query = "SELECT 게임ID, 게임명, 가격, 출시일, 이미지URL, 시스템사양, 연령등급, 개발사명 FROM 게임 WHERE 게임명 LIKE ?";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, searchQuery);
        rs = pstmt.executeQuery();

        if (!rs.next()) {
            out.println("<p style='text-align: center; margin-top: 300px;'>검색 결과가 없습니다.</p>");
        } else {
            do {
                out.println("<div style='margin: 10px; padding: 10px; border-bottom: 1px solid #ccc;'>");
                out.println("<strong>" + rs.getString("게임명") + "</strong><br>");
                out.println("개발사: " + rs.getString("개발사명") + "<br>");
                out.println("가격: " + rs.getFloat("가격") + "<br>");
                out.println("출시일: " + rs.getDate("출시일") + "<br>");
                out.println("<img src='" + rs.getString("이미지URL") + "' style='height: 150px; width: auto;'><br>");
                out.println("</div>");
            } while (rs.next());
        }
    } catch (Exception e) {
        out.println("<p style='text-align: center; margin-top: 300px;'>검색 에러: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ex) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
        if (con != null) try { con.close(); } catch (SQLException ex) {}
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
            <!-- 메인 -->
            <button style="width: 480px; height: 48px; left: 0px; top: 0px; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;" class="dropdown">
                <div style="width: 480px; height: 48px; left: 0px; top: 0px; position: absolute; opacity: 0.85; background: #DEDEDE; box-shadow: 0px 5px 4px rgba(0, 0, 0, 0.25); border-radius: 5px"></div>
                <div style="width: 133.46px; left: 173.27px; top: 7px; position: absolute; text-align: center; color: black; font-size: 24px; font-family: 'Roboto', sans-serif; font-weight: 600; line-height: 33.60px; word-wrap: break-word">Main</div>
            </button>
        </div>
    </body>
</html>

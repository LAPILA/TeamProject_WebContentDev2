<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
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
    
    
        </style>
    
    </head>
    <body style="width: 1440px; height: auto; position: relative;" class="my_div my_bg">
        <div style="width: 1440px; height: 826px; left: 0px; top: 198px; position: absolute; opacity: 0.85; background: #B3B3B3"></div>
        <!--헤더-->
        <img style="width: 1440px; height: 200px; left: 0px; top: -2px; position: absolute;" src="images\헤더.png" />
        <!--로고-->
        <button style="width: 400px; height: 186px; left: 10px; top: 7px; position: absolute; background-image: url('images/로고.png'); border: none; background-size: cover; background-color: transparent; cursor: pointer;"></button>
        <!--회원가입-->
        <form method="post" action="signupAction.jsp">
            <button style="width: 255px; height: 113px; left: 592px; top: 810px; position: absolute; background: #AD9EB9; box-shadow: 4px 4px 4px rgba(0, 0, 0, 0.25); border-radius: 20px; justify-content: center; align-items: center; gap: 10px; display: inline-flex; border: none; cursor: pointer;">
                <div style="text-align: center; color: black; font-size: 48px; font-family: 'Roboto', sans-serif; font-weight: 600; line-height: 67.20px; word-wrap: break-word">Sign Up</div>
            </button>

        

        <!--이메일 주소-->
            <div style="width: 900px; height: 107px; left: 195px; top: 263px; position: absolute; opacity: 0.50; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 8px; display: inline-flex">
                <div style="width: 200px; color: black; font-size: 25px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 24px; word-wrap: break-word">E-mail Address</div>
                <div style="width: 900px; height: 75px; padding-left: 16px; padding-right: 16px; padding-top: 12px; padding-bottom: 12px; background: white; box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.05); border-radius: 8px; border: 1px #E0E0E0 solid">
                    <input type="text" name="emailQuery" size="20" class="input-text" required>
                </div>
            </div>
        
        <!--이름-->
            <div style="width: 900px; height: 107px; left: 195px; top: 394px; position: absolute; opacity: 0.50; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 8px; display: inline-flex">
                <div style="align-self: stretch; color: black; font-size: 25px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 24px; word-wrap: break-word">User Name</div>
                <div style="width: 900px; height: 75px; padding-left: 16px; padding-right: 16px; padding-top: 12px; padding-bottom: 12px; background: white; box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.05); border-radius: 8px; border: 1px #E0E0E0 solid">
                    <input type="text" name="nameQuery" size="20" class="input-text" required>
                </div>
            </div>
        
        <!--비밀번호-->
            <div style="width: 900px; height: 107px; left: 195px; top: 526px; position: absolute; opacity: 0.50; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 8px; display: inline-flex">
                <div style="align-self: stretch; color: black; font-size: 25px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 24px; word-wrap: break-word">Password</div>
                <div style="width: 900px; height: 75px; padding-left: 16px; padding-right: 16px; padding-top: 12px; padding-bottom: 12px; background: white; box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.05); border-radius: 8px; border: 1px #E0E0E0 solid">
                    <input type="password" name="passwordQuery" size="20" class="input-text" required>
                </div>
            </div>
        
        <!--비밀번호 확인-->
            <div style="width: 900px; height: 107px; left: 195px; top: 658px; position: absolute; opacity: 0.50; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 8px; display: inline-flex">
                <div style="align-self: stretch; color: black; font-size: 25px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 24px; word-wrap: break-word">Confirm Password</div>
                <div style="width: 900px; height: 75px; padding-left: 16px; padding-right: 16px; padding-top: 12px; padding-bottom: 12px; background: white; box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.05); border-radius: 8px; border: 1px #E0E0E0 solid">
                    <input type="password" name="c_passwordQuery" size="20" class="input-text" required>
                </div>
            </div>
        
        <!--비밀번호 확인 버튼-->
            <button type="submit" onclick="pwtest()" value="암호확인" style="width: 90px; height: 75px; left: 1134px; top: 426px; position: absolute; background: black; box-shadow: 4px 4px 2px rgba(0, 0, 0, 0.25); border-radius: 8px; justify-content: center; align-items: center; gap: 8px; display: inline-flex; border: none; cursor: pointer;">
                <div style="color: white; font-size: 25px; font-family: 'Roboto', sans-serif; font-weight: 500; line-height: 37.50px; word-wrap: break-word">Check</div>
            </button>
        </form>

        <script type="text/javascript">
            function pwtest() {
                var p1 = document.getElementByName('password1').value;
                var p2 = document.getElementByName('password2').value;
                if( p1 != p2 ) {
                    alert("비밀번호가 일치 하지 않습니다");
                    return false;
                } else{
                    alert("비밀번호가 일치합니다");
                    return true;
                }
            }
        </script>

    </body>
</html>
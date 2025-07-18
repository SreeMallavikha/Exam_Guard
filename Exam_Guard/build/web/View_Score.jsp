<%@page import="java.text.DecimalFormat"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.sql.Connection"%>
<%@page import="Connection.Dbconnection"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>SecureMint</title>
        <meta name="description" content="">
        <meta name="keywords" content="">



        <!-- Fonts -->
        <link href="https://fonts.googleapis.com" rel="preconnect">
        <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;1,300;1,400;1,500;1,600;1,700;1,800&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Raleway:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

        <!-- Vendor CSS Files -->
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/vendor/aos/aos.css" rel="stylesheet">
        <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
        <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">

        <!-- Main CSS File -->
        <link href="css/main.css" rel="stylesheet">
        
    </head>
  
    <style>
        body { font-family: Arial, sans-serif; text-align: center; }
       
.score-card {
        background: #ffffff;
        border-radius: 10px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        padding: 20px;
        margin: 20px auto;
        max-width: 500px;
        text-align: center;
        animation: fadeIn 0.8s ease-in-out;
        border-left: 5px solid #007bff;
    }

    .score-card h2 {
        font-size: 24px;
        color: #333;
        font-weight: bold;
        margin-bottom: 15px;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
    }

    .score-card p {
        font-size: 18px;
        color: #555;
        margin-bottom: 10px;
    }

    .score {
        font-size: 22px;
        font-weight: bold;
        color: #007bff;
        animation: pulse 1s infinite;
    }

    .pass {
        color: green;
        font-weight: bold;
        font-size: 20px;
        animation: bounce 1s ease infinite;
    }

    .fail {
        color: red;
        font-weight: bold;
        font-size: 20px;
        animation: shake 0.5s ease-in-out infinite;
    }

    </style>
    
    <body class="index-page">

       
 <% String msg=(String)session.getAttribute("msg");
    if(msg!=null){
    %>
    <script> alert("<%=msg %>"); </script>
    <% } session.removeAttribute("msg");  %>
           

        <header id="header" class="header fixed-top">



            <div class="branding d-flex align-items-center">

                <div class="container position-relative d-flex align-items-center justify-content-between">
                    <a href="index.jsp" class="logo d-flex align-items-center">
                        <!-- Uncomment the line below if you also wish to use an image logo -->
                        <!-- <img src="assets/img/logo.png" alt=""> -->
                        <h1 class="sitename">SecureMint</h1>
                    </a>

                    <nav id="navmenu" class="navmenu">
                        <ul>             
                             <li><a href="Student_Home.jsp" > Home</a></li>    
                            <li><a href="Student_View_Exam.jsp" class="active">View Exam</a></li>   
                             <li><a href="Exam_Results.jsp">Your Result</a></li>
                            <li><a href="index.html" >Logout</a></li>
                        </ul>
                        <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
                    </nav>

                </div>

            </div>
        </header>

      
        <main class="main">

            <!-- Hero Section -->
            <section id="hero" class="hero section dark-background">

                <img src="assets/img/home2.jpg" alt="" data-aos="fade-in">

                <div class="container" data-aos="fade-up" data-aos-delay="100">
                    <div class="row justify-content-start">
                        <div class="col-lg-8">
                            <h2>Welcome to SecureMint</h2>
                            <p>Revolutionizing Exams with Blockchain ? Secure, Transparent, and Tamper-Proof!</p>
                            <a href="#about" class="btn-get-started">Get Started</a>
                        </div>
                    </div>
                </div>

            </section><!-- /Hero Section -->

<%
    String studentId = request.getParameter("ST_ID");
    String ceId = request.getParameter("CE_Id");

    if (studentId == null || ceId == null) {
        session.setAttribute("msg", "Session Expired! Please Login.");
        response.sendRedirect("error.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    int totalQuestions = 0;
    int correctAnswers = 0;

    try {
        Class.forName("com.mysql.jdbc.Driver"); 
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/exam_guard", "root", "admin");

        // Query to count correct answers
        String sql = "SELECT COUNT(*) FROM student_answers sa "
                   + "JOIN questions q ON sa.Q_ID = q.id "
                   + "WHERE sa.Student_ID = ? AND sa.CE_Id = ? AND sa.answer = q.correctAnswer";
        ps = con.prepareStatement(sql);
        ps.setString(1, studentId);
        ps.setString(2, ceId);
        rs = ps.executeQuery();

        if (rs.next()) {
            correctAnswers = rs.getInt(1);
        }
        rs.close();
        ps.close();

        // Query to count total questions
        String sqlTotal = "SELECT COUNT(*) FROM questions WHERE CE_Id = ?";
        ps = con.prepareStatement(sqlTotal);
        ps.setString(1, ceId);       
        rs = ps.executeQuery();
        

        if (rs.next()) {
            totalQuestions = rs.getInt(1);
        }
        rs.close();
        ps.close();

        // Calculate percentage
        double percentage = (totalQuestions > 0) ? ((double) correctAnswers / totalQuestions) * 100 : 0;
        DecimalFormat df = new DecimalFormat("0.00");

%>

    <div class="score-card">
        <h2>Your Exam Score</h2>
        <p><strong>Correct Answers:</strong> <%= correctAnswers %> / <%= totalQuestions %></p>
        <p><strong>Percentage:</strong> <span class="score"><%= df.format(percentage) %>%</span></p>
        
        <% if (percentage >= 50) { %>
            <p style="color: green; font-size: 20px;">Congratulations! You Passed!</p>
        <% } else { %>
            <p class="fail" style="font-size: 20px;">You Failed.</p>
        <% } %>
        
        <a href="Student_View_Exam.jsp">Go Back</a>
    </div>

<%
    } catch (Exception e) {
        e.printStackTrace();
        session.setAttribute("msg", "Error fetching score!");
        response.sendRedirect("error.jsp");
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (Exception ignored) {}
    }
%>
  <footer id="footer" class="footer position-relative dark-background" style="background-color:white;">

            <div class="container footer-top" style="color:black;">
                <div class="row gy-4">
                    <div class="col-lg-4 col-md-6">
                        <div class="footer-about">
                            <a href="index.html" class="logo sitename">SecureMint</a>
                            <div class="footer-contact pt-3">
                                <p>Chennai Central,</p>
                                <p>Anna Salai, Chennai, 600003.</p>
                                <p class="mt-3"><strong>Phone:</strong> <span>+91 98765 41230</span></p>
                                <p><strong>Email:</strong> <span>info@bustrack.com</span></p>
                            </div>
                            <div class="social-links d-flex mt-4">
                                <a href=""><i class="bi bi-twitter-x"></i></a>
                                <a href=""><i class="bi bi-facebook"></i></a>
                                <a href=""><i class="bi bi-instagram"></i></a>
                                <a href=""><i class="bi bi-linkedin"></i></a>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-2 col-md-3 footer-links" style="color:black;">
                        <h4 style="color:black">Useful Links</h4>
                        <ul>
                            <li><a href="#">Home</a></li>
                            <li><a href="#">About us</a></li>
                            <li><a href="#">Services</a></li>
                            <li><a href="User_Reg.jsp">Register</a></li>
                            <li><a href="User_Log.jsp">Login</a></li>
                        </ul>
                    </div>

                    <div class="col-lg-2 col-md-3 footer-links" style="color:black;">
                        <h4  style="color:black">Our Services</h4>
                        <ul>
                            <li><a href="#">Decentralized Auctions</a></li>
                            <li><a href="#">Smart Contract Management</a></li>
                            <li><a href="#">Bid Tracking</a></li>
                            <li><a href="#">Transaction History</a></li>
                            <li><a href="#">Instant Alerts</a></li>
                        </ul>

                    </div>

                    <div class="col-lg-4 col-md-12 footer-newsletter">
                        <h4  style="color:black">Our Newsletter</h4>
                        <p style="color:black">Subscribe to our newsletter and receive the latest news about auctions!</p>
                        <form action="forms/newsletter.php" method="post" class="php-email-form">
                            <div class="newsletter-form"><input type="email" name="email"><input type="submit" value="Subscribe"></div>
                            <div class="loading">Loading</div>
                            <div class="error-message"></div>
                            <div class="sent-message">Your subscription request has been sent. Thank you!</div>
                        </form>
                    </div>

                </div>
            </div>


        </footer>

        <!-- Scroll Top -->
        <a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

        <!-- Preloader -->


        <!-- Vendor JS Files -->
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/vendor/php-email-form/validate.js"></script>
        <script src="assets/vendor/aos/aos.js"></script>
        <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
        <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
        <script src="assets/vendor/imagesloaded/imagesloaded.pkgd.min.js"></script>
        <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>

        <!-- Main JS File -->
        <script src="js/main.js"></script>

    </body>
</html>


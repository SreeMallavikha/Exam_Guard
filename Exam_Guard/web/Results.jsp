<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>

<%@page import="Connection.Dbconnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.DecimalFormat"%>

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
<link href="css/form.css" rel="stylesheet">
        

    </head>
    <style>
        #hero img{
            opacity: 2;
        }
   
        #hero img{
            opacity: 2;
        }
        
          .exam-container {
    max-width: 600px;
    margin: 20px auto;
    padding: 15px;
    background: #f9f9f9;
    border-radius: 10px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}

.exam-container p {
    font-size: 16px;
    color: #333;
    margin: 5px 0;
}

.exam-container a {
    display: inline-block;
    margin-top: 10px;
    padding: 8px 15px;
    background: #007bff;
    color: white;
    text-decoration: none;
    border-radius: 5px;
    transition: 0.3s ease-in-out;
}

.exam-container a:hover {
    background: #0056b3;
}


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

    .score-card h2,h4 {
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
           

          
        <%
            Integer id = (Integer) session.getAttribute("SF_Id");
            String name = (String) session.getAttribute("Email");

            if (id != null && name != null) {
                try {
                    Dbconnection db = new Dbconnection();
                    ResultSet rs = db.Select("SELECT * FROM staff_register WHERE SF_Id='" + id + "' AND Email='" + name + "'");
                    if (rs.next()) {
                        String User_Name = rs.getString("User_Name");
                        String Staff_Id = rs.getString("SF_Id");
                        String Staff_Email = rs.getString("Email");
        %>
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
                             <li><a href="Staff_Home.jsp" > Home</a></li>    
                            <li><a href="Create_Exam.jsp">Create Exam</a></li>            
                            <li><a href="Your_Exam.jsp">View Exam</a></li>
                            <li><a href="Results.jsp" class="active">Exam Results</a></li>
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
            
            
            
            <h2 class="header-title">Exam Results</h2>

<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet ts = null;

    try {
        Class.forName("com.mysql.jdbc.Driver"); 
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/exam_guard", "root", "admin");

        // Assuming Staff_Id is stored in session
        int staffId = (int) session.getAttribute("SF_Id");

        // Fetch all exams created by this staff
        String sqlExams = "SELECT CE_Id, Exam_Name FROM create_exam WHERE Staff_Id = ?";
        ps = con.prepareStatement(sqlExams);
        ps.setInt(1, staffId);
        ts = ps.executeQuery();

        while (ts.next()) {
            int CE_Id = ts.getInt("CE_Id");
            String Exam_Name = ts.getString("Exam_Name");

            // Fetch all students who attempted this exam
            String sqlStudents = "SELECT DISTINCT Student_ID FROM student_answers WHERE CE_Id = ?";
            PreparedStatement psStudents = con.prepareStatement(sqlStudents);
            psStudents.setInt(1, CE_Id);
            ResultSet rsStudents = psStudents.executeQuery();

            if (!rsStudents.isBeforeFirst()) { 
%>
                <h4>No students have taken the <%= Exam_Name %> exam yet.</h4>
<% 
            }

            while (rsStudents.next()) {
                int Student_ID = rsStudents.getInt("Student_ID");
                int correctAnswers = 0;
                int totalQuestions = 0;

                // Get student name
                String studentName = "";
                String sqlStudentName = "SELECT User_Name FROM student_register WHERE ST_ID = ?";
                PreparedStatement psStudentName = con.prepareStatement(sqlStudentName);
                psStudentName.setInt(1, Student_ID);
                ResultSet rsStudentName = psStudentName.executeQuery();

                if (rsStudentName.next()) {
                    studentName = rsStudentName.getString("User_Name");
                }
                rsStudentName.close();
                psStudentName.close();

                // Query to count correct answers for this student in this exam
                String sqlCorrect = "SELECT COUNT(*) FROM student_answers sa "
                                + "JOIN questions q ON sa.Q_ID = q.id "
                                + "WHERE sa.Student_ID = ? AND sa.CE_Id = ? AND sa.answer = q.correctAnswer";
                PreparedStatement psCorrect = con.prepareStatement(sqlCorrect);
                psCorrect.setInt(1, Student_ID);
                psCorrect.setInt(2, CE_Id);
                ResultSet rsCorrect = psCorrect.executeQuery();

                if (rsCorrect.next()) {
                    correctAnswers = rsCorrect.getInt(1);
                }
                rsCorrect.close();
                psCorrect.close();

                // Query to count total questions for this exam
                String sqlTotal = "SELECT COUNT(*) FROM questions WHERE CE_Id = ?";
                PreparedStatement psTotal = con.prepareStatement(sqlTotal);
                psTotal.setInt(1, CE_Id);
                ResultSet rsTotal = psTotal.executeQuery();

                if (rsTotal.next()) {
                    totalQuestions = rsTotal.getInt(1);
                }
                rsTotal.close();
                psTotal.close();

                // Calculate percentage
                double percentage = (totalQuestions > 0) ? ((double) correctAnswers / totalQuestions) * 100 : 0;
                DecimalFormat df = new DecimalFormat("0.00");
%>

    <div class="score-card">
        <h2><i class="bi bi-pencil-square"></i> Exam Name: <%= Exam_Name %></h2>
        <h4><i class="bi bi-person-circle"></i> Student Name: <%= studentName %></h4>
        <p><strong><i class="bi bi-check-circle"></i> Correct Answers:</strong> <%= correctAnswers %> / <%= totalQuestions %></p>
        <p><strong><i class="bi bi-bar-chart-line"></i> Percentage:</strong> <span class="score"><%= df.format(percentage) %>%</span></p>

        <% if (percentage >= 50) { %>
            <p class="pass"><i class="bi bi-emoji-smile-fill"></i> Passed</p>
        <% } else { %>
            <p class="fail"><i class="bi bi-emoji-frown-fill"></i> Failed</p>
        <% } %>
    </div>

<%
            } // End student loop
            rsStudents.close();
            psStudents.close();
        } // End exam loop
    } catch (Exception e) {
        e.printStackTrace();
        session.setAttribute("msg", "Error fetching scores!");
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

  
        <%
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        } else {
            session.setAttribute("msg", "Session Out Please Login");
            response.sendRedirect("error.jsp");
        }
        %>
        

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


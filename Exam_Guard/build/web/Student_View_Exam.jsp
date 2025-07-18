<%@page import="Connection.Dbconnection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>
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

    </style>
    
    
    <body class="index-page">
 
 <% String msg=(String)session.getAttribute("msg");
    if(msg!=null){
    %>
    <script> alert("<%=msg %>"); </script>
    <% } session.removeAttribute("msg");  %>
           

          
        <%
            Integer id = (Integer) session.getAttribute("ST_ID");
            String name = (String) session.getAttribute("Email");

            if (id != null && name != null) {
                try {
                    Dbconnection db = new Dbconnection();
                    ResultSet rs = db.Select("SELECT * FROM student_register WHERE ST_ID='" + id + "' AND Email='" + name + "'");
                    if (rs.next()) {
                        String User_Name = rs.getString("User_Name");
                        String Staff_Id = rs.getString("ST_ID");
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
    // Fetch exams from the database
    ResultSet ts = db.Select("SELECT * FROM create_exam");
    
    // Get current date and time
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Date currentTime = new Date();
%>

<h2 class="header-title">Live Exams</h2>
<%
    ts.beforeFirst(); // Reset ResultSet
    boolean liveExamFound = false;
    
    while (ts.next()) {
        String CE_Id = ts.getString("CE_Id");
        String Exam_Name = ts.getString("Exam_Name");
        String Start_Time = ts.getString("Start_Time");
        String End_Time = ts.getString("End_Time");
        String Total_Marks = ts.getString("Total_Marks");

        Date startTime = sdf.parse(Start_Time);
        Date endTime = sdf.parse(End_Time);

        if (currentTime.after(startTime) && currentTime.before(endTime)) { // Live Exams
            liveExamFound = true;
%>
    <div class="exam-container live">
        <p><strong>Exam Name:</strong> <%=Exam_Name%></p> 
        <p><strong>Start Time:</strong> <%=Start_Time%></p> 
        <p><strong>End Time:</strong> <%=End_Time%></p> 
        <p><strong>Total Marks:</strong> <%=Total_Marks%></p> 
        <a href="Start_Exam.jsp?CE_Id=<%=CE_Id%>">Start Exam</a>
    </div>
<% 
        }
    }
    if (!liveExamFound) { 
%>
    <h4 style="text-align:center; margin: 30px;">No Exams Found</h4>
<%
    }
%>

<h2 class="header-title">Upcoming Exams</h2>
<%
    ts.beforeFirst(); // Reset ResultSet
    boolean upcomingExamFound = false;
    
    while (ts.next()) {
        Date startTime = sdf.parse(ts.getString("Start_Time"));

        if (currentTime.before(startTime)) { // Upcoming Exams
            upcomingExamFound = true;
%>
    <div class="exam-container upcoming">
        <p><strong>Exam Name:</strong> <%=ts.getString("Exam_Name")%></p> 
        <p><strong>Start Time:</strong> <%=ts.getString("Start_Time")%></p> 
        <p><strong>End Time:</strong> <%=ts.getString("End_Time")%></p> 
        <p><strong>Total Marks:</strong> <%=ts.getString("Total_Marks")%></p> 
    </div>
<% 
        }
    }
    if (!upcomingExamFound) { 
%>
    <h4 style="text-align:center; margin: 30px;">No Exams Found</h4>
<%
    }
%>

<h2 class="header-title">Expired Exams</h2>
<%
    ts.beforeFirst(); // Reset ResultSet
    boolean expiredExamFound = false;
    
    while (ts.next()) {
        Date endTime = sdf.parse(ts.getString("End_Time"));

        if (currentTime.after(endTime)) { // Expired Exams
            expiredExamFound = true;
%>
    <div class="exam-container expired">
        <p><strong>Exam Name:</strong> <%=ts.getString("Exam_Name")%></p> 
        <p><strong>Start Time:</strong> <%=ts.getString("Start_Time")%></p> 
        <p><strong>End Time:</strong> <%=ts.getString("End_Time")%></p> 
        <p><strong>Total Marks:</strong> <%=ts.getString("Total_Marks")%></p> 
    </div>
<% 
        }
    }
    if (!expiredExamFound) { 
%>
    <h4 style="text-align:center; margin: 30px;">No Exams Found</h4>
<%
    }
%>

        </main>
   
     

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


import Connection.Dbconnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet(urlPatterns = {"/Student_Login"})
public class Student_Login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(true);

        try {
            Dbconnection dbConnection = new Dbconnection(); // Create instance of Dbconnection
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String enteredOtp = request.getParameter("otp");

            // Retrieve OTP from session
            String sessionEmail = (String) session.getAttribute("email");
            Integer sessionOtp = (Integer) session.getAttribute("otp");

            if (sessionEmail != null && sessionOtp != null && email.equals(sessionEmail) && Integer.parseInt(enteredOtp) == sessionOtp) {
                // OTP is correct, proceed with login

                String query = "SELECT * FROM student_register WHERE Email=?";
                PreparedStatement st = dbConnection.getConnection().prepareStatement(query);
                st.setString(1, email);
                ResultSet rs = st.executeQuery();

                if (rs.next()) {
                    String storedHashedPassword = rs.getString("Password");
                    // Check if entered password matches stored hash
                    if (BCrypt.checkpw(password, storedHashedPassword)) {
                        int id = rs.getInt("ST_ID");
                        session.setAttribute("msg", "Successfully Login");
                        session.setAttribute("ST_ID", id);
                        session.setAttribute("Email", email);
                        response.sendRedirect("Student_Home.jsp");
                    } else {
                        session.setAttribute("msg", "Invalid username or password");
                        response.sendRedirect("Student_Login.jsp");
                    }
                } else {
                    session.setAttribute("msg", "Invalid username or password");
                    response.sendRedirect("Student_Login.jsp");
                }
            } else {
                session.setAttribute("msg", "Invalid OTP");
                response.sendRedirect("Student_Login.jsp");
            }
        } catch (Exception ex) {
            out.println(ex);
            ex.printStackTrace(); //Crucial for debugging
        } finally {
            out.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
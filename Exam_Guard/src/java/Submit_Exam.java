import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Submit_Exam")
public class Submit_Exam extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer studentId = (Integer) session.getAttribute("ST_ID");
        String ceId = request.getParameter("CE_Id");

        if (studentId == null || ceId == null) {
            session.setAttribute("msg", "Session Expired! Please Login.");
            response.sendRedirect("error.jsp");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver"); // Load MySQL driver
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/exam_guard", "root", "admin");

            // Check if student already submitted
            String checkQuery = "SELECT COUNT(*) FROM student_answers WHERE Student_Id = ? AND CE_Id = ?";
            ps = con.prepareStatement(checkQuery);
            ps.setInt(1, studentId);
            ps.setString(2, ceId);
            rs = ps.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                session.setAttribute("msg", "You have already submitted this exam!");
                response.sendRedirect("View_Score.jsp?ST_ID=" + studentId + "&CE_Id=" + ceId);
                return;
            }
            rs.close();
            ps.close();

            // Insert answers
            String sql = "INSERT INTO student_answers (Student_Id, CE_Id, Q_ID, answer) VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(sql);

            Map<String, String[]> answers = request.getParameterMap();
            for (String key : answers.keySet()) {
                if (key.startsWith("answers[")) {
                    String questionId = key.replace("answers[", "").replace("]", "");
                    String selectedAnswer = answers.get(key)[0];

                    ps.setInt(1, studentId);
                    ps.setString(2, ceId);
                    ps.setInt(3, Integer.parseInt(questionId));
                    ps.setString(4, selectedAnswer);
                    ps.addBatch();
                }
            }
            ps.executeBatch();

            // Redirect to view_score.jsp after submission
            response.sendRedirect("View_Score.jsp?ST_ID=" + studentId + "&CE_Id=" + ceId);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", "Error submitting exam. Try again!");
            response.sendRedirect("error.jsp");
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception ignored) {}
        }
    }
}

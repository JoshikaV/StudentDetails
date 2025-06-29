<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head><title>Student Info</title></head>
<body>

<h2>Student Info Form</h2>
<form method="post">
    Student ID: <input type="text" name="student_id" /><br/><br/>
    Name: <input type="text" name="name" /><br/><br/>
    Address: <input type="text" name="address" /><br/><br/>
    Program: <input type="text" name="program" /><br/><br/>
    <input type="submit" value="Submit" />
</form>

<%
    String id = request.getParameter("student_id");
    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String program = request.getParameter("program");

    if (id != null && name != null && address != null && program != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        Statement stmt = null;

        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/student", "postgres", "Littlestar@18");

            // Step 1: Create table if not exists
            String createTableSQL = "CREATE TABLE IF NOT EXISTS registeration (" +
                                    "student_id INTEGER PRIMARY KEY, " +
                                    "name VARCHAR(100) NOT NULL, " +
                                    "address TEXT, " +
                                    "program VARCHAR(100));";
            stmt = conn.createStatement();
            stmt.executeUpdate(createTableSQL);

            // Step 2: Insert data
            String sql = "INSERT INTO information (student_id, name, address, program) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(id));
            pstmt.setString(2, name);
            pstmt.setString(3, address);
            pstmt.setString(4, program);

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                out.println("<h3>✅ Student added successfully!</h3>");
            } else {
                out.println("<h3>⚠️ Insertion failed.</h3>");
            }

        } catch (Exception e) {
            out.println("<p>❌ Error: " + e.getMessage() + "</p>");
        } finally {
            if (stmt != null) try { stmt.close(); } catch (Exception e) {}
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
    }
%>

</body>
</html>

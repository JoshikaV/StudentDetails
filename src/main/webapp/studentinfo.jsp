<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Info Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            padding: 40px;
        }

        h2 {
            text-align: center;
        }
        
         form {
            background-color: #fff;
            width:100;
            max-width: 500px;
            margin: auto;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
            box-sizing:border-box;
        }

        input[type="text"], input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 4px;
            border: 1px solid #ccc;
            box-sizing:border-box;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            margin-top: 20px;
            cursor: pointer;
            box-sizing:border-box;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
            box-sizing:border-box;
        }

        .message {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
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
                "jdbc:postgresql://localhost:5432/student", "postgres", "password");

           
            String createTableSQL = "CREATE TABLE IF NOT EXISTS registeration (" +
                                    "student_id INTEGER PRIMARY KEY, " +
                                    "name VARCHAR(100) NOT NULL, " +
                                    "address TEXT, " +
                                    "program VARCHAR(100));";
            stmt = conn.createStatement();
            stmt.executeUpdate(createTableSQL);

           
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

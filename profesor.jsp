<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="config.ConexionBD"%>
<%
    // SEGURIDAD ESTRICTA
    HttpSession sesion = request.getSession();
    String usuario = (String) sesion.getAttribute("usuario");
    String rol = (String) sesion.getAttribute("rol");

    if (rol == null || !rol.equals("PROFESOR")) {
        response.sendRedirect("inicio.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel Profesor - Sistema Universidad</title>
    <style>
        * { box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background-color: #e9ecef; margin: 0; padding: 0; }
        .navbar { background-color: #343a40; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .navbar a { color: white; text-decoration: none; padding: 8px 15px; background: #495057; border-radius: 5px; transition: 0.3s; }
        .navbar a:hover { background: #6c757d; }
        
        .container { max-width: 900px; margin: 30px auto; padding: 0 20px; }
        
        .table-container { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); border-top: 4px solid #28a745; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #dee2e6; }
        th { background-color: #f8f9fa; color: #495057; }
        tr:hover { background-color: #f1f3f5; }
    </style>
</head>
<body>

   

    <div class="container">
        <div class="table-container">
            <h2 style="margin-top: 0; color: #28a745;">Listado de Alumnos Registrados</h2>
            <p>Aquí puedes consultar todos los alumnos del sistema.</p>
            
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Matrícula</th>
                        <th>Nombre Completo</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        ConexionBD bd = new ConexionBD();
                        Connection conexion = bd.getConnection();
                        if (conexion != null) {
                            try {
                                String sql = "SELECT * FROM alumno ORDER BY id_alumno ASC";
                                Statement st = conexion.createStatement();
                                ResultSet rs = st.executeQuery(sql);
                                
                                boolean hayAlumnos = false;
                                while(rs.next()) {
                                    hayAlumnos = true;
                    %>
                                    <tr>
                                        <td><%= rs.getInt("id_alumno") %></td>
                                        <td><strong><%= rs.getString("matricula") %></strong></td>
                                        <td><%= rs.getString("nombre") %> <%= rs.getString("apellido") %></td>
                                    </tr>
                    <%
                                }
                                if(!hayAlumnos){
                                    out.print("<tr><td colspan='3'>No hay alumnos registrados.</td></tr>");
                                }
                            } catch(Exception e) {
                                out.print("<tr><td colspan='3' style='color:red;'>Error al cargar datos.</td></tr>");
                            } finally {
                                conexion.close();
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
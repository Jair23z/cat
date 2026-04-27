<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="config.ConexionBD"%>
<%
    // SEGURIDAD: Solo entran ALUMNOS
    HttpSession sesion = request.getSession();
    String usuario = (String) sesion.getAttribute("usuario");
    String rol = (String) sesion.getAttribute("rol");

    if (rol == null || !rol.equals("ALUMNO")) {
        response.sendRedirect("inicio.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Perfil de Alumno - Sistema Universidad</title>
    <style>
        * { box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background-color: #e9ecef; margin: 0; padding: 20px; }
        .container { max-width: 600px; margin: 20px auto; }
        
        .profile-card { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); border-top: 4px solid #17a2b8; }
        .profile-card h2 { margin-top: 0; color: #17a2b8; }
        
        .data-group { margin-bottom: 15px; padding-bottom: 15px; border-bottom: 1px solid #eee; }
        .data-group label { color: #6c757d; font-size: 14px; font-weight: bold; display: block; margin-bottom: 5px; }
        .data-group span { color: #343a40; font-size: 18px; }
        
        .btn-volver { display: inline-block; padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; border-radius: 5px; margin-top: 20px; transition: 0.3s; }
        .btn-volver:hover { background: #5a6268; }
    </style>
</head>
<body>

    <div class="container">
        <div class="profile-card">
            <h2>Mi Perfil Estudiantil</h2>
            <p style="color: #6c757d;">Datos registrados en el sistema.</p>
            
            <% 
                ConexionBD bd = new ConexionBD();
                Connection conexion = bd.getConnection();
                if (conexion != null) {
                    try {
                        // Buscamos los datos del alumno basado en su usuario de login
                        String sql = "SELECT a.matricula, a.nombre, a.apellido FROM alumno a INNER JOIN login l ON a.id_login = l.id_login WHERE l.usuario = ?";
                        PreparedStatement ps = conexion.prepareStatement(sql);
                        ps.setString(1, usuario);
                        ResultSet rs = ps.executeQuery();
                        
                        if(rs.next()) {
            %>
                            <div class="data-group">
                                <label>Matrícula</label>
                                <span><%= rs.getString("matricula") %></span>
                            </div>
                            <div class="data-group">
                                <label>Nombre Completo</label>
                                <span><%= rs.getString("nombre") %> <%= rs.getString("apellido") %></span>
                            </div>
                            <div class="data-group">
                                <label>Usuario de Acceso</label>
                                <span><%= usuario %></span>
                            </div>
            <%
                        } else {
                            out.print("<p style='color:red;'>No se encontraron tus datos de alumno.</p>");
                        }
                    } catch(Exception e) {
                        out.print("<p style='color:red;'>Error al cargar perfil.</p>");
                    } finally {
                        conexion.close();
                    }
                }
            %>

            <a href="inicio.jsp" class="btn-volver">Volver al Inicio</a>
        </div>
    </div>
</body>
</html>
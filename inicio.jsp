<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession();
    String usuario = (String) sesion.getAttribute("usuario");
    String rol = (String) sesion.getAttribute("rol");

    if(usuario == null){
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inicio - Sistema Universidad</title>
    <style>
        * { box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background-color: #e9ecef; margin: 0; padding: 0; }
        .navbar { background-color: #343a40; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .navbar a { color: white; text-decoration: none; padding: 8px 15px; background: #dc3545; border-radius: 5px; transition: 0.3s; }
        .navbar a:hover { background: #c82333; }
        
        .container { max-width: 900px; margin: 40px auto; padding: 0 20px; text-align: center; }
        h1 { color: #343a40; }
        
        .menu-grid { display: flex; justify-content: center; gap: 20px; margin-top: 40px; flex-wrap: wrap; }
        .menu-card { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); width: 250px; text-decoration: none; color: #343a40; transition: transform 0.2s; border-top: 4px solid #007bff; display: block; }
        .menu-card:hover { transform: translateY(-5px); }
        .menu-card h3 { margin: 0 0 10px 0; }
        .menu-card p { color: #6c757d; font-size: 14px; margin: 0; }
        
        .card-profesor { border-top-color: #28a745; }
    </style>
</head>
<body>

  

    <div class="container">
        <h1>Bienvenido a tu Portal</h1>
        <p style="color: #6c757d;">¿Qué deseas hacer hoy?</p>
        
        <div class="menu-grid">
            <!-- Tarjeta que todos pueden ver -->
            <a href="materias.jsp" class="menu-card">
                <h3>Materias</h3>
                <p>Ver y administrar el catálogo de materias.</p>
            </a>
            
            <!-- Tarjeta exclusiva del profesor -->
            <% if(rol != null && rol.equals("PROFESOR")) { %>
                <a href="profesor.jsp" class="menu-card card-profesor">
                    <h3>Panel de Alumnos</h3>
                    <p>Revisar el listado de alumnos inscritos.</p>
                </a>
            <% } %>
            
              <!-- AGREGA ESTO NUEVO PARA EL ALUMNO -->
            <% if(rol != null && rol.equals("ALUMNO")) { %>
                <a href="alumno.jsp" class="menu-card" style="border-top-color: #17a2b8;">
                    <h3>Mi Perfil</h3>
                    <p>Consultar mis datos escolares.</p>
                </a>
            <% } %>
        </div>
    </div>
</body>
</html>
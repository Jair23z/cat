<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="config.ConexionBD"%>
<%
    // SEGURIDAD: Leer sesión y rol
    HttpSession sesion = request.getSession();
    String usuario = (String) sesion.getAttribute("usuario");
    String rol = (String) sesion.getAttribute("rol"); // Necesitamos saber el rol

    if (usuario == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Materias - Sistema Universidad</title>
    <style>
        * { box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background-color: #e9ecef; margin: 0; padding: 0; }
        .navbar { background-color: #343a40; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .navbar a { color: white; text-decoration: none; padding: 8px 15px; background: #495057; border-radius: 5px; transition: 0.3s; }
        .navbar a:hover { background: #6c757d; }
        
        .container { max-width: 900px; margin: 30px auto; padding: 0 20px; }
        
        /* Estilos del formulario para el profesor */
        .form-panel { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); margin-bottom: 30px; border-left: 5px solid #28a745; }
        .form-panel h3 { margin-top: 0; color: #28a745; }
        .input-group { display: flex; gap: 10px; margin-top: 15px; }
        .input-group input { flex: 1; padding: 10px; border: 1px solid #ced4da; border-radius: 5px; outline: none; }
        .input-group button { background: #28a745; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; font-weight: bold; transition: 0.3s; }
        .input-group button:hover { background: #218838; }

        /* Estilos de las tarjetas de materias */
        .grid-materias { display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 20px; }
        .card { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); transition: transform 0.2s; border-top: 4px solid #007bff; }
        .card:hover { transform: translateY(-5px); }
        .card h4 { margin: 0 0 10px 0; color: #343a40; font-size: 18px; }
        .tag { display: inline-block; background: #e9ecef; color: #495057; padding: 5px 10px; border-radius: 15px; font-size: 12px; font-weight: bold; }
    </style>
</head>
<body>

  

    <div class="container">
        
        <!-- ========================================== -->
        <!-- ZONA EXCLUSIVA PARA EL PROFESOR -->
        <!-- ========================================== -->
        <% if (rol != null && rol.equals("PROFESOR")) { %>
            <div class="form-panel">
                <h3>Agregar Nueva Materia</h3>
                <form action="AgregarMateriaServlet" method="POST">
                    <div class="input-group">
                        <input type="text" name="nombre" placeholder="Ej. Matemáticas Discretas" required>
                        <input type="number" name="semestre" placeholder="Semestre (1-10)" required style="max-width: 150px;">
                        <button type="submit">Guardar</button>
                    </div>
                </form>
            </div>
        <% } %>

        <!-- ========================================== -->
        <!-- ZONA PÚBLICA: LISTA DE MATERIAS -->
        <!-- ========================================== -->
        <h2 style="color: #495057; margin-bottom: 20px;">Catálogo de Materias</h2>
        
        <div class="grid-materias">
            <% 
                ConexionBD bd = new ConexionBD();
                Connection conexion = bd.getConnection();
                if (conexion != null) {
                    try {
                        String sql = "SELECT * FROM materias ORDER BY id_materia DESC";
                        Statement st = conexion.createStatement();
                        ResultSet rs = st.executeQuery(sql);
                        
                        boolean hayMaterias = false;
                        while(rs.next()) {
                            hayMaterias = true;
            %>
                            <!-- Tarjeta de Materia -->
                            <div class="card">
                                <h4><%= rs.getString("nombre_materia") %></h4>
                                <span class="tag">Semestre <%= rs.getInt("semestre") %></span>
                            </div>
            <%
                        }
                        
                        if(!hayMaterias){
                            out.print("<p style='grid-column: 1 / -1;'>No hay materias registradas aún.</p>");
                        }
                    } catch(Exception e) {
                        out.print("<p style='color:red;'>Error al cargar datos.</p>");
                    } finally {
                        conexion.close();
                    }
                } else {
                    out.print("<p style='color:red;'>Error de conexión a la BD.</p>");
                }
            %>
        </div>

    </div>
</body>
</html>
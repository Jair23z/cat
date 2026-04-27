package servlets;

import config.ConexionBD;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "AgregarMateriaServlet", urlPatterns = {"/AgregarMateriaServlet"})
public class AgregarMateriaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Obtener la sesión para saber quién está logueado
        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("usuario");
        
        // Si por alguna razón no hay sesión, lo regresamos al login
        if (usuario == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // 2. Recibir datos del formulario
        String nombre = request.getParameter("nombre");
        int semestre = Integer.parseInt(request.getParameter("semestre"));
        
        ConexionBD bd = new ConexionBD();
        Connection conexion = bd.getConnection();
        
        try {
            // 3. Buscar el id_profesor del usuario que inició sesión
            int idProfesor = 0;
            String sqlProfe = "SELECT p.id_profesor FROM profesor p INNER JOIN login l ON p.id_login = l.id_login WHERE l.usuario = ?";
            PreparedStatement psProfe = conexion.prepareStatement(sqlProfe);
            psProfe.setString(1, usuario);
            ResultSet rsProfe = psProfe.executeQuery();
            
            if (rsProfe.next()) {
                idProfesor = rsProfe.getInt("id_profesor");
            }
            
            // 4. Ahora sí, Insertar la materia INCLUYENDO el id_profesor
            if (idProfesor > 0) {
                String sqlInsert = "INSERT INTO materias (nombre_materia, semestre, id_profesor) VALUES (?, ?, ?)";
                PreparedStatement psInsert = conexion.prepareStatement(sqlInsert);
                psInsert.setString(1, nombre);
                psInsert.setInt(2, semestre);
                psInsert.setInt(3, idProfesor);
                psInsert.executeUpdate();
            }
            
            conexion.close();
            
            // Redirigir para ver la nueva materia en la lista
            response.sendRedirect("materias.jsp");
            
        } catch (Exception e) {
            System.out.println("Error al agregar materia: " + e.getMessage());
        }
    }
}
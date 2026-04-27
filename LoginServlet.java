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

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Recibir los datos que el usuario escribió en la pantalla (index.jsp)
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");

        // 2. Conectarnos a tu base de datos PostgreSQL
        ConexionBD bd = new ConexionBD();
        Connection conexion = bd.getConnection();

        try {
            // 3. Preparar la consulta SQL
            String sql = "SELECT * FROM login WHERE usuario = ? AND password = ?";
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setString(1, usuario);
            ps.setString(2, password);

            // Ejecutar la consulta
            ResultSet rs = ps.executeQuery();

            // 4. Verificar si PostgreSQL encontró al usuario
            if (rs.next()) {
                // ¡Lo encontró! Vamos a leer qué ROL tiene en la base de datos
                String rol = rs.getString("rol");

                // 5. Crear la "Pulsera VIP" (Sesión)
                javax.servlet.http.HttpSession sesion = request.getSession();
                sesion.setAttribute("usuario", usuario); // Guardamos su nombre
                sesion.setAttribute("rol", rol);         // Guardamos si es PROFESOR o ALUMNO

                // Lo mandamos a la página de Inicio que pide tu libreta
                response.sendRedirect("inicio.jsp");
            } else {
                // Si no lo encontró, el login falló.
                request.setAttribute("error", "Usuario o contraseña incorrectos");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }

            conexion.close();

        } catch (Exception e) {
            System.out.println("Error en el LoginServlet: " + e.getMessage());
        }
    }
}

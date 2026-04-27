package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/LogoutServlet"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Obtener la sesión actual
        HttpSession sesion = request.getSession();
        
        // 2. Destruir la sesión (quitarle la pulsera al usuario)
        sesion.invalidate();
        
        // 3. Mandarlo de vuelta a la pantalla de login
        response.sendRedirect("index.jsp");
    }
}
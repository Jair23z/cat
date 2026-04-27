<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login - Sistema Universidad</title>
        <style>
            body { 
                font-family: Arial, sans-serif; 
                display: flex; 
                justify-content: center; 
                align-items: center; 
                height: 100vh; 
                background-color: #f4f4f9; 
            }
            .login-box { 
                background: white; 
                padding: 30px; 
                border-radius: 8px; 
                box-shadow: 0 4px 8px rgba(0,0,0,0.1); 
                text-align: center;
                width: 300px;
            }
            input { 
                width: 90%; 
                padding: 10px; 
                margin: 10px 0; 
                border: 1px solid #ccc; 
                border-radius: 4px; 
            }
            button { 
                width: 100%; 
                padding: 10px; 
                background-color: #28a745; 
                color: white; 
                border: none; 
                border-radius: 4px; 
                cursor: pointer; 
                font-size: 16px;
            }
            button:hover { background-color: #218838; }
            .error { color: red; margin-bottom: 10px; }
        </style>
    </head>
    <body>
        <div class="login-box">
            <h2>Bienvenido</h2>
            
            <!-- Aquí mostraremos un error si se equivocan de contraseña -->
            <% if(request.getAttribute("error") != null) { %>
                <div class="error"><%= request.getAttribute("error") %></div>
            <% } %>

            <!-- Este formulario enviará los datos al Servlet que vamos a crear -->
            <form action="LoginServlet" method="POST">
                <input type="text" name="usuario" placeholder="Usuario" required>
                <input type="password" name="password" placeholder="Contraseña" required>
                <button type="submit">Ingresar</button>
            </form>
        </div>
    </body>
</html>
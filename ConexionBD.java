package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {
    
    // VARIABLES PARA CONECTAR A POSTGRESQL (¡Cámbialas por tus datos reales!)
    private final String URL = "jdbc:postgresql://localhost:5432/proyecto_salas";
    private final String USER = "postgres";
    private final String PASSWORD = "jair";

    public Connection getConnection() {
        Connection conexion = null;
        try {
            // 1. Cargar el Driver de PostgreSQL que descargamos en el pom.xml
            Class.forName("org.postgresql.Driver");
            
            // 2. Intentar conectar a la base de datos
            conexion = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("¡Conexión a PostgreSQL exitosa!");
            
        } catch (ClassNotFoundException e) {
            System.out.println("Error: Faltó el Driver de PostgreSQL (revisa el pom.xml)");
        } catch (SQLException e) {
            System.out.println("Error al conectar a la Base de Datos: " + e.getMessage());
        }
        return conexion;
    }
}
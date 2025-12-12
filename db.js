import mysql from "mysql2/promise";
import dotenv from "dotenv";
dotenv.config();

export async function getConnection() {
  return mysql.createConnection({
    host: process.env.DB_HOST  ||"localhost",
    user: process.env.DB_USER  ||"anton",
    password: process.env.DB_PASS  ||"qwerty123456",
    database: process.env.DB_NAME  ||"sud",
    port: process.env.DB_PORT ? Number(process.env.DB_PORT) : 3306,
  });
}

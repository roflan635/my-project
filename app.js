import express from "express";
import mysql from "mysql2/promise";
import dotenv from "dotenv";
dotenv.config();
  
const connection = mysql.createPool({
  host: "localhost",
  user: "anton",
  database: "sud",
  password: "qwerty123456",
  port: 3306
});

const app = express();
app.use(express.urlencoded({ extended: true }));

app.set("view engine", "hbs");

// Простейший роут для проверки сервера
app.get("/", (req, res) => {
  res.send("Сервер работает!");
});

// Роут для страницы авторизации
app.get("/login", (req, res) => {
  res.render("login");
});

// Роут для обработки формы авторизации
app.post("/login", async (req, res) => {
  const { username, password } = req.body;
  console.log("Логин:", username);
  console.log("Пароль:", password);
  const [rows] = await connection.query(
    "SELECT * FROM user WHERE username=? AND password=?",
    [username, password]
  );
  if (rows.length > 0) {
    res.send("Авторизация успешна!");
  } else {
    res.send("Неверный логин или пароль");
  }
});

app.listen(3000, () => {
  console.log("Сервер запущен на http://localhost:3000");
});

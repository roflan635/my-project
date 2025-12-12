import express from "express";
import mysql from "mysql2/promise";
import dotenv from "dotenv";
import cookieParser from "cookie-parser";
dotenv.config();

var app = express()
app.use(cookieParser());

const connection = mysql.createPool({
  host: "localhost",
  user: "anton",
  database: "sud",
  password: "qwerty123456",
  port: 3306
});


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
    "SELECT id_us, username, password FROM user WHERE username=? AND password=?",
    [username, password]
  );
  if (rows.length > 0) {
    const userId = rows[0].id_us;
    res.cookie('userId', userId);
    res.send("Авторизация успешна!"); 
    res.redirect("/profile");
  } else {
    res.send("Неверный логин или пароль");
  }
});

app.get("/profile", async (req, res) => {
  const userId = req.cookies.userId;
    // Получаем данные пользователя по ID
    const [rows] = await connection.query(
      "SELECT id_us, username, password, login, phone_number FROM user WHERE id_us = ?",
      [userId]
    );
      if (rows.length > 0) {
      const user = rows[0];
      res.render("profile", { 
        username: user.username,
        password: user.password,
        login: user.login,
        phone_number: user.phone_number
      })};
  });

app.listen(3000, () => {
  console.log("Сервер запущен на http://localhost:3000");
});

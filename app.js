import express from "express";
import { getConnection } from "./db.js";
import mysql from "mysql2";
  
const connection = mysql.createConnection({
  host: "localhost",
  user: "anton",
  database: "sud",
  password: "qwerty123456"
});


connection.connect(function(err){
    if (err) {
      return console.error("Ошибка: " + err.message);
    }
    else{
      console.log("Подключение к серверу MySQL успешно установлено");
    }
 });

 connection.end(function(err) {
  if (err) {
    return console.log("Ошибка: " + err.message);
  }
  console.log("Подключение закрыто");
});

const app = express();
app.use(express.urlencoded({ extended: true }));

app.set("view engine", "hbs");
app.set("JS", "./JS");

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

  const connection = await getConnection();
  try {
    const [rows] = await connection.query(
      "SELECT * FROM user WHERE username=? AND password=?",
      [username, password]
    );
    if (rows.length > 0) {
      res.send("Авторизация успешна!");
    } else {
      res.send("Неверный логин или пароль");
    }
  } catch (err) {
    console.error(err);
    res.send("Ошибка сервера");
  } finally {
    await connection.end();
  }
});

app.listen(3000, () => {
  console.log("Сервер запущен на http://localhost:3000");
});

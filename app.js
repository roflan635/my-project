import express from "express";
import mysql from "mysql2/promise";
import dotenv from "dotenv";
import cookieParser from "cookie-parser";
import crypto from "crypto";
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

app.get("/category", async (req, res) => {
  let str= await catalog(0);
  console.log(str)
  res.render("category", {
    str:str
  });
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
    const sessionToken = crypto.randomBytes(32).toString('hex');
    const expiresAt = new Date();
    expiresAt.setDate(expiresAt.getDate());
    await connection.query(
      "INSERT INTO sessions (user_id, session_hash, expires_at) VALUES (?, ?, ?)",
      [userId, sessionToken, expiresAt]
    );
    res.cookie('session_token', sessionToken);
    res.redirect("/profile");
  } else {
    res.send("Неверный логин или пароль");
  }
});

app.get("/profile", async (req, res) => {
  const sessionToken = req.cookies.session_token;
  const [sessionRows] = await connection.query(
    "SELECT s.user_id, s.expires_at, u.username, u.password, u.login, u.phone_number FROM sessions s INNER JOIN user u ON u.id_us=s.user_id WHERE session_hash = ?",
    [sessionToken]
  );
  if (sessionRows.length === 0) {
    return res.status(401).send("Сессия не найдена. Пожалуйста, войдите снова.");
  }
  const session = sessionRows[0];
  const now = new Date();
  const expiresAt = new Date(session.expires_at);
  console.log(sessionRows);
  if (sessionRows.length > 0) {
        const user = sessionRows[0];
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

async function catalog(parent_id) {
  const [rows] = await connection.query( `SELECT id_c, category_name, parent_id FROM categories WHERE parent_id = ${parent_id}`
  );

  let str1 = "";
  str1 += '<li>';
  for(let i = 0; i<rows.length; i++){
    rows[i];
    str1 += '<ul>';
    console.log(rows[i]);
    str1 += '<li>';
    str1 += rows[i].category_name;
    str1 += await catalog(rows[i].id_c);
    str1 += '</li>';
  }
  str1 += '</ul>';
  return str1;
}
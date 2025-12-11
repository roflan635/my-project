const mysql = require("mysql2");
  
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

 connection.query("SELECT u.username AS 'Пользователь', GROUP_CONCAT(r.role_name SEPARATOR ' | ') AS 'Права' FROM user u INNER JOIN user_has_role uhr ON u.id_us=uhr.user_id_us INNER JOIN role r ON r.id_r=uhr.role_id_r GROUP BY u.username;",
  function(err, results, fields) {
    console.log(err);
    console.log(results); // собственно данные
    console.log(fields); // мета-данные полей 
});

 connection.end(function(err) {
  if (err) {
    return console.log("Ошибка: " + err.message);
  }
  console.log("Подключение закрыто");
});
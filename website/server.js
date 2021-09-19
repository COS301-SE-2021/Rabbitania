const express = require("express");

const app = express();

app.use(express.static("./dist/website"));
app.use((req, res, next) => {
  if (req.header('x-forwarded-proto') !== 'https')
    res.redirect(`https://www.rabbitania.co.za`)
  else
    next()
});

app.get("/*", function (req, res) {
  res.sendFile("index.html", { root: "dist/website" });
});

app.listen(process.env.PORT || 8080);

console.log(`Running on port ${process.env.PORT || 8080}`);
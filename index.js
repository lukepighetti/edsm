const express = require("express");
const app = express();
const port = 3000;

const options = require("./content");

app.get("/", (req, res) => {
  res.send("OK");
});

app.get("/leaderboard", (req, res) => {
  res.send("FPO: Not yet implemented");
});

// Return two options to pick a winner
app.get("/duel", (req, res) => {
  const optionAIndex = Math.floor(Math.random() * options.length);
  let optionBIndex = null;

  while (optionBIndex === null || optionAIndex === optionBIndex) {
    optionBIndex = Math.floor(Math.random() * options.length);
  }

  res.send({
    optionA: options[optionAIndex],
    optionB: options[optionBIndex],
    debug: {
      optionAIndex,
      optionBIndex,
    },
  });
});

// Vote on a winner of a duel
app.post("/duel", (req, res) => {
  res.send("FPO");
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});

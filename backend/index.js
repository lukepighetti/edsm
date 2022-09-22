const express = require("express");
const app = express();
const port = 3000;

const options = require("./content");
const { elo } = require("./elo");

app.use(express.json());

app.get("/", (req, res) => {
  res.send("OK");
});

app.get("/leaderboard", (req, res) => {
  const leaderboard = options.sort((a, z) => z.rank - a.rank);
  res.json(leaderboard);
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
  const { optionAId, optionBId, winnerId } = req.body;

  if (!optionAId || !optionBId || !winnerId) {
    res.statusCode = 400;
    res.send("We need an optionAId and and optionBId");
  }

  if (optionAId !== winnerId && optionBId != winnerId) {
    res.statusCode = 400;
    res.send("winnerId has to match optionAId or optionBId");
  }

  const optionAWon = optionAId === winnerId;
  const optionA = options.find((e) => e.id == optionAId);
  const optionB = options.find((e) => e.id == optionBId);
  const optionARank = optionA.rank;
  const optionBRank = optionB.rank;

  const { newWinnerRank, newLoserRank } = elo({
    winnerRank: optionAWon ? optionARank : optionBRank,
    loserRank: optionAWon ? optionBRank : optionARank,
  });

  optionA.rank = optionAWon ? newWinnerRank : newLoserRank;
  optionB.rank = optionAWon ? newLoserRank : newWinnerRank;

  res.send({
    debug: {
      newWinnerRank,
      newLoserRank,
      optionARankDelta: optionA.rank - optionARank,
      optionBRankDelta: optionB.rank - optionBRank,
      optionARankBefore: optionARank,
      optionBRankBefore: optionBRank,
      optionARankAfter: optionA.rank,
      optionBRankAfter: optionB.rank,
      optionAWon,
    },
  });
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});

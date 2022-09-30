// Calculate new elo ranks based on winner/loser existing ranks
// https://en.wikipedia.org/wiki/Elo_rating_system#Theory
function elo({ winnerRank, loserRank }) {
  return {
    newWinnerRank: getNewRating(winnerRank, loserRank, 1.0).me,
    newLoserRank: getNewRating(winnerRank, loserRank, 1.0).them,
  };
}

// https://github.com/moroshko/elo.js/blob/master/elo.js
function getRatingDelta(myRating, opponentRating, myGameResult) {
  if ([0, 0.5, 1].indexOf(myGameResult) === -1) {
    return null;
  }

  var myChanceToWin = 1 / (1 + Math.pow(10, (opponentRating - myRating) / 400));

  return Math.round(32 * (myGameResult - myChanceToWin));
}

function getNewRating(myRating, opponentRating, myGameResult) {
  return {
    me: myRating + getRatingDelta(myRating, opponentRating, myGameResult),
    them:
      opponentRating - getRatingDelta(myRating, opponentRating, myGameResult),
  };
}

module.exports = { elo };

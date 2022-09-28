import "./HomeRoute.css";

function HomeRoute() {
  return (
    <div className="App">
      <div>
        <a href="/leaderboard">Leaderboard</a>
      </div>
      <div>
        <a href="/duel">Duel</a>
      </div>
      <div>Home!!!!</div>
      <iframe
        src="https://giphy.com/embed/otbWvETTuSu64"
        width="480"
        height="409"
        frameBorder="0"
        className="giphy-embed"
        allowFullScreen
      ></iframe>
      <p>
        <a href="https://giphy.com/gifs/snes-super-nintendo-mortal-kombat-otbWvETTuSu64">
          via GIPHY
        </a>
      </p>
    </div>
  );
}

export default HomeRoute;

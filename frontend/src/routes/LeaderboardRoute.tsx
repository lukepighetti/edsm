import { useQuery } from "@tanstack/react-query";
import { getLeaderboard } from "../client";

import "./LeaderboardRoute.css";

function LeaderboardRoute() {
  const query = useQuery(["leaderboard"], getLeaderboard);

  return (
    <div className="App">
      <h3>Leaderboard</h3>
      <a href="/duel">Start a duel</a>

      {query.isFetched ? (
        <table>
          <tbody>
            <tr>
              <th>rank</th>
              <th>name</th>
              <th>link</th>
            </tr>
            {query.data?.map((e) => (
              <tr key={e.id}>
                <td>{e.rank}</td>
                <td>{e.name}</td>
                <td>
                  <a href={`https://pub.dev/packages/${e.name}`}>pub</a>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      ) : (
        <div>loading...</div>
      )}
    </div>
  );
}

export default LeaderboardRoute;

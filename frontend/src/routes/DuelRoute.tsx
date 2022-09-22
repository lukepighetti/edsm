import { useState } from "react";
import reactLogo from "./assets/react.svg";
import { useQuery } from "@tanstack/react-query";

import "./DuelRoute.css";
import { getDuel, postDuel } from "../client";

function DuelRoute() {
  const [count, setCount] = useState(0);
  const query = useQuery(["leaderboard"], getDuel, {
    refetchOnWindowFocus: false,
  });

  async function voteA() {
    await postDuel({
      winnerId: query.data?.optionA.id!,
      optionAId: query.data?.optionA.id!,
      optionBId: query.data?.optionB.id!,
    });

    query.refetch();
  }

  async function voteB() {
    await postDuel({
      winnerId: query.data?.optionB.id!,
      optionAId: query.data?.optionA.id!,
      optionBId: query.data?.optionB.id!,
    });

    query.refetch();
  }

  return (
    <div className="App">
      <a href="/leaderboard">{"Leaderboard"}</a>
      {query.isFetched ? (
        <>
          <table>
            <tbody>
              <tr>
                <th>package</th>
                <th>link</th>
                <th></th>
              </tr>
              <tr>
                <td>
                  {query.data?.optionA.name}
                  {"  "}
                </td>
                <td>
                  <a
                    href={`https://pub.dev/packages/${query.data?.optionA.name}`}
                  >
                    pub
                  </a>
                </td>
                <td>
                  <button onClick={voteA}>Vote</button>
                </td>
              </tr>
              <tr>
                <td>
                  {query.data?.optionB.name}
                  {"  "}
                </td>
                <td>
                  <a
                    href={`https://pub.dev/packages/${query.data?.optionB.name}`}
                  >
                    pub
                  </a>
                </td>
                <td>
                  <button onClick={voteB}>Vote</button>
                </td>
              </tr>
              <tr>
                <td></td>
                <td></td>
                <td>
                  <button onClick={() => query.refetch()}>Skip</button>
                </td>
              </tr>
            </tbody>
          </table>
          <div>
            <img src="https://c.tenor.com/Pw1pJ85bumwAAAAC/mortal-kombat-scorpion.gif" />
          </div>
        </>
      ) : (
        <div>loading</div>
      )}
    </div>
  );
}

export default DuelRoute;

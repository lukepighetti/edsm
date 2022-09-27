type Option = { id: number; rank: number; name: string };

type Leaderboard = Option[];

const baseUrl = "https://edsm.ngrok.io";

export async function getLeaderboard(): Promise<Leaderboard> {
  const res = await fetch(`${baseUrl}/leaderboard`);
  return res.json();
}

type Duel = {
  optionA: Option;
  optionB: Option;
};

export async function getDuel(): Promise<Duel> {
  const res = await fetch(`${baseUrl}/duel`);
  return res.json();
}

type DuelVote = {
  optionAId: number;
  optionBId: number;
  winnerId: number;
};

export async function postDuel(vote: DuelVote): Promise<void> {
  const res = await fetch(`${baseUrl}/duel`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(vote),
  });

  return res.json();
}

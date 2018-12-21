enum Difficulty { Easy, Medium, Hard }

int lengthForDifficulty(Difficulty diff) {
  switch (diff) {
    case Difficulty.Easy:
      return 7;
    case Difficulty.Medium:
      return 5;
    case Difficulty.Hard:
      return 3;
  }
  return -1;
}

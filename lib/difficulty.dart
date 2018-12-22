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

// milliseconds in to file to actually start
int startForDifficulty(Difficulty diff) {
  switch (diff) {
    case Difficulty.Easy:
      return 4173;
    case Difficulty.Medium:
      return 4128;
    case Difficulty.Hard:
      return 3981;
  }
  return -1;
}

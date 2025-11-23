process.stdin.resume();
process.stdin.setEncoding("utf8");
const lines = [];
const reader = require("readline").createInterface({
  input: process.stdin,
  output: process.stdout,
});
reader.on("line", (line) => lines.push(line));
reader.on("close", () => {
  const [H, W] = lines[0].split(" ").map(Number);
  const grid = createGrid();
  let start = findSG("S");
  let goal = findSG("G");

  function createGrid() {
    const res = [];
    for (let i = 0; i < H; i++) {
      const row = lines[i + 1].split("");
      res.push(row);
    }
    return res;
  }

  function findSG(char) {
    for (let i = 0; i < H; i++) {
      const row = lines[i + 1].split("");
      for (let j = 0; j < W; j++) {
        if (row[j] === char) {
          return [i, j];
        }
      }
    }
    console.log(`Error: ${char} not found`);
    return null;
  }

  const MAX = 1000;
  const cost = Array.from({ length: H }, () => Array(W).fill(MAX));
  const visited = Array.from({ length: H }, () => Array(W).fill(false));
  cost[start[0]][start[1]] = 0;

  const dx = [1, -1, 0, 0];
  const dy = [0, 0, 1, -1];

  const directions = {
    down: { dx: 1, dy: 0 },
    up: { dx: -1, dy: 0 },
    right: { dx: 0, dy: 1 },
    left: { dx: 0, dy: -1 },
  };

  function addCost(_cell) {
    return _cell === "S" || _cell === "G" ? 0 : Number(_cell);
  }

  function execute() {
    while (true) {
      // まだ訪問してない中で、一番コストが小さいマスを探す
      let minCost = MAX;
      let x = -1;
      let y = -1;
      for (let i = 0; i < H; i++) {
        for (let j = 0; j < W; j++) {
          if (!visited[i][j] && cost[i][j] < minCost) {
            minCost = cost[i][j];
            x = i;
            y = j;
          }
        }
      }

      if (x === goal[0] && y === goal[1]) {
        return cost[x][y];
      }

      visited[x][y] = true;

      for (let dir in directions) {
        const _x = x + directions[dir].dx;
        const _y = y + directions[dir].dy;
        if (_x < 0 || _x >= H || _y < 0 || _y >= W) {
          continue;
        }

        const cell = grid[_x][_y];

        const now = cost[_x][_y];
        const entry = cost[x][y];
        const addingCost = addCost(cell);
        if (now > entry + addingCost) {
          cost[_x][_y] = entry + addingCost;
        }
      }
    }
  }

  const result = execute();
  console.log(result);
});

ArrayList<Node> nodeList = new ArrayList<Node>();
String[] names = {"A", "B", "C", "D"};

// 課題のスライドの隣接行列
int[][] m = {
  //A  B  C  D
  {2, 1, 1, 2}, // A
  {1, 0, 0, 1}, // B
  {1, 0, 0, 1}, // C
  {2, 1, 1, 0} // D
};

// ケーニヒスベルクの隣接行列
//int[][] m = {
//  //A  B  C  D
//  {0, 2, 2, 1}, // A
//  {2, 0, 0, 1}, // B
//  {2, 0, 0, 1}, // C
//  {1, 1, 1, 0} // D
//};

void setup() {
  // 隣接行列を元に接続関係を保持したnodeを作りnodeListに追加
  for (int i=0; i<m.length; i++) {
    Node node = new Node(names[i]);
    for (int j=0; j<m[0].length; j++) {
      // 隣接行列の値が0ならば何もせず次のループへ
      if (m[i][j] == 0) {
        continue;
      }

      while (m[i][j] != 0) {
        // 隣接ノードをリストに追加
        node.neighbors(j);

        // 隣接ノードを登録するたびに隣接行列の値を減らす
        if (i == j) {
          // 自分のところに戻ってくるループなので2ずつ減らす
          m[i][j] -= 2;
        } else {
          // 通常のエッジなので1ずつ減らす
          m[i][j] --;
        }
      }
    }

    // このノードについては情報登録が終わったのでリストに追加
    nodeList.add(node);
  }

  boolean ret = dfs(0);
  if (ret) {
    println("End");
  } else {
    println("Not Found");
  }
}

boolean dfs(int id) {
  Node node = nodeList.get(id);
  int next = node.neighbor();

  // dfsの途中で手詰まりになる = オイラー閉路がない
  // 手詰まりになって良いのはスタート地点に戻った時だけ
  if (next == -1) {
    if (id == 0) {
      return true;
    } else {
      return false;
    }
  }

  do {
    // これから行く先にも同じエッジが登録されているので削除する
    nodeList.get(next).remove(id);

    print(node.name() + nodeList.get(next).name() + "->");
    if (!dfs(next)) {
      return false;
    }
    next = node.neighbor();
  } while(next != -1);

  return true;
}

void draw() {
  noLoop();
}

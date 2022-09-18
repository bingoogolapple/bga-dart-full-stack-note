class Node {
  List<Node> children;
  String name;

  Node(this.name, this.children);
}

/**
 * 使用 sync* 标记方法，且返回类型为 Iterable<T>，那么该方法内部可以使用 yield 来返回元素
 */
Iterable<Node> forAllChildren(Node parentNode) sync* {
  if (parentNode.children.length == 0) {
    print('============> before forAllChildren ${parentNode.name}');
  } else {
    print('====> before forAllChildren ${parentNode.name}');
  }
  for (var childNode in parentNode.children) {
    print('========> beforeYield ${childNode.name}');
    yield childNode;
    print('========> afterYield ${childNode.name}');
    // 可以使用 yield* 从 Iterable 中继续获取元素
    yield* forAllChildren(childNode);
    print('========> afterYield* ${childNode.name}');
  }
  if (parentNode.children.length == 0) {
    print('============> after forAllChildren ${parentNode.name}');
  } else {
    print('====> after forAllChildren ${parentNode.name}');
  }
}

main() {
  Node child11 = Node('child11', []);
  Node child12 = Node('child12', []);

  Node child21 = Node('child21', []);
  Node child22 = Node('child22', []);

  Node child1 = Node('child1', [child11, child12]);
  Node child2 = Node('child2', [child21, child22]);

  Node root = Node('root', [child1, child2]);
  for (Node node in forAllChildren(root)) {
    print(node.name);
  }
}

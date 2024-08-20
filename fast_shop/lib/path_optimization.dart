import 'dart:math';
import 'package:flutter/material.dart';

class Node {
  final Offset position;
  final String name;
  double cost;
  double heuristic;
  Node? parent;

  Node({
    required this.position,
    required this.name,
    this.cost = 0.0,
    this.heuristic = 0.0,
    this.parent,
  });

  double get totalCost => cost + heuristic;
}

class AStar {
  List<Node> findShortestPath(Offset start, Offset end, List<Node> waypoints) {
    List<Node> openList = [];
    List<Node> closedList = [];

    Node startNode = Node(position: start, name: 'Start');
    openList.add(startNode);

    while (openList.isNotEmpty) {
      openList.sort((a, b) => a.totalCost.compareTo(b.totalCost));
      Node currentNode = openList.removeAt(0);
      closedList.add(currentNode);

      if (_areOffsetsEqual(currentNode.position, end)) {
        return _constructPath(currentNode);
      }

      List<Node> neighbors = _getNeighbors(currentNode, waypoints, end);
      for (Node neighbor in neighbors) {
        if (closedList.any((node) => _areOffsetsEqual(node.position, neighbor.position))) {
          continue;
        }

        Node? openNode = openList.firstWhere(
              (node) => _areOffsetsEqual(node.position, neighbor.position),
          orElse: () => Node(position: Offset.zero, name: ''),
        );

        if (openNode.name.isEmpty || neighbor.totalCost < openNode.totalCost) {
          openList.add(neighbor);
        }
      }
    }

    return [];
  }

  double _heuristic(Offset a, Offset b) {
    return (a.dx - b.dx).abs() + (a.dy - b.dy).abs();
  }

  bool _areOffsetsEqual(Offset a, Offset b) {
    return a.dx == b.dx && a.dy == b.dy;
  }

  List<Node> _getNeighbors(Node node, List<Node> waypoints, Offset end) {
    List<Node> neighbors = [];
    for (Node waypoint in waypoints) {
      if (!_areOffsetsEqual(node.position, waypoint.position)) {
        double cost = node.cost + _distance(node.position, waypoint.position);
        double heuristic = _heuristic(waypoint.position, end);
        neighbors.add(Node(
          position: waypoint.position,
          name: waypoint.name,
          cost: cost,
          heuristic: heuristic,
          parent: node,
        ));
      }
    }
    return neighbors;
  }

  double _distance(Offset a, Offset b) {
    return sqrt(pow(a.dx - b.dx, 2) + pow(a.dy - b.dy, 2));
  }

  List<Node> _constructPath(Node node) {
    List<Node> path = [];
    Node? currentNode = node;
    while (currentNode != null) {
      path.add(currentNode);
      currentNode = currentNode.parent;
    }
    return path.reversed.toList();
  }
}

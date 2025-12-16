// lib/providers/todo_provider.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todo.dart';
import 'dart:async';


class TodoProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  List<Todo> _todos = [];
  bool _isLoading = false;
  StreamSubscription<QuerySnapshot>? _todosSubscription;


  List<Todo> get todos => _todos;
  bool get isLoading => _isLoading;

  // 완료되지 않은 todo 개수
  int get activeTodoCount => _todos.where((todo) => !todo.completed).length;
  
  // Firestore 실시간 리스너 (Part 9에서 구현)
  void subscribeTodos(String userId) {
    _firestore
        .collection('todos')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      _todos = snapshot.docs
          .map((doc) => Todo.fromFirestore(doc))
          .toList();
      notifyListeners();
    });
  }

  // Todo 추가 (Part 9에서 구현)
  Future<void> addTodo(Todo todo) async {
    // 구현 예정
  }

  // Todo 수정 (Part 9에서 구현)
  Future<void> updateTodo(String todoId, Map<String, dynamic> updates) async {
    // 구현 예정
  }

  // Todo 삭제 (Part 9에서 구현)
  Future<void> deleteTodo(String todoId) async {
    // 구현 예정
  }

  // Todo 완료 토글 (Part 9에서 구현)
  Future<void> toggleComplete(String todoId, bool completed) async {
    // 구현 예정
  }
}

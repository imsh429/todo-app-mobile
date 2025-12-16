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
  
  // 완료된 Todo 개수
  int get completedTodoCount => _todos.where((todo) => todo.completed).length;

  // 필터링된 Todo 목록
  List<Todo> get activeTodos => _todos.where((todo) => !todo.completed).toList();
  List<Todo> get completedTodos => _todos.where((todo) => todo.completed).toList();

  // Firestore 실시간 리스너 시작
  void startListener(String userId) {
    _isLoading = true;
    notifyListeners();

    _todosSubscription = _firestore
        .collection('todos')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      _todos = snapshot.docs
          .map((doc) => Todo.fromFirestore(doc))
          .toList();
      _isLoading = false;
      notifyListeners();
    }, onError: (error) {
      print('Todo 리스너 에러: $error');
      _isLoading = false;
      notifyListeners();
    });
  }

  // 리스너 정지
  void stopListener() {
    _todosSubscription?.cancel();
    _todosSubscription = null;
    _todos = [];
    notifyListeners();
  }
  
  // Todo 추가
  Future<void> addTodo(Todo todo) async {
    try {
      await _firestore.collection('todos').add(todo.toMap());
    } catch (e) {
      print('Todo 추가 에러: $e');
      rethrow;
    }
  }

  // Todo 수정
  Future<void> updateTodo(String todoId, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection('todos').doc(todoId).update(updates);
    } catch (e) {
      print('Todo 수정 에러: $e');
      rethrow;
    }
  }

  // Todo 삭제
  Future<void> deleteTodo(String todoId) async {
    try {
      await _firestore.collection('todos').doc(todoId).delete();
    } catch (e) {
      print('Todo 삭제 에러: $e');
      rethrow;
    }
  }


  // Todo 완료 토글 (Part 9에서 구현)
  Future<void> toggleComplete(String todoId, bool completed) async {
    // 구현 예정
  }
}

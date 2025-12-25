// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/todo_provider.dart';
import '../widgets/add_todo_dialog.dart';
import '../widgets/todo_item.dart';
import 'login_screen.dart';
import 'calendar_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // TodoProvider 리스너 시작
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final todoProvider = Provider.of<TodoProvider>(context, listen: false);
      
      if (authProvider.user != null) {
        todoProvider.startListener(authProvider.user!.uid);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final todoProvider = Provider.of<TodoProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 헤더
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    // 로고
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'TaskSync',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Spacer(),
                    // 사용자 정보
                    if (user?.photoURL != null)
                      CircleAvatar(
                        backgroundImage: NetworkImage(user!.photoURL!),
                        radius: 20,
                      ),
                  ],
                ),
              ),

              // 탭 바
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  labelColor: const Color(0xFF667EEA),
                  unselectedLabelColor: Colors.white,
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.list_rounded),
                      text: '할일',
                    ),
                    Tab(
                      icon: Icon(Icons.calendar_month_rounded),
                      text: '캘린더',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 탭 뷰
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // 할일 탭
                    _buildTodoTab(todoProvider, user),
                    // 캘린더 탭
                    const CalendarScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 추가 버튼
          FloatingActionButton(
            heroTag: 'add',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddTodoDialog(),
              );
            },
            backgroundColor: const Color(0xFF667EEA),
            child: const Icon(Icons.add_rounded),
          ),
          const SizedBox(height: 16),
          // 로그아웃 버튼
          FloatingActionButton(
            heroTag: 'logout',
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('로그아웃'),
                  content: const Text('로그아웃 하시겠습니까?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('취소'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('로그아웃'),
                    ),
                  ],
                ),
              );
              
              if (confirm == true && context.mounted) {
                // TodoProvider 리스너 정지
                todoProvider.stopListener();
                
                await authProvider.signOut();
                // 로그아웃 후 LoginScreen으로 이동
                //if (context.mounted) {
                //  Navigator.of(context).pushReplacement(
                //    MaterialPageRoute(builder: (_) => const LoginScreen()),
                //  );
                //}
              }
            },
            backgroundColor: const Color(0xFFFF6B6B),
            child: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoTab(TodoProvider todoProvider, user) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFF9FAFB),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 타이틀
            const Text(
              '오늘의 할일 ✨',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '안녕하세요, ${user?.displayName ?? '사용자'}님!',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
              ),
            ),
            
            const SizedBox(height: 32),

            // Empty State / Todo 리스트
            Expanded(
              child: todoProvider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFF667EEA),
                        ),
                      ),
                    )
                  : todoProvider.todos.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFF3F4F6),
                                      Color(0xFFE5E7EB),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: const Icon(
                                  Icons.inbox_rounded,
                                  size: 56,
                                  color: Color(0xFF9CA3AF),
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                '아직 할일이 없습니다',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1A1A2E),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                '새로운 할일을 추가하여 시작해보세요!',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton.icon(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => const AddTodoDialog(),
                                  );
                                },
                                icon: const Icon(Icons.add_rounded),
                                label: const Text('첫 번째 할일 만들기'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF667EEA),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  elevation: 4,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: todoProvider.todos.length,
                          itemBuilder: (context, index) {
                            final todo = todoProvider.todos[index];
                            return TodoItem(todo: todo);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

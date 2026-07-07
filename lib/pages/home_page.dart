import 'package:flutter/material.dart';
import '../models/widget_category.dart';
import '../models/widget_info.dart';
import '../services/widget_registry.dart';
import 'widget_detail_page.dart';

/// 首页 — 底部 Tab 导航
///
/// 每个 Tab 对应一个 WidgetCategory，展示该分类下的 Widget 列表。
/// AppBar 右侧提供搜索入口。
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<WidgetCategory> _categories = WidgetRegistry.usedCategories;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openSearch() {
    showSearch(
      context: context,
      delegate: _WidgetSearchDelegate(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Widgets 指南'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: '搜索 Widget',
            onPressed: _openSearch,
          ),
        ],
      ),
      body: Column(
        children: [
          // 分类 TabBar
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: _categories.map((cat) {
                return Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(cat.icon, size: 18),
                      const SizedBox(width: 6),
                      Text(cat.label),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          // Widget 列表
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _categories.map((cat) {
                return _CategoryWidgetList(category: cat);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 分类下的 Widget 列表
// ============================================================
class _CategoryWidgetList extends StatelessWidget {
  final WidgetCategory category;
  const _CategoryWidgetList({required this.category});

  @override
  Widget build(BuildContext context) {
    final widgets = WidgetRegistry.byCategory(category);
    if (widgets.isEmpty) {
      return const Center(child: Text('暂无组件'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widgets.length,
      itemBuilder: (context, index) {
        final info = widgets[index];
        return _WidgetListTile(info: info);
      },
    );
  }
}

// ============================================================
// Widget 列表项
// ============================================================
class _WidgetListTile extends StatelessWidget {
  final WidgetInfo info;
  const _WidgetListTile({required this.info});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            info.name[0],
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                info.name,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              info.nameCn,
              style: TextStyle(fontSize: 13, color: Colors.grey[600], overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(info.description, maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => WidgetDetailPage(info: info),
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// 搜索代理
// ============================================================
class _WidgetSearchDelegate extends SearchDelegate<WidgetInfo?> {
  @override
  String get searchFieldLabel => '搜索 Widget 名称、描述...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchList(context);
  }

  Widget _buildSearchList(BuildContext context) {
    final results = WidgetRegistry.search(query);
    if (results.isEmpty) {
      return const Center(child: Text('未找到匹配的 Widget'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final info = results[index];
        return _WidgetListTile(info: info);
      },
    );
  }
}

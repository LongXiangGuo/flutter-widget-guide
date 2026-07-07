import 'package:flutter/material.dart';

/// ============================================================
/// CustomScrollView 完整用法示例
/// 涵盖：基础用法、SliverAppBar、SliverList、SliverGrid、
/// SliverToBoxAdapter、SliverPadding、SliverPersistentHeader、
/// SliverFillRemaining、SliverFixedExtentList、嵌套滚动、
/// 性能优化、常见坑解决方案
/// ============================================================

class CustomScrollViewDemo extends StatelessWidget {
  const CustomScrollViewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// 注意：因为是从上一个页面 push 过来的，这里使用 Scaffold
      /// 如果需要完全无 Scaffold，可以直接返回 CustomScrollView
      body: CustomScrollView(
        /// 1. 核心参数配置
        /// - scrollDirection: 滚动方向，默认垂直
        /// - reverse: 是否反向滚动
        /// - physics: 滚动物理特性（BouncingScrollPhysics 用于 iOS 风格回弹）
        /// - controller: 滚动控制器，用于监听和操控滚动位置
        /// - cacheExtent: 预缓存区域大小，提前构建可视区域外的 Sliver
        /// - shrinkWrap: 是否根据子内容收缩，通常设为 false（性能优化）
        physics: const BouncingScrollPhysics(),
        cacheExtent: 200.0,

        slivers: [
          // ============================================================
          // 1. SliverAppBar - 可折叠应用栏
          // ============================================================
          SliverAppBar(
            title: const Text('CustomScrollView 完整演示'),
            pinned: true, // 滚动时标题栏是否固定在顶部
            floating: false, // 向下滚动时是否立即展开
            snap: false, // 是否支持快速展开/折叠
            expandedHeight: 200.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('可折叠标题栏'),
              background: FlutterLogo(),
              centerTitle: true,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  // 重置滚动位置
                },
              ),
            ],
            // 返回按钮
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // ============================================================
          // 2. SliverPadding - 为 Sliver 添加内边距
          // ============================================================
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: _buildSectionTitle(
                '2. SliverToBoxAdapter',
                '将普通 Widget 适配为 Sliver',
              ),
            ),
          ),

          // ============================================================
          // 3. SliverToBoxAdapter - 普通 Widget 适配器
          // ============================================================
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Center(
                  child: Text(
                    '这是一个普通 Container，通过 SliverToBoxAdapter 嵌入',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // ============================================================
          // 4. SliverList - 列表
          // ============================================================
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.primaries[index % Colors.primaries.length],
                    child: Text('${index + 1}'),
                  ),
                  title: Text('列表项 #${index + 1}'),
                  subtitle: Text('这是 SliverList 中的第 ${index + 1} 项'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // 点击处理
                  },
                ),
                childCount: 10,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // ============================================================
          // 5. SliverGrid - 网格
          // ============================================================
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 每行 3 列
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 1.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                  decoration: BoxDecoration(
                    color: Colors.primaries[index % Colors.primaries.length],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                childCount: 12,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // ============================================================
          // 6. SliverFixedExtentList - 固定高度列表（性能优化）
          // ============================================================
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverFixedExtentList(
              itemExtent: 50.0, // 固定高度，性能更优
              delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                  color: index.isEven ? Colors.grey.shade200 : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text('固定高度 #${index + 1}'),
                        const Spacer(),
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                      ],
                    ),
                  ),
                ),
                childCount: 15,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // ============================================================
          // 7. SliverPersistentHeader - 粘性头部
          // ============================================================
          SliverPersistentHeader(
            delegate: _SliverHeaderDelegate(
              minHeight: 60.0,
              maxHeight: 100.0,
              child: Container(
                color: Colors.deepPurple.shade700,
                child: const Center(
                  child: Text(
                    '粘性头部 (会固定在顶部)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            pinned: true, // 滚动到顶部后保持固定
          ),

          // ============================================================
          // 8. SliverFillRemaining - 填充剩余空间
          // ============================================================
          SliverFillRemaining(
            hasScrollBody: false, // 是否可滚动
            fillOverscroll: true, // 是否填充 overscroll 区域
            child: Container(
              color: Colors.green.shade50,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 64,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'SliverFillRemaining',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '填充剩余所有空间\n当列表内容不足时，撑满整个 Viewport',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 辅助构建方法
  // ============================================================

  /// 章节标题
  Widget _buildSectionTitle(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 9. SliverPersistentHeaderDelegate - 自定义粘性头部代理
// ============================================================

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;
  final Color? backgroundColor;

  _SliverHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
    this.backgroundColor,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // 计算透明度：滚动时逐渐透明
    final progress = shrinkOffset / maxExtent;
    final opacity = 1.0 - progress.clamp(0.0, 0.8);

    return Container(
      color: backgroundColor ?? Colors.deepPurple.shade700,
      child: Opacity(
        opacity: opacity,
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SliverHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight || oldDelegate.maxHeight != maxHeight || oldDelegate.child != child;
  }
}

// ============================================================
// 10. 带滚动控制的完整示例（Stateful）
// ============================================================

class CustomScrollViewWithController extends StatefulWidget {
  const CustomScrollViewWithController({super.key});

  @override
  State<CustomScrollViewWithController> createState() => _CustomScrollViewWithControllerState();
}

class _CustomScrollViewWithControllerState extends State<CustomScrollViewWithController> {
  late final ScrollController _scrollController;
  bool _showTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final show = _scrollController.offset > 200;
    if (show != _showTopButton) {
      setState(() {
        _showTopButton = show;
      });
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('带滚动控制的 CustomScrollView'),
        actions: [
          // 实时显示滚动位置
          ListenableBuilder(
            listenable: _scrollController,
            builder: (context, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '${_scrollController.offset.toStringAsFixed(0)}px',
                  style: const TextStyle(fontSize: 14),
                ),
              );
            },
          ),
        ],
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // 使用 SliverAppBar 但不用 pinned，让标题栏跟随滚动
          SliverAppBar(
            title: const Text('内容区域'),
            backgroundColor: Colors.blue.shade100,
            expandedHeight: 150.0,
            flexibleSpace: const FlexibleSpaceBar(
              background: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          // 大量列表项
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.primaries[index % Colors.primaries.length],
                  child: Text('${index + 1}'),
                ),
                title: Text('列表项 #${index + 1}'),
                subtitle: Text('滚动位置: ${_scrollController.offset.toStringAsFixed(0)}px'),
              ),
              childCount: 50,
            ),
          ),
        ],
      ),
      floatingActionButton: _showTopButton
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              child: const Icon(Icons.arrow_upward),
              tooltip: '回到顶部',
            )
          : null,
    );
  }
}

// ============================================================
// 11. 嵌套滚动示例（NestedScrollView vs 嵌套 Sliver）
// ============================================================

class NestedScrollExample extends StatelessWidget {
  const NestedScrollExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('NestedScrollView 示例'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '列表'),
              Tab(text: '网格'),
              Tab(text: '混合'),
            ],
          ),
        ),
        body: NestedScrollView(
          // headerSliverBuilder：构建顶部折叠区域
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: const Text('可折叠头部'),
                pinned: true,
                expandedHeight: 180.0,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('NestedScrollView'),
                  background: FlutterLogo(),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
            ];
          },
          // body：使用 TabBarView 实现页面切换
          body: TabBarView(
            children: [
              // Tab 1: 列表
              _buildList(),
              // Tab 2: 网格
              _buildGrid(),
              // Tab 3: 混合
              _buildMixed(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 30,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(child: Text('${index + 1}')),
          title: Text('列表项 #${index + 1}'),
          subtitle: const Text('在 Tab 中独立滚动'),
        );
      },
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: 24,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.primaries[index % Colors.primaries.length],
          child: Center(
            child: Text(
              '${index + 1}',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMixed() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          '混合内容',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('下面是一个网格：'),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: List.generate(8, (index) {
              return Container(
                color: Colors.primaries[index % Colors.primaries.length],
                child: Center(
                  child: Text('${index + 1}', style: const TextStyle(color: Colors.white)),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 16),
        const Text('下面是列表：'),
        const SizedBox(height: 8),
        ...List.generate(10, (index) {
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text('列表项 #${index + 1}'),
          );
        }),
      ],
    );
  }
}

// ============================================================
// 12. 性能优化示例
// ============================================================

class CustomScrollViewPerformanceDemo extends StatelessWidget {
  const CustomScrollViewPerformanceDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('性能优化示例'),
      ),
      body: CustomScrollView(
        /// 性能优化关键参数：
        /// 1. cacheExtent: 预缓存区域，增大可减少滚动时的重新构建，但会增加内存
        /// 2. shrinkWrap: 设为 false，避免一次性计算所有子元素的大小
        /// 3. 使用 SliverFixedExtentList 替代 SliverList（固定高度时性能更好）
        cacheExtent: 500.0,
        slivers: [
          SliverAppBar(
            title: const Text('性能优化标题'),
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              color: Colors.blue.shade50,
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'cacheExtent = 500\n提前构建 500px 外的内容，减少滚动卡顿',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),

          // 固定高度列表 - 性能最优
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverFixedExtentList(
              itemExtent: 60.0,
              delegate: SliverChildBuilderDelegate(
                (context, index) => Card(
                  elevation: 1,
                  child: Center(
                    child: Text(
                      '固定高度 #${index + 1}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                childCount: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

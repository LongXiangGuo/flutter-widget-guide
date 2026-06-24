import 'package:flutter/material.dart';

/// ============================================================
/// Column 完整用法示例
/// 涵盖：基础用法、对齐方式、弹性布局、间距控制、嵌套组合、
/// 滚动处理、性能优化、常见坑解决方案
/// ============================================================

class ColumnDemo extends StatelessWidget {
  const ColumnDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ============================================================
          // 1. 基础用法：垂直排列子元素
          // ============================================================
          _buildSectionTitle('1. 基础用法', '最简单的垂直排列'),
          _buildBasicColumn(),

          const SizedBox(height: 24),

          // ============================================================
          // 2. MainAxisAlignment - 主轴对齐方式
          // ============================================================
          _buildSectionTitle('2. 主轴对齐 (mainAxisAlignment)', '控制子元素在垂直方向的分布'),
          _buildMainAxisAlignmentExamples(),

          const SizedBox(height: 24),

          // ============================================================
          // 3. CrossAxisAlignment - 交叉轴对齐方式
          // ============================================================
          _buildSectionTitle('3. 交叉轴对齐 (crossAxisAlignment)', '控制子元素在水平方向的对齐'),
          _buildCrossAxisAlignmentExamples(),

          const SizedBox(height: 24),

          // ============================================================
          // 4. MainAxisSize - 主轴尺寸
          // ============================================================
          _buildSectionTitle('4. 主轴尺寸 (mainAxisSize)', '控制 Column 自身高度'),
          _buildMainAxisSizeExamples(),

          const SizedBox(height: 24),

          // ============================================================
          // 5. spacing - 统一间距
          // ============================================================
          _buildSectionTitle('5. spacing 间距控制', '统一设置子元素之间的间距'),
          _buildSpacingExample(),

          const SizedBox(height: 24),

          // ============================================================
          // 6. Expanded - 弹性布局
          // ============================================================
          _buildSectionTitle('6. Expanded 弹性布局', '让子元素填充剩余空间'),
          _buildExpandedExample(),

          const SizedBox(height: 24),

          // ============================================================
          // 7. Flexible - 灵活布局
          // ============================================================
          _buildSectionTitle('7. Flexible 灵活布局', '子元素可以小于分配的空间'),
          _buildFlexibleExample(),

          const SizedBox(height: 24),

          // ============================================================
          // 8. 组合布局：Column + Row
          // ============================================================
          _buildSectionTitle('8. 组合布局', 'Column 嵌套 Row 实现复杂布局'),
          _buildCombinedLayout(),

          const SizedBox(height: 24),

          // ============================================================
          // 9. 滚动处理：Column + ListView
          // ============================================================
          _buildSectionTitle('9. 滚动处理', 'Column 与 ListView 的正确搭配'),
          _buildScrollableColumn(),

          const SizedBox(height: 24),

          // ============================================================
          // 10. 表单布局
          // ============================================================
          _buildSectionTitle('10. 表单布局', '垂直排列表单项'),
          _buildFormLayout(),

          const SizedBox(height: 24),

          // ============================================================
          // 11. 卡片内容布局
          // ============================================================
          _buildSectionTitle('11. 卡片内容布局', '卡片内的垂直排列'),
          _buildCardContent(),

          const SizedBox(height: 24),

          // ============================================================
          // 12. 性能优化：const 构造函数
          // ============================================================
          _buildSectionTitle('12. 性能优化', '使用 const 减少重建'),
          _buildPerformanceOptimization(),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // ============================================================
  // 1. 基础用法
  // ============================================================
  Widget _buildBasicColumn() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '标题',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('这是第一段内容，展示 Column 的垂直排列能力。'),
          SizedBox(height: 8),
          Text('这是第二段内容，所有子元素都会从上到下排列。'),
          SizedBox(height: 8),
          Icon(Icons.star, color: Colors.amber, size: 30),
        ],
      ),
    );
  }

  // ============================================================
  // 2. 主轴对齐方式
  // ============================================================
  Widget _buildMainAxisAlignmentExamples() {
    return Column(
      children: [
        _buildAlignmentExample(
          'start (默认) - 顶部对齐',
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        const SizedBox(height: 12),
        _buildAlignmentExample(
          'center - 居中对齐',
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        const SizedBox(height: 12),
        _buildAlignmentExample(
          'end - 底部对齐',
          mainAxisAlignment: MainAxisAlignment.end,
        ),
        const SizedBox(height: 12),
        _buildAlignmentExample(
          'spaceBetween - 两端对齐',
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        const SizedBox(height: 12),
        _buildAlignmentExample(
          'spaceAround - 环绕间距',
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
        const SizedBox(height: 12),
        _buildAlignmentExample(
          'spaceEvenly - 均匀间距',
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ],
    );
  }

  Widget _buildAlignmentExample(String label, {required MainAxisAlignment mainAxisAlignment}) {
    return Container(
      width: double.infinity,
      height: 150,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          _buildColorBox('A', Colors.red, 40),
          _buildColorBox('B', Colors.green, 40),
          _buildColorBox('C', Colors.blue, 40),
        ],
      ),
    );
  }

  // ============================================================
  // 3. 交叉轴对齐方式
  // ============================================================
  Widget _buildCrossAxisAlignmentExamples() {
    return Column(
      children: [
        _buildCrossAlignmentExample(
          'start - 左对齐',
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        const SizedBox(height: 12),
        _buildCrossAlignmentExample(
          'center - 居中（默认）',
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        const SizedBox(height: 12),
        _buildCrossAlignmentExample(
          'end - 右对齐',
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
        const SizedBox(height: 12),
        _buildCrossAlignmentExample(
          'stretch - 拉伸填充',
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
        const SizedBox(height: 12),
        _buildCrossAlignmentExample(
          'baseline - 基线对齐',
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
        ),
      ],
    );
  }

  Widget _buildCrossAlignmentExample(
    String label, {
    required CrossAxisAlignment crossAxisAlignment,
    TextBaseline? textBaseline,
  }) {
    return Container(
      width: double.infinity,
      height: 121,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        textBaseline: textBaseline,
        children: [
          _buildColorBox('短', Colors.red, 30, width: 60),
          _buildColorBox('中等宽度', Colors.green, 40, width: 100),
          _buildColorBox('很长很长', Colors.blue, 35, width: 140),
        ],
      ),
    );
  }

  // ============================================================
  // 4. MainAxisSize
  // ============================================================
  Widget _buildMainAxisSizeExamples() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // 收缩到内容高度
            children: [
              _buildColorBox('A', Colors.red, 30),
              _buildColorBox('B', Colors.green, 30),
              _buildColorBox('C', Colors.blue, 30),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '⬆️ MainAxisSize.min - 高度 = 内容高度',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          height: 150,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max, // 填充父容器高度
            children: [
              _buildColorBox('A', Colors.red, 30),
              _buildColorBox('B', Colors.green, 30),
              _buildColorBox('C', Colors.blue, 30),
            ],
          ),
        ),
        const Text(
          '⬆️ MainAxisSize.max - 高度 = 父容器高度',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  // ============================================================
  // 5. spacing 间距控制
  // ============================================================
  Widget _buildSpacingExample() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        spacing: 16, // 统一间距
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '使用 spacing: 16',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          _buildColorBox('1', Colors.red, 40),
          _buildColorBox('2', Colors.green, 40),
          _buildColorBox('3', Colors.blue, 40),
          const Text('所有子元素间距都是 16px'),
        ],
      ),
    );
  }

  // ============================================================
  // 6. Expanded 弹性布局
  // ============================================================
  Widget _buildExpandedExample() {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildColorBox('固定高度', Colors.red, 30),
          Expanded(
            flex: 2, // 占用 2/3 剩余空间
            child: _buildColorBox('flex: 2', Colors.green, 0),
          ),
          Expanded(
            flex: 1, // 占用 1/3 剩余空间
            child: _buildColorBox('flex: 1', Colors.blue, 0),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 7. Flexible 灵活布局
  // ============================================================
  Widget _buildFlexibleExample() {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.loose, // 可以小于分配空间
            child: _buildColorBox('Flexible loose', Colors.red, 0),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight, // 强制填充分配空间
            child: _buildColorBox('Flexible tight', Colors.green, 0),
          ),
          _buildColorBox('固定高度', Colors.blue, 30),
        ],
      ),
    );
  }

  // ============================================================
  // 8. 组合布局：Column + Row
  // ============================================================
  Widget _buildCombinedLayout() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题行
          Row(
            children: [
              const Icon(Icons.person, color: Colors.blue),
              const SizedBox(width: 8),
              const Text(
                '用户信息',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text('编辑'),
              ),
            ],
          ),
          const Divider(),
          // 详细信息
          const Row(
            children: [
              Text('姓名：', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('张三'),
              Spacer(),
              Text('年龄：', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('25岁'),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Text('邮箱：', style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(child: Text('zhangsan@example.com')),
            ],
          ),
          const SizedBox(height: 8),
          // 操作按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('确认'),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text('取消'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 9. 滚动处理：Column + ListView
  // ============================================================
  Widget _buildScrollableColumn() {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '固定标题（不滚动）',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          // ✅ 正确：使用 Expanded 限制 ListView 高度
          Expanded(
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.primaries[index % Colors.primaries.length],
                    child: Text('$index'),
                  ),
                  title: Text('Item $index'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 10. 表单布局
  // ============================================================
  Widget _buildFormLayout() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        spacing: 16,
        children: [
          const Text(
            '登录表单',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: '用户名',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: const Icon(Icons.person),
            ),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: '密码',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: const Icon(Icons.lock),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(value: false, onChanged: (_) {}),
                  const Text('记住我'),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text('忘记密码？'),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('登录', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 11. 卡片内容布局
  // ============================================================
  Widget _buildCardContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头部
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: const Text('A'),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '标题文字',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '副标题或描述信息',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_vert),
            ],
          ),
          const SizedBox(height: 16),
          // 内容
          const Text(
            '这是一段卡片内容。Column 可以让标题、内容和操作按钮垂直排列，'
            '是卡片布局的核心组件。',
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 16),
          // 标签行
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: const [
              Chip(label: Text('Flutter')),
              Chip(label: Text('Dart')),
              Chip(label: Text('Mobile')),
            ],
          ),
          const SizedBox(height: 16),
          // 底部操作
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.thumb_up),
                label: const Text('点赞'),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.comment),
                label: const Text('评论'),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share),
                label: const Text('分享'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 12. 性能优化
  // ============================================================
  Widget _buildPerformanceOptimization() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '✅ 使用 const 优化性能',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('const 让 Widget 在重建时被复用，减少不必要的构建。'),
          SizedBox(height: 12),
          // 这些 Widget 都是 const，在重建时不会重新创建
          Icon(Icons.star, color: Colors.amber),
          SizedBox(height: 4),
          Text('固定文本 1'),
          SizedBox(height: 4),
          Text('固定文本 2'),
          SizedBox(height: 4),
          Text('固定文本 3'),
          SizedBox(height: 8),
          Text(
            '⚠️ 注意：const 只能用于编译期常量，',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          Text(
            '动态数据不能使用 const',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 辅助工具方法
  // ============================================================

  Widget _buildColorBox(String label, Color color, double height, {double width = double.infinity}) {
    return Container(
      width: width,
      height: height > 0 ? height : null,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        const Divider(height: 1),
        const SizedBox(height: 12),
      ],
    );
  }
}

import 'package:flutter/material.dart';

/// Row 使用案例大全
///
/// 展示 Row 的各种属性组合用法，包括：
/// - mainAxisAlignment 主轴对齐
/// - crossAxisAlignment 交叉轴对齐
/// - mainAxisSize 主轴尺寸
/// - textDirection 文字方向
/// - verticalDirection 垂直方向
/// - Expanded / Flexible 弹性布局
/// - Spacer 间隔
/// - Baseline 基线对齐
/// - 嵌套与组合
class RowDemo extends StatelessWidget {
  const RowDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _SectionTitle('1. mainAxisAlignment 主轴对齐'),
          SizedBox(height: 8),
          _MainAxisAlignmentExample(),
          SizedBox(height: 24),

          _SectionTitle('2. crossAxisAlignment 交叉轴对齐'),
          SizedBox(height: 8),
          _CrossAxisAlignmentExample(),
          SizedBox(height: 24),

          _SectionTitle('3. mainAxisSize 主轴尺寸'),
          SizedBox(height: 8),
          _MainAxisSizeExample(),
          SizedBox(height: 24),

          _SectionTitle('4. textDirection 文字方向'),
          SizedBox(height: 8),
          _TextDirectionExample(),
          SizedBox(height: 24),

          _SectionTitle('5. verticalDirection 垂直方向'),
          SizedBox(height: 8),
          _VerticalDirectionExample(),
          SizedBox(height: 24),

          _SectionTitle('6. Expanded / Flexible 弹性布局'),
          SizedBox(height: 8),
          _ExpandedFlexibleExample(),
          SizedBox(height: 24),

          _SectionTitle('7. Spacer 间隔'),
          SizedBox(height: 8),
          _SpacerExample(),
          SizedBox(height: 24),

          _SectionTitle('8. Baseline 基线对齐'),
          SizedBox(height: 8),
          _BaselineExample(),
          SizedBox(height: 24),

          _SectionTitle('9. 溢出处理'),
          SizedBox(height: 8),
          _OverflowExample(),
          SizedBox(height: 24),

          _SectionTitle('10. 嵌套布局'),
          SizedBox(height: 8),
          _NestedRowExample(),
          SizedBox(height: 24),

          _SectionTitle('11. 综合案例'),
          SizedBox(height: 8),
          _CombinedRowExample(),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}

// ============================================================
// 通用小组件
// ============================================================

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }
}

class _DemoWrapper extends StatelessWidget {
  final Widget child;
  final double height;
  const _DemoWrapper({required this.child, this.height = 120});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      clipBehavior: Clip.hardEdge,
      child: child,
    );
  }
}

class _DemoBox extends StatelessWidget {
  final int index;
  final double? width;
  const _DemoBox(this.index, {this.width});

  static const _colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.cyan,
    Colors.indigo,
  ];

  @override
  Widget build(BuildContext context) {
    final color = _colors[index % _colors.length];
    return Container(
      width: width ?? (40.0 + index * 10),
      height: 40.0 + index * 12,
      color: color,
      alignment: Alignment.center,
      child: Text(
        '$index',
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}

class _LabelRow extends StatelessWidget {
  final String label;
  final Widget row;
  const _LabelRow({required this.label, required this.row});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          row,
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}

// ============================================================
// 1. mainAxisAlignment
// ============================================================
class _MainAxisAlignmentExample extends StatelessWidget {
  const _MainAxisAlignmentExample();

  @override
  Widget build(BuildContext context) {
    return const _DemoWrapper(
      height: 420,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            _LabelRow(
              label: 'start — 左对齐（默认）',
              row: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [_DemoBox(0), _DemoBox(1), _DemoBox(2)],
              ),
            ),
            _LabelRow(
              label: 'end — 右对齐',
              row: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [_DemoBox(0), _DemoBox(1), _DemoBox(2)],
              ),
            ),
            _LabelRow(
              label: 'center — 居中',
              row: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_DemoBox(0), _DemoBox(1), _DemoBox(2)],
              ),
            ),
            _LabelRow(
              label: 'spaceBetween — 两端对齐，中间均分',
              row: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_DemoBox(0), _DemoBox(1), _DemoBox(2)],
              ),
            ),
            _LabelRow(
              label: 'spaceAround — 每子元素两侧间距相等（首尾半间隔）',
              row: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [_DemoBox(0), _DemoBox(1), _DemoBox(2)],
              ),
            ),
            _LabelRow(
              label: 'spaceEvenly — 所有间隔完全相等',
              row: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [_DemoBox(0), _DemoBox(1), _DemoBox(2)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 2. crossAxisAlignment
// ============================================================
class _CrossAxisAlignmentExample extends StatelessWidget {
  const _CrossAxisAlignmentExample();

  @override
  Widget build(BuildContext context) {
    return const _DemoWrapper(
      height: 440,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            _LabelRow(
              label: 'start — 顶部对齐',
              row: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_DemoBox(0), _DemoBox(1), _DemoBox(2)],
              ),
            ),
            _LabelRow(
              label: 'center — 垂直居中（默认）',
              row: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [_DemoBox(0), _DemoBox(1), _DemoBox(2)],
              ),
            ),
            _LabelRow(
              label: 'end — 底部对齐',
              row: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [_DemoBox(0), _DemoBox(1), _DemoBox(2)],
              ),
            ),
            _LabelRow(
              label: 'stretch — 拉伸填满交叉轴（需 IntrinsicHeight）',
              row: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [_DemoBox(0), _DemoBox(1), _DemoBox(2)],
                ),
              ),
            ),
            _LabelRow(
              label: 'baseline — 基线对齐（需 textBaseline）',
              row: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: const [
                  Text('Big', style: TextStyle(fontSize: 30)),
                  SizedBox(width: 8),
                  Text('Small', style: TextStyle(fontSize: 16)),
                  SizedBox(width: 8),
                  Text('Mid', style: TextStyle(fontSize: 22)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 3. mainAxisSize
// ============================================================
class _MainAxisSizeExample extends StatelessWidget {
  const _MainAxisSizeExample();

  @override
  Widget build(BuildContext context) {
    return const _DemoWrapper(
      height: 240,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            _LabelRow(
              label: 'MainAxisSize.max — 占满父容器宽度（默认）',
              row: Row(
                mainAxisSize: MainAxisSize.max,
                children: [_DemoBox(0), _DemoBox(1), _DemoBox(2)],
              ),
            ),
            SizedBox(height: 16),
            _LabelRow(
              label: 'MainAxisSize.min — 收缩到刚好包裹子元素',
              row: Row(
                mainAxisSize: MainAxisSize.min,
                children: [_DemoBox(0), _DemoBox(1), _DemoBox(2)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 4. textDirection
// ============================================================
class _TextDirectionExample extends StatelessWidget {
  const _TextDirectionExample();

  @override
  Widget build(BuildContext context) {
    return const _DemoWrapper(
      height: 200,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            _LabelRow(
              label: 'TextDirection.ltr — 从左到右（默认）',
              row: Row(
                textDirection: TextDirection.ltr,
                children: [_DemoBox(0), _DemoBox(1), _DemoBox(2)],
              ),
            ),
            SizedBox(height: 16),
            _LabelRow(
              label: 'TextDirection.rtl — 从右到左（如阿拉伯语）',
              row: Row(
                textDirection: TextDirection.rtl,
                children: [_DemoBox(0), _DemoBox(1), _DemoBox(2)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 5. verticalDirection
// ============================================================
class _VerticalDirectionExample extends StatelessWidget {
  const _VerticalDirectionExample();

  @override
  Widget build(BuildContext context) {
    return const _DemoWrapper(
      height: 200,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            _LabelRow(
              label: 'VerticalDirection.down — 从上到下排列（默认）',
              row: Row(
                verticalDirection: VerticalDirection.down,
                children: [_DemoBox(0), _DemoBox(1), _DemoBox(2)],
              ),
            ),
            SizedBox(height: 16),
            _LabelRow(
              label: 'VerticalDirection.up — 从下到上排列交叉轴',
              row: Row(
                verticalDirection: VerticalDirection.up,
                children: [_DemoBox(0), _DemoBox(1), _DemoBox(2)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 6. Expanded / Flexible
// ============================================================
class _ExpandedFlexibleExample extends StatelessWidget {
  const _ExpandedFlexibleExample();

  @override
  Widget build(BuildContext context) {
    return const _DemoWrapper(
      height: 240,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            _LabelRow(
              label: '固定宽度 — 各自按内容宽度',
              row: Row(
                children: [
                  _DemoBox(0, width: 60),
                  _DemoBox(1, width: 60),
                  _DemoBox(2, width: 60),
                ],
              ),
            ),
            SizedBox(height: 12),
            _LabelRow(
              label: 'Expanded(flex: 1, 2, 1) — 按比例分剩余空间',
              row: Row(
                children: [
                  Expanded(flex: 1, child: _DemoBox(0)),
                  Expanded(flex: 2, child: _DemoBox(1)),
                  Expanded(flex: 1, child: _DemoBox(2)),
                ],
              ),
            ),
            SizedBox(height: 12),
            _LabelRow(
              label: 'Flexible — 允许溢出后收缩',
              row: Row(
                children: [
                  Flexible(child: _DemoBox(0, width: 120)),
                  Flexible(child: _DemoBox(1, width: 120)),
                  Flexible(child: _DemoBox(2, width: 120)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 7. Spacer
// ============================================================
class _SpacerExample extends StatelessWidget {
  const _SpacerExample();

  @override
  Widget build(BuildContext context) {
    return const _DemoWrapper(
      height: 240,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            _LabelRow(
              label: 'Spacer() — 等分剩余空间到元素之间',
              row: Row(
                children: [
                  _DemoBox(0, width: 50),
                  Spacer(),
                  _DemoBox(1, width: 50),
                  Spacer(),
                  _DemoBox(2, width: 50),
                  Spacer(),
                  _DemoBox(3, width: 50),
                ],
              ),
            ),
            SizedBox(height: 16),
            _LabelRow(
              label: 'Spacer(flex: 2), Spacer(flex: 1) — 按比例分配间隔',
              row: Row(
                children: [
                  _DemoBox(0, width: 50),
                  const Spacer(flex: 2),
                  _DemoBox(1, width: 50),
                  const Spacer(flex: 1),
                  _DemoBox(2, width: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 8. Baseline
// ============================================================
class _BaselineExample extends StatelessWidget {
  const _BaselineExample();

  @override
  Widget build(BuildContext context) {
    return const _DemoWrapper(
      height: 180,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            _LabelRow(
              label: 'alphabetic — 英文字母基线对齐',
              row: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  _DemoBox(0, width: 60),
                  Text('Abc', style: TextStyle(fontSize: 40)),
                  Text('def', style: TextStyle(fontSize: 16)),
                  _DemoBox(1, width: 60),
                ],
              ),
            ),
            SizedBox(height: 16),
            _LabelRow(
              label: 'ideographic — 中文表意基线对齐',
              row: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  _DemoBox(0, width: 60),
                  Text('中文', style: TextStyle(fontSize: 40)),
                  Text('小字', style: TextStyle(fontSize: 16)),
                  _DemoBox(1, width: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 9. 溢出处理
// ============================================================
class _OverflowExample extends StatelessWidget {
  const _OverflowExample();

  @override
  Widget build(BuildContext context) {
    return const _DemoWrapper(
      height: 420,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            _LabelRow(
              label: '普通 Row 子元素过多 → 溢出报错（已用 Clip.hardEdge 裁剪）',
              row: Row(
                children: [
                  _DemoBox(0, width: 62),
                  _DemoBox(1, width: 62),
                  _DemoBox(2, width: 62),
                  _DemoBox(3, width: 62),
                  _DemoBox(4, width: 62),
                ],
              ),
            ),
            SizedBox(height: 16),
            _LabelRow(
              label: 'SingleChildScrollView → 水平滚动',
              row: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _DemoBox(0, width: 62),
                    _DemoBox(1, width: 62),
                    _DemoBox(2, width: 62),
                    _DemoBox(3, width: 62),
                    _DemoBox(4, width: 62),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            _LabelRow(
              label: 'Wrap → 自动换行',
              row: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _DemoBox(0, width: 80),
                  _DemoBox(1, width: 80),
                  _DemoBox(2, width: 80),
                  _DemoBox(3, width: 80),
                  _DemoBox(4, width: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 10. 嵌套布局
// ============================================================
class _NestedRowExample extends StatelessWidget {
  const _NestedRowExample();

  @override
  Widget build(BuildContext context) {
    return _DemoWrapper(
      height: 220,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: const [
            _LabelRow(
              label: 'Row → 头像 + 中间 Column(标题+副标题) + 操作按钮',
              row: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('标题文本', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text('副标题描述信息', style: TextStyle(color: Colors.grey, fontSize: 13)),
                      ],
                    ),
                  ),
                  Icon(Icons.more_vert, color: Colors.grey),
                ],
              ),
            ),
            SizedBox(height: 24),
            _LabelRow(
              label: 'Row + Expanded + 固定宽度',
              row: Row(
                children: [
                  Expanded(flex: 2, child: _DemoBox(0)),
                  SizedBox(width: 8),
                  Expanded(flex: 1, child: _DemoBox(1)),
                  SizedBox(width: 8),
                  _DemoBox(2, width: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 11. 综合案例
// ============================================================
class _CombinedRowExample extends StatelessWidget {
  const _CombinedRowExample();

  @override
  Widget build(BuildContext context) {
    return _DemoWrapper(
      height: 160,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 左侧图标
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF667eea), Color(0xFF764ba2)]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.star, color: Colors.white),
            ),
            const SizedBox(width: 16),
            // 中间内容区
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('综合布局卡片', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('Row + Column + Expanded 经典组合', style: TextStyle(fontSize: 13, color: Colors.grey)),
                ],
              ),
            ),
            // 右侧箭头
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

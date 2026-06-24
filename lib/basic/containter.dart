import 'package:flutter/material.dart';

/// Container 使用案例大全
///
/// 展示 Container 的各种属性组合用法，包括：
/// - 基础颜色与尺寸
/// - padding 与 margin
/// - decoration（边框、圆角、阴影、渐变）
/// - alignment 对齐
/// - constraints 约束
/// - transform 变换
/// - clipBehavior 裁剪
/// - foregroundDecoration 前景装饰
class ContainerDemo extends StatelessWidget {
  const ContainerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle('1. 基础 Container — 纯色 + 宽高'),
          SizedBox(height: 8),
          BasicColorExample(),
          SizedBox(height: 24),

          SectionTitle('2. Padding 内边距'),
          SizedBox(height: 8),
          PaddingExample(),
          SizedBox(height: 24),

          SectionTitle('3. Margin 外边距'),
          SizedBox(height: 8),
          MarginExample(),
          SizedBox(height: 24),

          SectionTitle('4. Decoration — 边框 + 圆角'),
          SizedBox(height: 8),
          DecorationBorderExample(),
          SizedBox(height: 24),

          SectionTitle('5. Decoration — 阴影 (boxShadow)'),
          SizedBox(height: 8),
          BoxShadowExample(),
          SizedBox(height: 24),

          SectionTitle('6. Decoration — 渐变背景'),
          SizedBox(height: 8),
          GradientExample(),
          SizedBox(height: 24),

          SectionTitle('7. Decoration — 形状 (circle / 圆形)'),
          SizedBox(height: 8),
          ShapeExample(),
          SizedBox(height: 24),

          SectionTitle('8. Alignment 对齐'),
          SizedBox(height: 8),
          AlignmentExample(),
          SizedBox(height: 24),

          SectionTitle('9. Constraints 约束'),
          SizedBox(height: 8),
          ConstraintsExample(),
          SizedBox(height: 24),

          SectionTitle('10. Transform 变换'),
          SizedBox(height: 8),
          TransformExample(),
          SizedBox(height: 24),

          SectionTitle('11. clipBehavior 裁剪'),
          SizedBox(height: 8),
          ClipBehaviorExample(),
          SizedBox(height: 24),

          SectionTitle('12. foregroundDecoration 前景装饰'),
          SizedBox(height: 8),
          ForegroundDecorationExample(),
          SizedBox(height: 24),

          SectionTitle('13. 无 child 时 — 尽可能填充父容器'),
          SizedBox(height: 8),
          NoChildExample(),
          SizedBox(height: 24),

          SectionTitle('14. 组合使用 — 综合案例'),
          SizedBox(height: 8),
          CombinedExample(),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}

// ============================================================
// 通用小组件
// ============================================================

/// 章节标题
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

/// 示例外层的白色底板（带边框）
class ExampleWrapper extends StatelessWidget {
  final Widget child;
  final double height;
  const ExampleWrapper({super.key, required this.child, this.height = 80});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      clipBehavior: Clip.hardEdge,
      child: child,
    );
  }
}

// ============================================================
// 1. 基础颜色 + 宽高
// ============================================================
class BasicColorExample extends StatelessWidget {
  const BasicColorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExampleWrapper(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 纯色 Container
          _ColorLabel(
            color: Colors.blue,
            label: '纯色\n100×60',
            child: SizedBox(
              width: 100,
              height: 60,
              child: ColoredBox(color: Colors.blue),
            ),
          ),
          // ColoredBox 等价写法
          _ColorLabel(
            color: Colors.green,
            label: 'Container\nwidth+height',
            child: SizedBox(
              width: 100,
              height: 60,
              child: ColoredBox(color: Colors.green),
            ),
          ),
          _ColorLabel(
            color: Colors.orange,
            label: 'Container\ncolor',
            child: SizedBox(
              width: 100,
              height: 60,
              child: ColoredBox(color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorLabel extends StatelessWidget {
  final Widget child;
  final Color color;
  final String label;
  const _ColorLabel({
    required this.child,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        child,
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
      ],
    );
  }
}

// ============================================================
// 2. Padding
// ============================================================
class PaddingExample extends StatelessWidget {
  const PaddingExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExampleWrapper(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ColoredBox(
            color: Colors.teal,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('all:16', style: TextStyle(color: Colors.white)),
            ),
          ),
          ColoredBox(
            color: Colors.teal,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text('h:24 v:8', style: TextStyle(color: Colors.white)),
            ),
          ),
          ColoredBox(
            color: Colors.teal,
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Text('left:20\ntop:10', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 3. Margin
// ============================================================
class MarginExample extends StatelessWidget {
  const MarginExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // margin 会挤开周围空间
          Container(
            margin: const EdgeInsets.all(12),
            width: 60,
            height: 40,
            color: Colors.deepPurple,
            child: const Center(
              child: Text('m:12', style: TextStyle(color: Colors.white, fontSize: 11)),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            width: 60,
            height: 40,
            color: Colors.deepPurple,
            child: const Center(
              child: Text('h:24', style: TextStyle(color: Colors.white, fontSize: 11)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            width: 60,
            height: 40,
            color: Colors.deepPurple,
            child: const Center(
              child: Text('top:16', style: TextStyle(color: Colors.white, fontSize: 11)),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 4. Decoration — 边框 + 圆角
// ============================================================
class DecorationBorderExample extends StatelessWidget {
  const DecorationBorderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExampleWrapper(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _DemoBox(
            label: '圆角边框',
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border.fromBorderSide(BorderSide(color: Colors.blue, width: 2)),
            ),
          ),
          _DemoBox(
            label: '顶部圆角',
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              border: Border.fromBorderSide(BorderSide(color: Colors.red, width: 2)),
            ),
          ),
          _DemoBox(
            label: '虚线边框？\n需自定义painter',
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.fromBorderSide(BorderSide(color: Colors.green, width: 2)),
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoBox extends StatelessWidget {
  final String label;
  final Decoration decoration;
  const _DemoBox({required this.label, required this.decoration});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 44,
          decoration: decoration,
          child: const Center(child: Text('')),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
      ],
    );
  }
}

// ============================================================
// 5. 阴影
// ============================================================
class BoxShadowExample extends StatelessWidget {
  const BoxShadowExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExampleWrapper(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ShadowBox(
            label: '默认阴影',
            boxShadow: [
              BoxShadow(color: Colors.black26, offset: Offset(4, 4), blurRadius: 8),
            ],
          ),
          _ShadowBox(
            label: '扩散阴影',
            boxShadow: [
              BoxShadow(color: Colors.blue, offset: Offset(0, 0), blurRadius: 12, spreadRadius: 2),
            ],
          ),
          _ShadowBox(
            label: '多层阴影',
            boxShadow: [
              BoxShadow(color: Colors.blue, offset: Offset(2, 2), blurRadius: 4),
              BoxShadow(color: Colors.red, offset: Offset(-2, -2), blurRadius: 4),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShadowBox extends StatelessWidget {
  final String label;
  final List<BoxShadow> boxShadow;
  const _ShadowBox({required this.label, required this.boxShadow});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: boxShadow,
          ),
          child: const Center(child: Text('Shadow')),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
      ],
    );
  }
}

// ============================================================
// 6. 渐变背景
// ============================================================
class GradientExample extends StatelessWidget {
  const GradientExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExampleWrapper(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _GradientBox(
            label: '线性渐变',
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          _GradientBox(
            label: '径向渐变',
            gradient: RadialGradient(
              colors: [Colors.yellow, Colors.orange, Colors.red],
            ),
          ),
          _GradientBox(
            label: '扫描渐变',
            gradient: SweepGradient(
              colors: [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.purple, Colors.red],
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientBox extends StatelessWidget {
  final String label;
  final Gradient gradient;
  const _GradientBox({required this.label, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 50,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
      ],
    );
  }
}

// ============================================================
// 7. 形状 (circle)
// ============================================================
class ShapeExample extends StatelessWidget {
  const ShapeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExampleWrapper(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ShapeBox(
            label: 'BoxShape.circle',
            shape: BoxShape.circle,
            color: Colors.pink,
          ),
          _ShapeBox(
            label: '圆形头像\n效果',
            shape: BoxShape.circle,
            color: Colors.teal,
          ),
          _ShapeBox(
            label: '大圆角\n≈ 胶囊',
            shape: BoxShape.rectangle,
            color: Colors.indigo,
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
        ],
      ),
    );
  }
}

class _ShapeBox extends StatelessWidget {
  final String label;
  final BoxShape shape;
  final Color color;
  final BorderRadiusGeometry? borderRadius;
  const _ShapeBox({
    required this.label,
    required this.shape,
    required this.color,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            shape: shape,
            borderRadius: shape == BoxShape.rectangle ? borderRadius : null,
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
      ],
    );
  }
}

// ============================================================
// 8. Alignment 对齐
// ============================================================
class AlignmentExample extends StatelessWidget {
  const AlignmentExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExampleWrapper(
      height: 200,
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: [
          _AlignmentBox(label: 'topLeft', alignment: Alignment.topLeft),
          _AlignmentBox(label: 'topCenter', alignment: Alignment.topCenter),
          _AlignmentBox(label: 'topRight', alignment: Alignment.topRight),
          _AlignmentBox(label: 'centerLeft', alignment: Alignment.centerLeft),
          _AlignmentBox(label: 'center', alignment: Alignment.center),
          _AlignmentBox(label: 'centerRight', alignment: Alignment.centerRight),
          _AlignmentBox(label: 'bottomLeft', alignment: Alignment.bottomLeft),
          _AlignmentBox(label: 'bottomCenter', alignment: Alignment.bottomCenter),
          _AlignmentBox(label: 'bottomRight', alignment: Alignment.bottomRight),
        ],
      ),
    );
  }
}

class _AlignmentBox extends StatelessWidget {
  final String label;
  final Alignment alignment;
  const _AlignmentBox({required this.label, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: alignment,
      child: Text(label, style: const TextStyle(fontSize: 10, color: Colors.blue)),
    );
  }
}

// ============================================================
// 9. Constraints 约束
// ============================================================
class ConstraintsExample extends StatelessWidget {
  const ConstraintsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleWrapper(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ConstraintBox(
            label: 'min/max\n100-150',
            constraints: const BoxConstraints(
              minWidth: 100,
              maxWidth: 150,
              minHeight: 40,
              maxHeight: 60,
            ),
          ),
          _ConstraintBox(
            label: 'tight(80,50)\n紧约束',
            constraints: BoxConstraints.tightFor(width: 80, height: 50),
          ),
          _ConstraintBox(
            label: 'loose\n0-100',
            constraints: BoxConstraints.loose(const Size(100, 100)),
          ),
        ],
      ),
    );
  }
}

class _ConstraintBox extends StatelessWidget {
  final String label;
  final BoxConstraints constraints;
  const _ConstraintBox({required this.label, required this.constraints});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: constraints,
          color: Colors.amber[100],
          child: const ColoredBox(color: Colors.amber),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
      ],
    );
  }
}

// ============================================================
// 10. Transform 变换
// ============================================================
class TransformExample extends StatelessWidget {
  const TransformExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleWrapper(
      height: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _TransformBox(
            label: '旋转 15°',
            transform: Matrix4.rotationZ(0.26), // ~15°
          ),
          _TransformBox(
            label: '缩放 0.8',
            transform: Matrix4.diagonal3Values(0.8, 0.8, 1),
          ),
          _TransformBox(
            label: '平移 (10,5)',
            transform: Matrix4.translationValues(10, 5, 0),
          ),
        ],
      ),
    );
  }
}

class _TransformBox extends StatelessWidget {
  final String label;
  final Matrix4 transform;
  const _TransformBox({required this.label, required this.transform});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 50,
          transform: transform,
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text('Trans', style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ),
        const SizedBox(height: 20),
        Text(label, style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
      ],
    );
  }
}

// ============================================================
// 11. clipBehavior 裁剪
// ============================================================
class ClipBehaviorExample extends StatelessWidget {
  const ClipBehaviorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExampleWrapper(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ClipBox(
            label: 'antiAlias\n抗锯齿',
            clip: Clip.antiAlias,
          ),
          _ClipBox(
            label: 'hardEdge\n硬边缘',
            clip: Clip.hardEdge,
          ),
          _ClipBox(
            label: 'antiAlias\nWithSaveLayer',
            clip: Clip.antiAliasWithSaveLayer,
          ),
        ],
      ),
    );
  }
}

class _ClipBox extends StatelessWidget {
  final String label;
  final Clip clip;
  const _ClipBox({required this.label, required this.clip});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: clip,
          child: const ColoredBox(color: Colors.cyan),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
      ],
    );
  }
}

// ============================================================
// 12. foregroundDecoration 前景装饰
// ============================================================
class ForegroundDecorationExample extends StatelessWidget {
  const ForegroundDecorationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExampleWrapper(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _FgDecoBox(
            label: '半透明遮罩',
            foregroundDecoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          _FgDecoBox(
            label: '前景边框',
            foregroundDecoration: BoxDecoration(
              border: Border.fromBorderSide(BorderSide(color: Colors.red, width: 3)),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          _FgDecoBox(
            label: '渐变遮罩',
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black54],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}

class _FgDecoBox extends StatelessWidget {
  final String label;
  final Decoration foregroundDecoration;
  const _FgDecoBox({required this.label, required this.foregroundDecoration});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 50,
          foregroundDecoration: foregroundDecoration,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(child: Text('内容')),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
      ],
    );
  }
}

// ============================================================
// 13. 无 child — 填充父容器
// ============================================================
class NoChildExample extends StatelessWidget {
  const NoChildExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleWrapper(
      height: 120,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('无 child，无紧约束 → 自动撑满', style: TextStyle(fontSize: 12)),
                const SizedBox(height: 4),
                Expanded(
                  child: Container(color: Colors.purple[100]),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('有 child → 包裹 child', style: TextStyle(fontSize: 12)),
                const SizedBox(height: 4),
                Expanded(
                  child: Container(
                    color: Colors.purple[100],
                    child: const Center(child: Text('child')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 14. 综合案例
// ============================================================
class CombinedExample extends StatelessWidget {
  const CombinedExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleWrapper(
      height: 140,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x40667eea),
                offset: Offset(0, 8),
                blurRadius: 20,
              ),
            ],
          ),
          child: const Text(
            '✨ 综合案例',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

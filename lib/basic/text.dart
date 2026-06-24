import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// ============================================================
/// Text 完整用法示例
/// 涵盖：基础用法、样式控制、溢出处理、富文本、
/// 自定义字体、性能优化、常见坑解决方案
/// ============================================================

class TextDemo extends StatelessWidget {
  const TextDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ============================================================
          // 1. 基础用法
          // ============================================================
          _buildSectionTitle('1. 基础用法', '最简单的文本展示'),
          _buildBasicText(),

          const SizedBox(height: 24),

          // ============================================================
          // 2. 样式控制
          // ============================================================
          _buildSectionTitle('2. 样式控制 (TextStyle)', '字体、颜色、大小、粗细等'),
          _buildStyleExamples(),

          const SizedBox(height: 24),

          // ============================================================
          // 3. 文本对齐
          // ============================================================
          _buildSectionTitle('3. 文本对齐 (textAlign)', '左对齐、居中、右对齐、两端对齐'),
          _buildTextAlignExamples(),

          const SizedBox(height: 24),

          // ============================================================
          // 4. 溢出处理
          // ============================================================
          _buildSectionTitle('4. 溢出处理 (overflow)', 'ellipsis / clip / fade / visible'),
          _buildOverflowExamples(),

          const SizedBox(height: 24),

          // ============================================================
          // 5. 富文本 (Text.rich / TextSpan)
          // ============================================================
          _buildSectionTitle('5. 富文本 (Text.rich)', 'TextSpan 实现混合样式'),
          _buildRichTextExamples(),

          const SizedBox(height: 24),

          // ============================================================
          // 6. 带图标/Widget 的内联文本 (WidgetSpan)
          // ============================================================
          _buildSectionTitle('6. 内联组件 (WidgetSpan)', '文本中嵌入图标或其他 Widget'),
          _buildWidgetSpanExamples(),

          const SizedBox(height: 24),

          // ============================================================
          // 7. 可选择文本 (SelectableText)
          // ============================================================
          _buildSectionTitle('7. 可选择文本', '支持长按复制'),
          _buildSelectableTextExample(),

          const SizedBox(height: 24),

          // ============================================================
          // 8. 自定义字体
          // ============================================================
          _buildSectionTitle('8. 自定义字体', '使用本地字体文件'),
          _buildCustomFontExample(),

          const SizedBox(height: 24),

          // ============================================================
          // 9. 渐变文字 (ShaderMask)
          // ============================================================
          _buildSectionTitle('9. 渐变文字', '使用 ShaderMask 实现渐变效果'),
          _buildGradientTextExample(),

          const SizedBox(height: 24),

          // ============================================================
          // 10. 带阴影的文字
          // ============================================================
          _buildSectionTitle('10. 文字阴影', 'TextStyle.shadows 实现阴影效果'),
          _buildShadowTextExample(),

          const SizedBox(height: 24),

          // ============================================================
          // 11. 性能优化：const 和缓存
          // ============================================================
          _buildSectionTitle('11. 性能优化', 'const / 缓存 TextSpan / 缓存 TextPainter'),
          _buildPerformanceOptimization(),

          const SizedBox(height: 24),

          // ============================================================
          // 12. 常见坑解决方案
          // ============================================================
          _buildSectionTitle('12. 常见坑解决', 'TextOverflow.ellipsis 不生效 / 垂直居中'),
          _buildCommonPitfalls(),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // ============================================================
  // 1. 基础用法
  // ============================================================
  Widget _buildBasicText() {
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
          Text('最简单的文本展示'),
          SizedBox(height: 8),
          Text(
            '这是一段较长的文本，用于展示 Text 组件的基本用法。'
            'Text 是 Flutter 中最常用的文本展示组件。',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text.rich(
            TextSpan(
              text: '使用 Text.rich 可以展示富文本',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 2. 样式控制
  // ============================================================
  Widget _buildStyleExamples() {
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
          const Text(
            '不同字号',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          const Text('字号 12', style: TextStyle(fontSize: 12)),
          const Text('字号 16', style: TextStyle(fontSize: 16)),
          const Text('字号 24', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 12),

          const Text(
            '不同颜色',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          const Text('红色', style: TextStyle(fontSize: 16, color: Colors.red)),
          const Text('蓝色', style: TextStyle(fontSize: 16, color: Colors.blue)),
          const Text('绿色', style: TextStyle(fontSize: 16, color: Colors.green)),
          const SizedBox(height: 12),

          const Text(
            '不同粗细',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          const Text('Light', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
          const Text('Normal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
          const Text('Bold', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),

          const Text(
            '装饰效果',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          const Text(
            '下划线',
            style: TextStyle(
              fontSize: 16,
              decoration: TextDecoration.underline,
              decorationColor: Colors.blue,
            ),
          ),
          const Text(
            '删除线',
            style: TextStyle(
              fontSize: 16,
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.red,
            ),
          ),
          const Text(
            '上划线',
            style: TextStyle(
              fontSize: 16,
              decoration: TextDecoration.overline,
              decorationColor: Colors.green,
            ),
          ),
          const SizedBox(height: 12),

          const Text(
            '行高控制 (height)',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          const Text(
            '默认行高 (height: 1.0)\n第二行文本',
            style: TextStyle(fontSize: 16, height: 1.0),
          ),
          const SizedBox(height: 8),
          const Text(
            '较大行高 (height: 2.0)\n第二行文本',
            style: TextStyle(fontSize: 16, height: 2.0, color: Colors.blue),
          ),
          const SizedBox(height: 12),

          const Text(
            '字母间距 (letterSpacing)',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          const Text(
            '默认间距',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text(
            '大间距 (2.0)',
            style: TextStyle(fontSize: 16, letterSpacing: 2.0, color: Colors.blue),
          ),
          const SizedBox(height: 12),

          const Text(
            '字体样式 (fontStyle)',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          const Text(
            '正常样式',
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.normal),
          ),
          const SizedBox(height: 8),
          const Text(
            '斜体',
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 3. 文本对齐
  // ============================================================
  Widget _buildTextAlignExamples() {
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
          _buildTextAlignExample(
            'TextAlign.start (左对齐)',
            TextAlign.start,
          ),
          const SizedBox(height: 8),
          _buildTextAlignExample(
            'TextAlign.center (居中对齐)',
            TextAlign.center,
          ),
          const SizedBox(height: 8),
          _buildTextAlignExample(
            'TextAlign.end (右对齐)',
            TextAlign.end,
          ),
          const SizedBox(height: 8),
          _buildTextAlignExample(
            'TextAlign.justify (两端对齐)',
            TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildTextAlignExample(String label, TextAlign align) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            '这是一段用于演示文本对齐效果的示例文本。'
            '不同的对齐方式会影响文本在容器中的位置。',
            textAlign: align,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 4. 溢出处理
  // ============================================================
  Widget _buildOverflowExamples() {
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
          const Text(
            '⚠️ 注意：溢出控制需要外层容器有明确的宽度约束',
            style: TextStyle(fontSize: 12, color: Colors.orange),
          ),
          const SizedBox(height: 12),

          // overflow: visible（默认）
          Container(
            width: 200,
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: const Text(
              'visible - 文本溢出容器边界可见 (默认)',
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 8),

          // overflow: clip
          Container(
            width: 200,
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: const Text(
              'clip - 文本被裁剪，超出部分不可见',
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 8),

          // overflow: ellipsis（最常用）
          Container(
            width: 200,
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: const Text(
              'ellipsis - 超出部分显示省略号',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 8),

          // overflow: fade
          Container(
            width: 200,
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: const Text(
              'fade - 文本渐隐消失',
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 12),

          const Text(
            '多行限制 (maxLines)',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Container(
            width: 300,
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: const Text(
              '这是一段很长的文本，限制最大显示 2 行，超出部分显示省略号。'
              '通过 maxLines 和 overflow 可以精确控制文本的显示行数。',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 5. 富文本 (Text.rich / TextSpan)
  // ============================================================
  Widget _buildRichTextExamples() {
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
          const Text(
            '基础富文本',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 16),
              children: [
                TextSpan(
                  text: '红色 ',
                  style: TextStyle(color: Colors.red),
                ),
                TextSpan(
                  text: '绿色 ',
                  style: TextStyle(color: Colors.green),
                ),
                TextSpan(
                  text: '蓝色 ',
                  style: TextStyle(color: Colors.blue),
                ),
                TextSpan(
                  text: '加粗',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          const Text(
            '带装饰的富文本',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 16),
              children: [
                TextSpan(
                  text: '下划线',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                    decorationThickness: 2,
                  ),
                ),
                TextSpan(text: ' + '),
                TextSpan(
                  text: '删除线',
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.red,
                  ),
                ),
                TextSpan(text: ' + '),
                TextSpan(
                  text: '上划线',
                  style: TextStyle(
                    decoration: TextDecoration.overline,
                    decorationColor: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          const Text(
            '嵌套 TextSpan (样式继承)',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 16, color: Colors.blue),
              children: [
                TextSpan(text: '父级样式为蓝色 '),
                TextSpan(
                  text: '子级覆盖为红色 ',
                  style: TextStyle(color: Colors.red),
                ),
                TextSpan(
                  text: '子级继承父级',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 6. 带图标/Widget 的内联文本 (WidgetSpan)
  // ============================================================
  Widget _buildWidgetSpanExamples() {
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
          const Text(
            'WidgetSpan 基础用法',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              style: const TextStyle(fontSize: 16),
              children: [
                const TextSpan(text: '点击 '),
                WidgetSpan(
                  child: Icon(Icons.favorite, color: Colors.red, size: 20),
                ),
                const TextSpan(text: ' 收藏'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          const Text(
            'WidgetSpan + 自定义 Widget',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              style: const TextStyle(fontSize: 16),
              children: [
                const TextSpan(text: '评分 '),
                WidgetSpan(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text('4.8', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                const TextSpan(text: ' 高分推荐'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          const Text(
            '多 WidgetSpan 混排',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              style: const TextStyle(fontSize: 16),
              children: [
                const TextSpan(text: '状态 '),
                WidgetSpan(
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const TextSpan(text: ' 在线 '),
                WidgetSpan(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: const Text(
                      'VIP',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const TextSpan(text: ' 用户'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 7. 可选择文本 (SelectableText)
  // ============================================================
  Widget _buildSelectableTextExample() {
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
          const Text(
            'SelectableText - 支持长按复制',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SelectableText(
            '长按这段文字可以弹出复制菜单。\nSelectableText 支持多行文本选择。',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.start,
            showCursor: true,
            cursorColor: Colors.blue,
            toolbarOptions: const ToolbarOptions(
              copy: true,
              selectAll: true,
              paste: false,
              cut: false,
            ),
          ),
          const SizedBox(height: 12),

          const Text(
            'SelectableText.rich - 可选择富文本',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SelectableText.rich(
            TextSpan(
              style: const TextStyle(fontSize: 16),
              children: const [
                TextSpan(
                  text: '红色文本 ',
                  style: TextStyle(color: Colors.red),
                ),
                TextSpan(
                  text: '蓝色文本',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
            showCursor: true,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 8. 自定义字体
  // ============================================================
  Widget _buildCustomFontExample() {
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
          const Text(
            '⚠️ 使用前需在 pubspec.yaml 中声明字体文件',
            style: TextStyle(fontSize: 12, color: Colors.orange),
          ),
          const SizedBox(height: 8),
          const Text(
            '自定义字体示例',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Roboto', // 需要在 pubspec.yaml 中声明
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '如果字体未加载，会回退到默认字体',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'NotoSerif', // 需要在 pubspec.yaml 中声明
            ),
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey[200],
            child: const Text(
              'pubspec.yaml 配置示例:',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey[200],
            child: const Text(
              'fonts:\n'
              '  - family: Roboto\n'
              '    fonts:\n'
              '      - asset: fonts/Roboto-Regular.ttf\n'
              '      - asset: fonts/Roboto-Bold.ttf\n'
              '        weight: 700',
              style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 9. 渐变文字 (ShaderMask)
  // ============================================================
  Widget _buildGradientTextExample() {
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
          const Text(
            '线性渐变文字',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.blue, Colors.purple, Colors.pink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: const Text(
              'Gradient Text',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),

          const Text(
            '径向渐变文字',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ShaderMask(
            shaderCallback: (bounds) => const RadialGradient(
              colors: [Colors.amber, Colors.orange, Colors.red],
              center: Alignment.center,
            ).createShader(bounds),
            child: const Text(
              'Radial Text',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),

          const Text(
            '多色渐变文字',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: const Text(
              'Rainbow Text 🌈',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 10. 带阴影的文字
  // ============================================================
  Widget _buildShadowTextExample() {
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
          const Text(
            '简单文字阴影',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Shadow Text',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          const Text(
            '多重阴影 (3D 效果)',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            '3D Shadow',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black87,
                  offset: Offset(0, 4),
                  blurRadius: 8,
                ),
                Shadow(
                  color: Colors.black54,
                  offset: Offset(0, 8),
                  blurRadius: 16,
                ),
                Shadow(
                  color: Colors.black26,
                  offset: Offset(0, 12),
                  blurRadius: 24,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          const Text(
            '彩色阴影',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Color Shadow',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.red,
                  offset: Offset(-2, -2),
                  blurRadius: 8,
                ),
                Shadow(
                  color: Colors.blue,
                  offset: Offset(2, 2),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 11. 性能优化
  // ============================================================
  Widget _buildPerformanceOptimization() {
    // 缓存 TextSpan 对象
    const TextSpan _cachedTextSpan = TextSpan(
      children: [
        TextSpan(
          text: '性能优化 ',
          style: TextStyle(color: Colors.blue),
        ),
        TextSpan(
          text: '使用缓存 ',
          style: TextStyle(color: Colors.green),
        ),
        TextSpan(
          text: 'TextSpan',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ],
    );

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
          const Text(
            '✅ 1. 使用 const 构造函数',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 4),
          const Text(
            'const Text("固定文本") - Widget 被复用，跳过重建',
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 12),

          const Text(
            '✅ 2. 缓存 TextSpan 对象',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 4),
          Text.rich(_cachedTextSpan), // 复用缓存的 TextSpan
          const SizedBox(height: 12),

          const Text(
            '✅ 3. 缓存 TextStyle 对象',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 4),
          _buildCachedStyleTextExample(),
          const SizedBox(height: 12),

          const Text(
            '✅ 4. 使用 Text.rich 替代多个 Text',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 4),
          const Text(
            '❌ 3 个 Text = 3 个 RenderParagraph',
            style: TextStyle(fontSize: 12, color: Colors.red),
          ),
          Row(
            children: const [
              Text('A', style: TextStyle(color: Colors.red)),
              Text('B', style: TextStyle(color: Colors.green)),
              Text('C', style: TextStyle(color: Colors.blue)),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            '✅ 1 个 Text.rich = 1 个 RenderParagraph',
            style: TextStyle(fontSize: 12, color: Colors.green),
          ),
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'A',
                  style: TextStyle(color: Colors.red),
                ),
                TextSpan(
                  text: 'B',
                  style: TextStyle(color: Colors.green),
                ),
                TextSpan(
                  text: 'C',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          const Text(
            '✅ 5. 使用 RepaintBoundary 隔离重绘',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 4),
          RepaintBoundary(
            child: const Text(
              '这个 Text 在 RepaintBoundary 中，不会随父 Widget 重绘而重绘',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // 缓存 TextStyle 示例
  static const TextStyle _cachedStyle = TextStyle(
    fontSize: 16,
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );

  Widget _buildCachedStyleTextExample() {
    return const Text(
      '使用缓存的 TextStyle 对象',
      style: _cachedStyle,
    );
  }

  // ============================================================
  // 12. 常见坑解决方案
  // ============================================================
  Widget _buildCommonPitfalls() {
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
          // 坑 1: TextOverflow.ellipsis 不生效
          const Text(
            '❌ 坑 1: TextOverflow.ellipsis 不生效',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          const SizedBox(height: 4),
          const Text(
            '错误原因：Row 对非弹性子元素传递无限宽度约束，文本不换行',
            style: TextStyle(fontSize: 12, color: Colors.orange),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Row(
              children: [
                const Icon(Icons.star),
                Expanded(
                  child: const Text(
                    '✅ 使用 Expanded 限制宽度，ellipsis 生效了',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // 坑 2: Text 在 Container 中垂直不居中
          const Text(
            '❌ 坑 2: Text 在 Container 中垂直不居中',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          const SizedBox(height: 4),
          const Text(
            '解决方案：使用 alignment + 固定行高',
            style: TextStyle(fontSize: 12, color: Colors.orange),
          ),
          const SizedBox(height: 8),
          Container(
            height: 60,
            color: Colors.white,
            alignment: Alignment.center,
            child: const Text(
              '✅ 垂直居中 + 固定行高',
              style: TextStyle(fontSize: 16, height: 1.0),
            ),
          ),
          const SizedBox(height: 12),

          // 坑 3: Text.rich 样式继承问题
          const Text(
            '❌ 坑 3: Text.rich 子级样式覆盖父级',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          const SizedBox(height: 4),
          const Text(
            '解决方案：使用 merge 保留父级属性',
            style: TextStyle(fontSize: 12, color: Colors.orange),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Text.rich(
              TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.blue),
                children: [
                  const TextSpan(text: '父级样式 (蓝色) '),
                  TextSpan(
                    text: '✅ 子级覆盖颜色，保留字号',
                    style: const TextStyle(color: Colors.red).merge(
                      const TextStyle(fontSize: 16),
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
  // 辅助工具方法
  // ============================================================

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

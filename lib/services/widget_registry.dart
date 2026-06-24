import '../models/widget_info.dart';
import '../models/widget_category.dart';
import '../basic/containter.dart';
import '../basic/row.dart';
import '../basic/column.dart';
import '../basic/image.dart';
import '../basic/text.dart';
import '../basic/icon.dart';

/// Widget 注册中心
///
/// 集中管理所有 Widget 示例的注册信息，提供搜索和按分类查询功能。
class WidgetRegistry {
  WidgetRegistry._();

  static final List<WidgetInfo> _widgets = [
    // ========== 基础组件 ==========
    WidgetInfo(
      name: 'Container',
      nameCn: '容器',
      description: '组合类组件，支持颜色、内边距、外边距、装饰、对齐、约束、变换等',
      category: WidgetCategory.basic,
      docPath: 'docs/basic_layout/1.container.md',
      demoBuilder: () => const ContainerDemo(),
      tags: ['box', 'decoration', 'padding', 'margin', 'color'],
    ),
    WidgetInfo(
      name: 'Row',
      nameCn: '水平布局',
      description: '水平排列子组件，支持主轴/交叉轴对齐、弹性布局、基线对齐等',
      category: WidgetCategory.layout,
      docPath: 'docs/basic_layout/2.row.md',
      demoBuilder: () => const RowDemo(),
      tags: ['水平', '弹性', 'flex', 'align', '布局'],
    ),
    WidgetInfo(
      name: 'Column',
      nameCn: '垂直布局',
      description: '垂直排列子组件，支持主轴/交叉轴对齐、弹性布局、基线对齐等',
      category: WidgetCategory.layout,
      docPath: 'docs/basic_layout/3.column.md',
      demoBuilder: () => const ColumnDemo(),
      tags: ['水平', '弹性', 'flex', 'align', '布局'],
    ),
    WidgetInfo(
      name: 'Image',
      nameCn: '图片',
      description: '加载显示图片，支持网络/本地/资源/内存、圆角裁剪、颜色混合、加载状态',
      category: WidgetCategory.basic,
      docPath: 'docs/basic_layout/5.image.md',
      demoBuilder: () => const ImageDemo(),
      tags: ['网络', '本地', '圆角', '加载', '缓存', '图片'],
    ),
    WidgetInfo(
      name: 'Text',
      nameCn: '文本',
      description: '文本渲染组件，支持样式控制、溢出处理、富文本、自定义字体',
      category: WidgetCategory.basic,
      docPath: 'docs/basic_layout/4.text.md',
      demoBuilder: () => const TextDemo(),
      tags: ['文字', '样式', '溢出', '富文本', '字体'],
    ),
    WidgetInfo(
      name: 'Icon',
      nameCn: '图标',
      description: 'Material 图标组件，支持系统图标、自定义大小/颜色、IconButton、语义标签',
      category: WidgetCategory.basic,
      docPath: 'docs/basic_layout/6.icon.md',
      demoBuilder: () => const IconDemo(),
      tags: ['图标', 'icon', 'material', '按钮'],
    ),
    // TODO: 添加更多 Widget
  ];

  /// 获取所有注册的 Widget
  static List<WidgetInfo> get all => List.unmodifiable(_widgets);

  /// 按分类筛选
  static List<WidgetInfo> byCategory(WidgetCategory category) => _widgets.where((w) => w.category == category).toList();

  /// 搜索 Widget
  static List<WidgetInfo> search(String query) {
    if (query.trim().isEmpty) return all;
    return _widgets.where((w) => w.matches(query.trim())).toList();
  }

  /// 获取所有分类（仅包含有 Widget 的分类）
  static List<WidgetCategory> get usedCategories {
    final cats = _widgets.map((w) => w.category).toSet();
    return WidgetCategory.values.where((c) => cats.contains(c)).toList();
  }
}

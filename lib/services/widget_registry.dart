import '../models/widget_info.dart';
import '../models/widget_category.dart';
import '../basic/containter.dart';

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

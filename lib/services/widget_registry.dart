import '../basic/custom_scrollview.dart';
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
    // ========== 滚动组件 ==========
    WidgetInfo(
      name: 'CustomScrollView',
      nameCn: '自定义滚动视图',
      description: '使用 Sliver 机制构建复杂滚动布局，支持 SliverAppBar、SliverList、SliverGrid、SliverPersistentHeader 等多种 Sliver 组合',
      category: WidgetCategory.scrolling,
      docPath: 'docs/scrolling/custom_scroll_view.md',
      demoBuilder: () => const CustomScrollViewDemo(),
      tags: ['滚动', 'sliver', '列表', '网格', '折叠', '粘性头部', '性能优化'],
    ),
    WidgetInfo(
      name: 'CustomScrollViewWithController',
      nameCn: '带滚动控制的 CustomScrollView',
      description: '使用 ScrollController 控制滚动位置，实时监听滚动偏移，实现返回顶部按钮、滚动状态监听等功能',
      category: WidgetCategory.scrolling,
      docPath: 'docs/scrolling/custom_scroll_view_controller.md',
      demoBuilder: () => const CustomScrollViewWithController(),
      tags: ['滚动', '控制器', 'scroll', '监听', '回到顶部', 'scrollcontroller'],
    ),
    WidgetInfo(
      name: 'NestedScrollView',
      nameCn: '嵌套滚动视图',
      description: '处理嵌套滚动场景，支持 SliverAppBar 与 TabBarView 联动，实现顶部折叠 + 底部多标签切换的复杂页面',
      category: WidgetCategory.scrolling,
      docPath: 'docs/scrolling/nested_scroll_view.md',
      demoBuilder: () => const NestedScrollExample(),
      tags: ['嵌套滚动', 'tab', 'sliverappbar', 'tabbarview', '折叠'],
    ),
    WidgetInfo(
      name: 'CustomScrollViewPerformance',
      nameCn: 'CustomScrollView 性能优化',
      description: '展示 cacheExtent、SliverFixedExtentList、shrinkWrap 等性能优化参数的使用方法和效果',
      category: WidgetCategory.scrolling,
      docPath: 'docs/scrolling/custom_scroll_view_performance.md',
      demoBuilder: () => const CustomScrollViewPerformanceDemo(),
      tags: ['性能', '优化', 'cache', 'fixedextent', '缓存', '预加载'],
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

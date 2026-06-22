import 'package:flutter/material.dart';
import 'widget_category.dart';

/// Widget 信息模型
///
/// 描述一个 Widget 的元信息，包括所属分类、Demo 入口、文档路径等。
class WidgetInfo {
  final String name;
  final String nameCn;
  final String description;
  final WidgetCategory category;
  final String docPath;
  final Widget Function() demoBuilder;

  /// Widget 标签（用于搜索关键词匹配）
  final List<String> tags;

  /// 来源（Flutter SDK / 第三方包）
  final String source;

  const WidgetInfo({
    required this.name,
    required this.nameCn,
    required this.description,
    required this.category,
    required this.docPath,
    required this.demoBuilder,
    this.tags = const [],
    this.source = 'Flutter SDK',
  });

  /// 获取搜索关键词列表（合并 name + nameCn + description + tags）
  List<String> get searchTokens => [
    name.toLowerCase(),
    nameCn.toLowerCase(),
    ...description.toLowerCase().split(RegExp(r'[\s,，、]+')),
    ...tags.map((t) => t.toLowerCase()),
  ];

  /// 是否匹配搜索关键词
  bool matches(String query) {
    final q = query.toLowerCase();
    return searchTokens.any((t) => t.contains(q));
  }
}

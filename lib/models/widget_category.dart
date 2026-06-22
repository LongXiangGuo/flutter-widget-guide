import 'package:flutter/material.dart';

/// Widget 分类枚举
enum WidgetCategory {
  basic('基础组件', Icons.widgets_outlined, '基础 UI 组件，如 Container、Text、Image 等'),
  layout('布局组件', Icons.dashboard_outlined, '布局相关组件，如 Row、Column、Stack 等'),
  scrolling('滚动组件', Icons.view_list_outlined, '可滚动列表组件，如 ListView、GridView 等'),
  input('输入组件', Icons.input_outlined, '表单输入组件，如 TextField、Form 等'),
  animation('动画组件', Icons.animation_outlined, '动画与过渡组件'),
  material('Material', Icons.android_outlined, 'Material Design 风格组件');

  const WidgetCategory(this.label, this.icon, this.description);

  final String label;
  final IconData icon;
  final String description;
}

import 'package:flutter/material.dart';
import '../models/widget_info.dart';

/// Widget 详情页
///
/// 展示单个 Widget 的 Demo 示例，并提供文档和源码入口。
class WidgetDetailPage extends StatelessWidget {
  final WidgetInfo info;

  const WidgetDetailPage({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${info.name} · ${info.nameCn}'),
        actions: [
          /// 查看功能介绍 Markdown 文档
          IconButton(
            icon: const Icon(Icons.menu_book),
            tooltip: '功能介绍文档',
            onPressed: () {
              // TODO: 打开 docs/ 下对应 Markdown 文档页面
            },
          ),

          /// 查看源码实现
          IconButton(
            icon: const Icon(Icons.code),
            tooltip: '查看源码',
            onPressed: () {
              // TODO: 打开对应源码查看页面
            },
          ),
        ],
      ),
      body: info.demoBuilder(),
    );
  }
}

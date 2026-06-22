# widgets_guide 项目 AI 协作约定

## 项目定位

一个 Flutter Widget 组件学习库 App，覆盖所有 Flutter 常用 Widget 的使用案例、架构解析、源码分析。

## 项目结构

```
lib/
  main.dart                    # App 入口
  app.dart                     # MaterialApp 配置
  models/                      # 数据模型
    widget_category.dart       # 分类模型
    widget_info.dart           # Widget 信息模型
  pages/
    home_page.dart             # 首页 / 底部 Tab 导航
    category_page.dart         # 按分类浏览 Widget
    widget_detail_page.dart    # Widget 详情（demo + 文档）
    search_page.dart           # 搜索页面
  widgets/                     # 各 Widget 示例实现
    basic/                     # 基础组件 Container、Text、Image...
    layout/                    # 布局组件 Row、Column、Stack...
    scrolling/                 # 滚动组件 ListView、GridView...
    input/                     # 输入组件 TextField、Form...
    animation/                 # 动画组件
    material/                  # Material 组件
  services/
    widget_registry.dart       # Widget 注册与搜索索引
docs/
  basic_layout/                # Container 等组件的 Markdown 文档
```

## 代码规范

### 文件命名

- Dart 文件：小写下划线 `widget_detail_page.dart`
- 类名：大驼峰 `WidgetDetailPage`
- 文档文件：`{顺序号}.{名称}.md` 如 `1.container.md`

### Widget 示例编写规范

每个 Widget 示例类必须：
1. 写清楚 `///` 文档注释说明用途
2. 按功能拆分多个子示例类（如 `BasicColorExample`、`PaddingExample`）
3. 示例类名以 Widget 名 + 功能命名
4. 使用 `const` 构造函数

### 文档编写规范

`docs/` 下的 Markdown 文档按 8 个视角组织：
1. 架构设计
2. 类关系图（Mermaid）
3. 流程图（Mermaid）
4. 源码解析
5. 使用场景
6. 优缺点
7. 常见坑
8. 性能优化

### 新增 Widget 的流程

1. 在对应目录下创建示例 dart 文件
2. 在 `widget_registry.dart` 注册
3. 在 `docs/` 下创建对应文档
4. 在主页面导航中添加入口

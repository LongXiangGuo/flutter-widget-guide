# Flutter Widgets 指南

一个 Flutter Widget 组件学习库 App，覆盖所有 Flutter 常用 Widget 的使用案例、架构解析、源码分析。

## 功能

| 功能            | 说明                                                                                               |
| --------------- | -------------------------------------------------------------------------------------------------- |
| 📱 **分类浏览**  | 底部 Tab 按分类（基础组件、布局组件、滚动组件等）浏览 Widget                                       |
| 🔍 **搜索**      | 按名称、中文名、描述、标签快速搜索 Widget                                                          |
| 🧪 **交互 Demo** | 每个 Widget 提供 10+ 个可交互的使用案例                                                            |
| 📖 **深度文档**  | Markdown 文档按 8 个视角：架构设计、类关系图、流程图、源码解析、使用场景、优缺点、常见坑、性能优化 |
| 🤖 **AI 辅助**   | `.github/` 下配置 Copilot instructions 和 skills，AI 自动按规范生成代码和文档                      |

## 已覆盖的 Widget

| Widget    | 分类     | Demo 案例数 | 文档             |
| --------- | -------- | ----------- | ---------------- |
| Container | 基础组件 | 14          | `1.container.md` |
| Row       | 布局组件 | 11          | `2.row.md`       |
| Column    | 布局组件 | —           | `3.column.md`    |
| Text      | 基础组件 | —           | `4.text.md`      |
| Image     | 基础组件 | 14          | `5.image.md`     |
| Icon      | 基础组件 | —           | `6.icon.md`      |

## 项目结构

```
widgets_guide/
├── lib/
│   ├── main.dart                    # App 入口
│   ├── app.dart                     # MaterialApp 配置 + 主题
│   ├── models/
│   │   ├── widget_category.dart     # 分类枚举（基础/布局/滚动/输入/动画/Material）
│   │   └── widget_info.dart         # Widget 信息模型（含搜索匹配）
│   ├── services/
│   │   └── widget_registry.dart     # 注册中心：集中管理搜索 + 分类查询
│   ├── pages/
│   │   ├── home_page.dart           # 首页：Tab 导航 + SearchDelegate
│   │   ├── widget_detail_page.dart  # 详情页：Demo + 文档/源码入口
│   │   └── search_page.dart         # 搜索页（路由占位）
│   ├── basic/                       # 基础组件示例
│   │   ├── containter.dart
│   │   ├── row.dart
│   │   ├── column.dart
│   │   ├── text.dart
│   │   ├── image.dart
│   │   └── icon.dart
│   └── layout/                      # 布局组件示例（待充实）
├── docs/
│   └── basic_layout/                # Widget 深度解析文档
│       ├── 1.container.md
│       ├── 2.row.md
│       ├── 3.column.md
│       ├── 4.text.md
│       ├── 5.image.md
│       └── 6.icon.md
├── .github/
│   ├── copilot-instructions.md      # AI 协作约定（始终生效）
│   ├── issues/                      # 问题记录
│   └── skills/
│       ├── flutter-widget-doc/      # 技能：按 8 视角深度讲解 Widget
│       └── flutter-widget-demo/     # 技能：自动生成 Widget 使用案例
└── TODO_LIST.md                     # 待办列表
```

## 新增 Widget 流程

1. 在 `lib/basic/` 或 `lib/layout/` 下创建 Demo dart 文件
2. 在 `lib/services/widget_registry.dart` 注册
3. 在 `docs/basic_layout/` 下创建文档
4. 自动出现在首页 Tab 和搜索结果中

## 运行

```bash
flutter pub get
flutter run
```


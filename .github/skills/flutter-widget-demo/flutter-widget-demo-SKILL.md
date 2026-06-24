---
name: flutter-widget-demo
description: "Use when user asks to generate/create/write a Flutter widget demo/example, or says '实现 demo', '生成使用案例', '案例大全', '写一个示例', 'create widget demo', 'generate example', 'add examples'. Also triggers for phrases like '[Widget名] 示例', '[Widget名] demo', and any request to add comprehensive usage examples for a Flutter widget."
---

## Flutter Widget Demo Generator

### 触发条件
当用户输入包含以下关键词时自动激活：
- "实现 [Widget名] 的 demo"
- "生成 [Widget名] 使用案例"
- "[Widget名] 案例大全"
- "写一个 [Widget名] 的示例"

### Skill 执行规则

#### 1. 代码结构模板
```dart
import 'package:flutter/material.dart';

/// [Widget名] 使用案例大全
///
/// 展示 [Widget名] 的各种属性组合用法，包括：
/// - [列出该Widget的主要属性，每行一个]
class [Widget名]Demo extends StatelessWidget {
  const [Widget名]Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 每个属性作为一个独立的示例区块
          SectionTitle('[序号]. [属性名]'),
          SizedBox(height: 8),
          [属性示例Widget](),
          SizedBox(height: 24),
          // ... 重复以上结构
        ],
      ),
    );
  }
}
```

#### 2. 必须包含的辅助组件
- **`SectionTitle`**：章节标题组件（固定样式）
- **`ExampleWrapper`**：示例外包装（带灰色背景和边框）
- **`_DemoBox` / `_示例组件`**：具体的示例实现（私有组件）

#### 3. 命名规范
- 主类：`[Widget名]Demo`
- 示例类：`[属性名]Example`（如 `BasicExample`、`StyleExample`）
- 私有组件：以下划线开头（如 `_ColorLabel`、`_DemoBox`）

#### 4. 内容组织原则
- **每个属性独立成节**：使用 `SectionTitle` 分隔
- **每个示例包含**：标题 + 示例代码 + 简短说明
- **示例应直观**：使用颜色、边框等视觉元素展示效果
- **每个示例高度控制在 80-200px**，使用 `ExampleWrapper` 包裹

#### 5. 常见 Widget 的属性清单（供参考）

| Widget             | 主要属性                                                                                                    |
| ------------------ | ----------------------------------------------------------------------------------------------------------- |
| **Text**           | style(fontSize, color, fontWeight), textAlign, overflow, maxLines, textDirection, softWrap, textScaleFactor |
| **Container**      | color, width, height, padding, margin, decoration, alignment, constraints, transform, clipBehavior          |
| **Row/Column**     | mainAxisAlignment, crossAxisAlignment, mainAxisSize, children, textDirection, verticalDirection             |
| **Image**          | image, width, height, fit, alignment, repeat, color, colorBlendMode, filterQuality                          |
| **Icon**           | icon, size, color, semanticLabel, textDirection                                                             |
| **ElevatedButton** | onPressed, style, child, focusElevation, hoverElevation, disabledElevation                                  |
| **TextField**      | controller, focusNode, decoration, keyboardType, obscureText, maxLines, onChanged, validator                |
| **ListView**       | children, scrollDirection, padding, reverse, shrinkWrap, physics                                            |
| **GridView**       | gridDelegate, children, scrollDirection, padding, shrinkWrap                                                |
| **AppBar**         | title, leading, actions, backgroundColor, elevation, centerTitle, flexibleSpace                             |

---

### 使用示例

**用户输入：**
> "实现 Text 的 demo"

**自动生成：**
完整的 Text 使用案例代码，包含：
1. 基础文本
2. 字体大小、颜色、粗细
3. 文本对齐
4. 文本溢出处理（ellipsis, fade, clip）
5. 装饰线（下划线、删除线、波浪线）
6. 字体家族（自定义字体）
7. 行高与字间距（height, letterSpacing）
8. 富文本（TextSpan）
9. 文本选择（SelectableText）
10. 综合案例

---

### 执行流程

1. **识别 Widget 名称**：从用户输入中提取目标 Widget
2. **确定属性列表**：根据 Widget 类型生成对应的属性清单
3. **生成示例代码**：按模板生成完整的 Dart 代码
4. **添加注释说明**：每个示例添加中文注释说明用法
5. **输出完整代码**：提供可直接复制运行的完整文件

---

### 附加功能

- 如果用户说 **"简洁版"**：只生成 5-6 个核心属性示例
- 如果用户说 **"完整版"**：生成所有属性示例（默认）
- 如果用户说 **"带交互"**：添加 StatefulWidget 示例

---

## 现在就试试！

**你可以直接输入：**
- "实现 Text 的 demo"
- "生成 Container 使用案例"
- "写一个 Image 的示例"
- "实现 ListView 的 demo，带交互"

我会自动按照这个 Skill 的模板为你生成完整的代码！🚀
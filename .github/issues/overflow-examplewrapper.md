# 6.0 pixels overflow — ExampleWrapper 子内容溢出

## 问题

`containter.dart` 中 `ExampleWrapper` 的 `Row` 子项宽超出可用宽度，运行时控制台报 `6.0 pixels overflow`。

## 根因

`ExampleWrapper` 自身占用了 18px 宽度（border 左右各 1px + padding 左右各 8px），导致内部可用宽度不足以容纳 Row 中的所有固定宽度子项（如 3×100px = 300px），在窄屏上产生溢出。

## 修复

`ExampleWrapper.build()` 中 Container 添加 `clipBehavior: Clip.hardEdge`，超出部分硬裁剪。

## 文件

`lib/basic/containter.dart` → `ExampleWrapper`

## 日期

2026-06-23

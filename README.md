# widget guide


# TODO

MaskFilter
BlenMode
Shader
Shadow
BlendMode
Assets管理与加载
图片的编码格式优缺点选择

```mermaid
classDiagram
    class Widget {
        <<abstract>>
    }
    class StatelessWidget {
        <<abstract>>
    }
    class ButtonStyleButton {
        <<abstract>>
        +ButtonStyle style
        +void onPressed()
        +Widget child
    }
    class TextButton {
        +TextButton({Key key, VoidCallback onPressed, Widget child, ButtonStyle style})
    }
    class ElevatedButton {
        +ElevatedButton({Key key, VoidCallback onPressed, Widget child, ButtonStyle style})
    }
    class OutlinedButton {
        +OutlinedButton({Key key, VoidCallback onPressed, Widget child, ButtonStyle style})
    }
    class ButtonStyle {
        +MaterialStateProperty~TextStyle~ textStyle
        +MaterialStateProperty~Color~ backgroundColor
        +MaterialStateProperty~Color~ foregroundColor
        +MaterialStateProperty~Color~ overlayColor
        +MaterialStateProperty~double~ elevation
        +MaterialStateProperty~EdgeInsetsGeometry~ padding
        +MaterialStateProperty~Size~ minimumSize
        +MaterialStateProperty~BorderSide~ side
        +MaterialStateProperty~OutlinedBorder~ shape
    }
    class MaterialStateProperty~T~ {
        <<interface>>
        +T resolve(Set~MaterialState~ states)
    }
    class TextButtonTheme {
        +TextButtonThemeData style
    }
    class ElevatedButtonTheme {
        +ElevatedButtonThemeData style
    }
    class OutlinedButtonTheme {
        +OutlinedButtonThemeData style
    }

    Widget <|-- StatelessWidget
    StatelessWidget <|-- ButtonStyleButton
    ButtonStyleButton <|-- TextButton
    ButtonStyleButton <|-- ElevatedButton
    ButtonStyleButton <|-- OutlinedButton
    ButtonStyleButton --> ButtonStyle : 使用
    ButtonStyle --> MaterialStateProperty : 包含
    TextButtonTheme --> TextButton : 主题传递
    ElevatedButtonTheme --> ElevatedButton : 主题传递
    OutlinedButtonTheme --> OutlinedButton : 主题传递 
```
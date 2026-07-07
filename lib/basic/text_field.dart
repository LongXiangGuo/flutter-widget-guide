import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============ 主页面 ============
class TextFieldDemo extends StatefulWidget {
  const TextFieldDemo({super.key});

  @override
  State<TextFieldDemo> createState() => _TextFieldDemoState();
}

class _TextFieldDemoState extends State<TextFieldDemo> with SingleTickerProviderStateMixin {
  // ============ 控制器和焦点管理 ============
  // ✅ 正确：在 State 中作为成员变量创建，并在 dispose 中释放
  late final TextEditingController _nameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _searchController;
  late final TextEditingController _commentController;
  late final TextEditingController _phoneController;
  late final FocusNode _nameFocusNode;
  late final FocusNode _passwordFocusNode;

  // 状态变量
  bool _obscurePassword = true;
  String _searchResult = '';
  String _submittedComment = '';
  final List<String> _searchHistory = [];

  // ============ 动画控制器（用于演示输入框动画） ============
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // 初始化控制器
    RestorableProperty;
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
    _searchController = TextEditingController();
    _commentController = TextEditingController();
    _phoneController = TextEditingController();

    // 初始化焦点节点
    _nameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    // 初始化动画
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // 添加监听器（演示用）
    _nameController.addListener(() {
      // 监听姓名输入变化，可用于实时验证
      debugPrint('姓名输入变化: ${_nameController.text}');
    });
  }

  @override
  void dispose() {
    // ✅ 正确：释放所有控制器和焦点节点，防止内存泄漏
    _nameController.dispose();
    _passwordController.dispose();
    _searchController.dispose();
    _commentController.dispose();
    _phoneController.dispose();
    _nameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // ============ 辅助方法 ============
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _submitForm() {
    final name = _nameController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty) {
      _showSnackBar('请输入姓名');
      _nameFocusNode.requestFocus();
      return;
    }

    if (password.isEmpty || password.length < 6) {
      _showSnackBar('密码至少6位');
      _passwordFocusNode.requestFocus();
      return;
    }

    _showSnackBar('✅ 提交成功！姓名: $name');
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) return;

    setState(() {
      _searchResult = query;
      if (!_searchHistory.contains(query)) {
        _searchHistory.insert(0, query);
        if (_searchHistory.length > 5) {
          _searchHistory.removeLast();
        }
      }
    });
    _showSnackBar('🔍 搜索: $query');
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchResult = '';
    });
    _showSnackBar('已清除搜索');
  }

  void _submitComment(String comment) {
    setState(() {
      _submittedComment = comment;
    });
    RestorationBucket;
    RestorationBucket;
    RestorableInt;
    _showSnackBar('✅ 评论已提交: $comment');
  }

  // ============ 构建 UI ============
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextField 完整演示'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _nameController.clear();
                _passwordController.clear();
                _searchController.clear();
                _commentController.clear();
                _phoneController.clear();
                _searchResult = '';
                _submittedComment = '';
              });
              _showSnackBar('🔄 已重置所有输入');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==========================================
              // 1. 基础输入框 - 姓名
              // ==========================================
              _buildSectionTitle('1. 基础输入', Icons.person),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        focusNode: _nameFocusNode,
                        decoration: InputDecoration(
                          labelText: '姓名',
                          hintText: '请输入您的姓名',
                          prefixIcon: const Icon(Icons.person_outline),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear, size: 20),
                            onPressed: () {
                              _nameController.clear();
                              _showSnackBar('已清空姓名');
                            },
                            tooltip: '清空',
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onSubmitted: (_) {
                          // 提交后自动聚焦到密码框
                          FocusScope.of(context).requestFocus(_passwordFocusNode);
                        },
                        onChanged: (value) {
                          // 实时输入检测（可用于验证）
                          if (value.isNotEmpty && value.length < 2) {
                            // 可以在这里做实时验证提示
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '当前输入: ${_nameController.text.isNotEmpty ? _nameController.text : '(空)'}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ==========================================
              // 2. 密码输入框（带可见性切换）
              // ==========================================
              _buildSectionTitle('2. 密码输入 (可见性切换)', Icons.lock),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: '密码',
                          hintText: '至少6位',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            tooltip: _obscurePassword ? '显示密码' : '隐藏密码',
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          errorText: _passwordController.text.isNotEmpty && _passwordController.text.length < 6
                              ? '密码至少6位'
                              : null,
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        onSubmitted: (_) => _submitForm(),
                        inputFormatters: [
                          // 限制输入长度
                          LengthLimitingTextInputFormatter(20),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '密码强度: ${_getPasswordStrength(_passwordController.text)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: _getPasswordColor(_passwordController.text),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ==========================================
              // 3. 搜索框（带提交和历史记录）
              // ==========================================
              _buildSectionTitle('3. 搜索框 (onSubmitted)', Icons.search),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: '搜索...',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_searchController.text.isNotEmpty)
                                IconButton(
                                  icon: const Icon(Icons.clear, size: 20),
                                  onPressed: _clearSearch,
                                  tooltip: '清空',
                                ),
                              IconButton(
                                icon: const Icon(Icons.history),
                                onPressed: () {
                                  if (_searchHistory.isEmpty) {
                                    _showSnackBar('暂无搜索历史');
                                  } else {
                                    _showSearchHistoryDialog();
                                  }
                                },
                                tooltip: '搜索历史',
                              ),
                            ],
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        textInputAction: TextInputAction.search,
                        keyboardType: TextInputType.text,
                        onSubmitted: _performSearch,
                        onChanged: (value) {
                          // 实时搜索（可以做防抖处理）
                          if (value.isNotEmpty && value.length >= 2) {
                            // 这里可以触发实时搜索建议
                          }
                        },
                      ),
                      if (_searchResult.isNotEmpty) ...[
                        const Divider(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.search, size: 16, color: Colors.blue),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '最近搜索: "$_searchResult"',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (_searchHistory.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: _searchHistory.map((item) {
                            return Chip(
                              label: Text(item),
                              onDeleted: () {
                                setState(() {
                                  _searchHistory.remove(item);
                                });
                              },
                              backgroundColor: Colors.grey.shade200,
                              deleteIconColor: Colors.grey.shade600,
                              visualDensity: VisualDensity.compact,
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ==========================================
              // 4. 多行评论输入框
              // ==========================================
              _buildSectionTitle('4. 多行评论 (maxLines: null)', Icons.comment),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _commentController,
                        maxLines: null, // ✅ 允许多行无限换行
                        minLines: 3,
                        maxLength: 200,
                        decoration: InputDecoration(
                          labelText: '评论内容',
                          hintText: '请输入您的评论...\n支持多行输入',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          counterStyle: TextStyle(color: Colors.grey.shade600),
                        ),
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        onChanged: (value) {
                          setState(() {});
                        },
                        onSubmitted: (value) {
                          if (value.trim().isNotEmpty) {
                            _submitComment(value);
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_commentController.text.length}/200 字符',
                            style: TextStyle(
                              fontSize: 12,
                              color: _commentController.text.length > 180 ? Colors.orange : Colors.grey.shade600,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _commentController.text.trim().isEmpty
                                ? null
                                : () => _submitComment(_commentController.text),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('提交评论'),
                          ),
                        ],
                      ),
                      if (_submittedComment.isNotEmpty) ...[
                        const Divider(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green.shade200),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle, color: Colors.green, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '已提交: $_submittedComment',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ==========================================
              // 5. 格式化输入（手机号）
              // ==========================================
              _buildSectionTitle('5. 格式化输入 (inputFormatters)', Icons.phone),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: '手机号码',
                          hintText: '请输入11位手机号',
                          prefixIcon: const Icon(Icons.phone_android),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          helperText: '仅支持数字，自动添加分隔符',
                          helperStyle: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                        ),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          // ✅ 组合多个格式化器
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11),
                          _PhoneNumberFormatter(),
                        ],
                        onChanged: (value) {
                          // 可以添加实时验证
                          if (value.replaceAll('-', '').length == 11) {
                            // 手机号完整，可以触发验证
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _phoneController.text.isEmpty ? '未输入' : '格式化后: ${_phoneController.text}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ==========================================
              // 6. 提交按钮
              // ==========================================
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: _submitForm,
                        icon: const Icon(Icons.send),
                        label: const Text(
                          '提交表单',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        onHover: (isHovered) {
                          if (isHovered) {
                            _animationController.forward();
                          } else {
                            _animationController.reverse();
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  '悬停或点击按钮查看动画效果',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ==========================================
              // 底部统计信息
              // ==========================================
              _buildStatsCard(),
            ],
          ),
        ),
      ),
    );
  }

  // ============ UI 辅助构建方法 ============
  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).primaryColor),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const Spacer(),
          Container(
            height: 2,
            width: 40,
            color: Theme.of(context).primaryColor.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Card(
      color: Colors.grey.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📊 输入统计',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 4,
              children: [
                _buildStatItem(
                  '姓名',
                  _nameController.text.isNotEmpty ? _nameController.text : '(空)',
                ),
                _buildStatItem(
                  '密码',
                  _passwordController.text.isNotEmpty ? '******' : '(空)',
                ),
                _buildStatItem(
                  '评论',
                  '${_commentController.text.length} 字符',
                ),
                _buildStatItem(
                  '手机号',
                  _phoneController.text.isNotEmpty ? _phoneController.text : '(空)',
                ),
                _buildStatItem(
                  '搜索历史',
                  '${_searchHistory.length} 条',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(
        '$label: $value',
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }

  // ============ 辅助方法 ============
  String _getPasswordStrength(String password) {
    if (password.isEmpty) return '未设置';
    if (password.length < 4) return '弱';
    if (password.length < 8) return '中等';
    return '强';
  }

  Color _getPasswordColor(String password) {
    if (password.isEmpty) return Colors.grey;
    if (password.length < 4) return Colors.red;
    if (password.length < 8) return Colors.orange;
    return Colors.green;
  }

  void _showSearchHistoryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('搜索历史'),
        content: SizedBox(
          width: double.maxFinite,
          height: 200,
          child: _searchHistory.isEmpty
              ? const Center(child: Text('暂无搜索历史'))
              : ListView.builder(
                  itemCount: _searchHistory.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.history, size: 16),
                      title: Text(_searchHistory[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, size: 16),
                        onPressed: () {
                          setState(() {
                            _searchHistory.removeAt(index);
                          });
                        },
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        _searchController.text = _searchHistory[index];
                        _performSearch(_searchHistory[index]);
                      },
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _searchHistory.clear();
              });
              Navigator.pop(context);
              _showSnackBar('已清空搜索历史');
            },
            child: const Text('清空', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }
}

// ============ 自定义 PhoneNumberFormatter ============
/// 手机号格式化器：将 11 位数字格式化为 3-4-4 格式
/// 例如：13812345678 -> 138-1234-5678
class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 只处理数字
    final text = newValue.text.replaceAll('-', '');
    if (text.isEmpty) return newValue;

    // 构建格式化后的文本
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 3 || i == 7) {
        buffer.write('-');
      }
      buffer.write(text[i]);
    }

    final formattedText = buffer.toString();

    // 计算光标位置
    int cursorPosition = newValue.selection.baseOffset;
    // 考虑添加的 '-' 对光标位置的影响
    int dashCount = 0;
    for (int i = 0; i < cursorPosition; i++) {
      if (i == 3 || i == 7) {
        dashCount++;
      }
    }
    cursorPosition += dashCount;

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: cursorPosition.clamp(
          0,
          formattedText.length,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// ============================================================
/// Icon 完整用法示例
/// 涵盖：基础用法、主题继承、IconButton、自定义大小/颜色、
/// 阴影、语义标签、系统图标分类展示（带索引）
/// ============================================================

class IconDemo extends StatelessWidget {
  const IconDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        body: Column(
          children: [
            // 分类 TabBar
            Container(
              color: Colors.blue,
              child: const TabBar(
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorColor: Colors.white,
                tabs: [
                  Tab(text: '全部'),
                  Tab(text: '导航'),
                  Tab(text: '操作'),
                  Tab(text: '媒体'),
                  Tab(text: '社交'),
                  Tab(text: '设备'),
                  Tab(text: '文件'),
                  Tab(text: '表情'),
                  Tab(text: '其他'),
                ],
              ),
            ),
            // 内容区域
            Expanded(
              child: TabBarView(
                children: [
                  _buildIconGrid(IconsCategory.all),
                  _buildIconGrid(IconsCategory.navigation),
                  _buildIconGrid(IconsCategory.action),
                  _buildIconGrid(IconsCategory.media),
                  _buildIconGrid(IconsCategory.social),
                  _buildIconGrid(IconsCategory.device),
                  _buildIconGrid(IconsCategory.file),
                  _buildIconGrid(IconsCategory.emoji),
                  _buildIconGrid(IconsCategory.other),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // 图标网格 + 索引列表
  // ============================================================
  Widget _buildIconGrid(List<IconInfo> icons) {
    if (icons.isEmpty) {
      return const Center(child: Text('该分类暂无图标'));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // 计算每行显示数量
        int crossAxisCount = 4;
        if (constraints.maxWidth > 600) crossAxisCount = 6;
        if (constraints.maxWidth > 900) crossAxisCount = 8;

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.0,
          ),
          itemCount: icons.length,
          itemBuilder: (context, index) {
            final info = icons[index];
            return _buildIconCard(info);
          },
        );
      },
    );
  }

  // ============================================================
  // 单个图标卡片
  // ============================================================
  Widget _buildIconCard(IconInfo info) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            info.iconData,
            size: 32,
            color: Colors.blue[700],
          ),
          const SizedBox(height: 4),
          Text(
            info.name,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 使用场景示例（独立展示，不包含在网格中）
  // ============================================================
  Widget _buildUseCases() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ============================================================
          // 1. 基础用法
          // ============================================================
          _buildSectionTitle('1. 基础用法', '最简单的图标展示'),
          _buildBasicUsage(),

          const SizedBox(height: 24),

          // ============================================================
          // 2. 主题继承
          // ============================================================
          _buildSectionTitle('2. 主题继承', 'IconTheme 统一配置'),
          _buildIconThemeExample(),

          const SizedBox(height: 24),

          // ============================================================
          // 3. IconButton 使用
          // ============================================================
          _buildSectionTitle('3. IconButton', '可点击图标 + 水波纹效果'),
          _buildIconButtonExample(),

          const SizedBox(height: 24),

          // ============================================================
          // 4. 大小与颜色
          // ============================================================
          _buildSectionTitle('4. 大小与颜色', '自定义尺寸和颜色'),
          _buildSizeColorExample(),

          const SizedBox(height: 24),

          // ============================================================
          // 5. 带阴影的图标
          // ============================================================
          _buildSectionTitle('5. 图标阴影', 'shadows 实现发光/立体效果'),
          _buildShadowExample(),

          const SizedBox(height: 24),

          // ============================================================
          // 6. 语义标签（无障碍）
          // ============================================================
          _buildSectionTitle('6. 语义标签', 'semanticLabel 支持屏幕阅读器'),
          _buildSemanticLabelExample(),

          const SizedBox(height: 24),

          // ============================================================
          // 7. 在文本中嵌入图标
          // ============================================================
          _buildSectionTitle('7. 文本混排', 'TextSpan 中嵌入图标'),
          _buildInlineIconExample(),

          const SizedBox(height: 24),

          // ============================================================
          // 8. 系统图标分类展示（9宫格 + 索引）
          // ============================================================
          _buildSectionTitle('8. 系统图标大全', '按分类展示所有 Material Icons'),
          const SizedBox(height: 12),
          const Text(
            '⚠️ 注意：此部分包含大量图标，请切换到上方 Tab 查看分类',
            style: TextStyle(fontSize: 12, color: Colors.orange),
          ),
          const SizedBox(height: 12),
          Container(
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _buildIconGrid(IconsCategory.all),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 1. 基础用法
  // ============================================================
  Widget _buildBasicUsage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Icon(Icons.favorite, color: Colors.red, size: 40),
          Icon(Icons.star, color: Colors.amber, size: 40),
          Icon(Icons.home, color: Colors.blue, size: 40),
          Icon(Icons.settings, color: Colors.grey, size: 40),
          Icon(Icons.person, color: Colors.green, size: 40),
        ],
      ),
    );
  }

  // ============================================================
  // 2. 主题继承
  // ============================================================
  Widget _buildIconThemeExample() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconTheme(
        data: const IconThemeData(
          size: 36,
          color: Colors.teal,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Icon(Icons.home),
            Icon(Icons.search),
            Icon(Icons.person),
            Icon(Icons.settings),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // 3. IconButton
  // ============================================================
  Widget _buildIconButtonExample() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () {},
            tooltip: '点赞',
            iconSize: 30,
          ),
          IconButton(
            icon: const Icon(Icons.star, color: Colors.amber),
            onPressed: () {},
            tooltip: '收藏',
            iconSize: 30,
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.blue),
            onPressed: () {},
            tooltip: '分享',
            iconSize: 30,
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onPressed: () {},
            tooltip: '更多',
            iconSize: 30,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 4. 大小与颜色
  // ============================================================
  Widget _buildSizeColorExample() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            '不同尺寸',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(Icons.star, size: 16, color: Colors.amber),
              Icon(Icons.star, size: 24, color: Colors.amber),
              Icon(Icons.star, size: 32, color: Colors.amber),
              Icon(Icons.star, size: 48, color: Colors.amber),
              Icon(Icons.star, size: 64, color: Colors.amber),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            '不同颜色',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(Icons.favorite, color: Colors.red),
              Icon(Icons.favorite, color: Colors.pink),
              Icon(Icons.favorite, color: Colors.purple),
              Icon(Icons.favorite, color: Colors.blue),
              Icon(Icons.favorite, color: Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 5. 阴影
  // ============================================================
  Widget _buildShadowExample() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.bolt,
            size: 48,
            color: Colors.amber,
            shadows: [
              Shadow(
                offset: const Offset(2, 2),
                blurRadius: 8,
                color: Colors.amber.withOpacity(0.5),
              ),
            ],
          ),
          Icon(
            Icons.location_on,
            size: 48,
            color: Colors.red,
            shadows: [
              Shadow(
                offset: const Offset(0, 0),
                blurRadius: 12,
                color: Colors.red.withOpacity(0.4),
              ),
            ],
          ),
          Icon(
            Icons.photo_camera,
            size: 48,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: const Offset(0, 2),
                blurRadius: 8,
                color: Colors.black38,
              ),
              Shadow(
                offset: const Offset(0, 4),
                blurRadius: 16,
                color: Colors.black26,
              ),
            ],
          ),
          Icon(
            Icons.star,
            size: 48,
            color: Colors.amber,
            shadows: [
              Shadow(
                offset: const Offset(0, 0),
                blurRadius: 16,
                color: Colors.amber,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 6. 语义标签
  // ============================================================
  Widget _buildSemanticLabelExample() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.home,
            semanticLabel: '主页',
            size: 40,
          ),
          Icon(
            Icons.search,
            semanticLabel: '搜索',
            size: 40,
          ),
          Icon(
            Icons.notifications,
            semanticLabel: '通知',
            size: 40,
          ),
          Icon(
            Icons.person,
            semanticLabel: '个人中心',
            size: 40,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 7. 文本混排
  // ============================================================
  Widget _buildInlineIconExample() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 16),
              children: [
                TextSpan(text: '点击 '),
                WidgetSpan(
                  child: Icon(Icons.favorite, color: Colors.red, size: 20),
                ),
                TextSpan(text: ' 收藏'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text.rich(
            TextSpan(
              style: const TextStyle(fontSize: 16),
              children: [
                const TextSpan(text: '评价 '),
                WidgetSpan(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star_border, color: Colors.amber, size: 18),
                    ],
                  ),
                ),
                const TextSpan(text: ' 4.5分'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text.rich(
            TextSpan(
              style: const TextStyle(fontSize: 16),
              children: [
                const TextSpan(text: '状态 '),
                WidgetSpan(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 14),
                        SizedBox(width: 4),
                        Text('在线', style: TextStyle(fontSize: 12, color: Colors.green)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 辅助工具方法
  // ============================================================

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        const Divider(height: 1),
        const SizedBox(height: 12),
      ],
    );
  }
}

// ============================================================
// 图标数据模型
// ============================================================
class IconInfo {
  final IconData iconData;
  final String name;
  final String category;

  const IconInfo(this.iconData, this.name, this.category);
}

// ============================================================
// 图标分类数据（精选常用图标）
// ============================================================
class IconsCategory {
  // 全部图标
  static List<IconInfo> get all => [
    ...navigation,
    ...action,
    ...media,
    ...social,
    ...device,
    ...file,
    ...emoji,
    ...other,
  ];

  // 导航类
  static const List<IconInfo> navigation = [
    IconInfo(Icons.home, 'Home', '导航'),
    IconInfo(Icons.home_filled, 'Home Filled', '导航'),
    IconInfo(Icons.search, 'Search', '导航'),
    IconInfo(Icons.search_off, 'Search Off', '导航'),
    IconInfo(Icons.menu, 'Menu', '导航'),
    IconInfo(Icons.menu_open, 'Menu Open', '导航'),
    IconInfo(Icons.arrow_back, 'Arrow Back', '导航'),
    IconInfo(Icons.arrow_forward, 'Arrow Forward', '导航'),
    IconInfo(Icons.arrow_upward, 'Arrow Upward', '导航'),
    IconInfo(Icons.arrow_downward, 'Arrow Downward', '导航'),
    IconInfo(Icons.expand_more, 'Expand More', '导航'),
    IconInfo(Icons.expand_less, 'Expand Less', '导航'),
    IconInfo(Icons.chevron_left, 'Chevron Left', '导航'),
    IconInfo(Icons.chevron_right, 'Chevron Right', '导航'),
    IconInfo(Icons.close, 'Close', '导航'),
    IconInfo(Icons.refresh, 'Refresh', '导航'),
    IconInfo(Icons.more_horiz, 'More Horiz', '导航'),
    IconInfo(Icons.more_vert, 'More Vert', '导航'),
    IconInfo(Icons.apps, 'Apps', '导航'),
    IconInfo(Icons.grid_view, 'Grid View', '导航'),
  ];

  // 操作类
  static const List<IconInfo> action = [
    IconInfo(Icons.favorite, 'Favorite', '操作'),
    IconInfo(Icons.favorite_border, 'Favorite Border', '操作'),
    IconInfo(Icons.star, 'Star', '操作'),
    IconInfo(Icons.star_border, 'Star Border', '操作'),
    IconInfo(Icons.star_half, 'Star Half', '操作'),
    IconInfo(Icons.thumb_up, 'Thumb Up', '操作'),
    IconInfo(Icons.thumb_up_off_alt, 'Thumb Up Off', '操作'),
    IconInfo(Icons.thumb_down, 'Thumb Down', '操作'),
    IconInfo(Icons.thumb_down_off_alt, 'Thumb Down Off', '操作'),
    IconInfo(Icons.add, 'Add', '操作'),
    IconInfo(Icons.remove, 'Remove', '操作'),
    IconInfo(Icons.delete, 'Delete', '操作'),
    IconInfo(Icons.delete_forever, 'Delete Forever', '操作'),
    IconInfo(Icons.edit, 'Edit', '操作'),
    IconInfo(Icons.create, 'Create', '操作'),
    IconInfo(Icons.save, 'Save', '操作'),
    IconInfo(Icons.share, 'Share', '操作'),
    IconInfo(Icons.print, 'Print', '操作'),
    IconInfo(Icons.settings, 'Settings', '操作'),
    IconInfo(Icons.lock, 'Lock', '操作'),
    IconInfo(Icons.lock_open, 'Lock Open', '操作'),
    IconInfo(Icons.visibility, 'Visibility', '操作'),
    IconInfo(Icons.visibility_off, 'Visibility Off', '操作'),
    IconInfo(Icons.download, 'Download', '操作'),
    IconInfo(Icons.upload, 'Upload', '操作'),
    IconInfo(Icons.check, 'Check', '操作'),
    IconInfo(Icons.close, 'Close', '操作'),
    IconInfo(Icons.clear, 'Clear', '操作'),
    IconInfo(Icons.undo, 'Undo', '操作'),
    IconInfo(Icons.redo, 'Redo', '操作'),
  ];

  // 媒体类
  static const List<IconInfo> media = [
    IconInfo(Icons.play_arrow, 'Play Arrow', '媒体'),
    IconInfo(Icons.pause, 'Pause', '媒体'),
    IconInfo(Icons.stop, 'Stop', '媒体'),
    IconInfo(Icons.skip_previous, 'Skip Previous', '媒体'),
    IconInfo(Icons.skip_next, 'Skip Next', '媒体'),
    IconInfo(Icons.repeat, 'Repeat', '媒体'),
    IconInfo(Icons.shuffle, 'Shuffle', '媒体'),
    IconInfo(Icons.volume_up, 'Volume Up', '媒体'),
    IconInfo(Icons.volume_down, 'Volume Down', '媒体'),
    IconInfo(Icons.volume_off, 'Volume Off', '媒体'),
    IconInfo(Icons.music_note, 'Music Note', '媒体'),
    IconInfo(Icons.music_video, 'Music Video', '媒体'),
    IconInfo(Icons.videocam, 'Videocam', '媒体'),
    IconInfo(Icons.videocam_off, 'Videocam Off', '媒体'),
    IconInfo(Icons.photo_camera, 'Photo Camera', '媒体'),
    IconInfo(Icons.photo_library, 'Photo Library', '媒体'),
    IconInfo(Icons.image, 'Image', '媒体'),
    IconInfo(Icons.mic, 'Mic', '媒体'),
    IconInfo(Icons.mic_off, 'Mic Off', '媒体'),
    IconInfo(Icons.headphones, 'Headphones', '媒体'),
  ];

  // 社交类
  static const List<IconInfo> social = [
    IconInfo(Icons.person, 'Person', '社交'),
    IconInfo(Icons.person_add, 'Person Add', '社交'),
    IconInfo(Icons.person_remove, 'Person Remove', '社交'),
    IconInfo(Icons.group, 'Group', '社交'),
    IconInfo(Icons.group_add, 'Group Add', '社交'),
    IconInfo(Icons.message, 'Message', '社交'),
    IconInfo(Icons.chat, 'Chat', '社交'),
    IconInfo(Icons.chat_bubble, 'Chat Bubble', '社交'),
    IconInfo(Icons.notifications, 'Notifications', '社交'),
    IconInfo(Icons.notifications_off, 'Notifications Off', '社交'),
    IconInfo(Icons.email, 'Email', '社交'),
    IconInfo(Icons.send, 'Send', '社交'),
    IconInfo(Icons.share, 'Share', '社交'),
    IconInfo(Icons.people, 'People', '社交'),
    IconInfo(Icons.people_outline, 'People Outline', '社交'),
    IconInfo(Icons.support, 'Support', '社交'),
    IconInfo(Icons.contact_mail, 'Contact Mail', '社交'),
    IconInfo(Icons.contact_phone, 'Contact Phone', '社交'),
    IconInfo(Icons.account_circle, 'Account Circle', '社交'),
    IconInfo(Icons.account_box, 'Account Box', '社交'),
  ];

  // 设备类
  static const List<IconInfo> device = [
    IconInfo(Icons.phone, 'Phone', '设备'),
    IconInfo(Icons.phone_android, 'Phone Android', '设备'),
    IconInfo(Icons.phone_iphone, 'Phone iPhone', '设备'),
    IconInfo(Icons.laptop, 'Laptop', '设备'),
    IconInfo(Icons.computer, 'Computer', '设备'),
    IconInfo(Icons.tablet, 'Tablet', '设备'),
    IconInfo(Icons.watch, 'Watch', '设备'),
    IconInfo(Icons.headset, 'Headset', '设备'),
    IconInfo(Icons.speaker, 'Speaker', '设备'),
    IconInfo(Icons.tv, 'TV', '设备'),
    IconInfo(Icons.gamepad, 'Gamepad', '设备'),
    IconInfo(Icons.keyboard, 'Keyboard', '设备'),
    IconInfo(Icons.mouse, 'Mouse', '设备'),
    IconInfo(Icons.print, 'Print', '设备'),
    IconInfo(Icons.scanner, 'Scanner', '设备'),
    IconInfo(Icons.device_unknown, 'Device Unknown', '设备'),
    IconInfo(Icons.devices, 'Devices', '设备'),
    IconInfo(Icons.smartphone, 'Smartphone', '设备'),
    IconInfo(Icons.memory, 'Memory', '设备'),
    IconInfo(Icons.sd_card, 'SD Card', '设备'),
  ];

  // 文件类
  static const List<IconInfo> file = [
    IconInfo(Icons.folder, 'Folder', '文件'),
    IconInfo(Icons.folder_open, 'Folder Open', '文件'),
    IconInfo(Icons.folder_shared, 'Folder Shared', '文件'),
    IconInfo(Icons.file_present, 'File Present', '文件'),
    IconInfo(Icons.attachment, 'Attachment', '文件'),
    IconInfo(Icons.drive_file_rename_outline, 'File Rename', '文件'),
    IconInfo(Icons.drive_folder_upload, 'Folder Upload', '文件'),
    IconInfo(Icons.insert_drive_file, 'Drive File', '文件'),
    IconInfo(Icons.insert_photo, 'Insert Photo', '文件'),
    IconInfo(Icons.insert_chart, 'Insert Chart', '文件'),
    IconInfo(Icons.picture_as_pdf, 'PDF', '文件'),
    IconInfo(Icons.description, 'Description', '文件'),
    IconInfo(Icons.text_snippet, 'Text Snippet', '文件'),
    IconInfo(Icons.upload_file, 'Upload File', '文件'),
    IconInfo(Icons.download_done, 'Download Done', '文件'),
  ];

  // 表情类
  static const List<IconInfo> emoji = [
    IconInfo(Icons.emoji_emotions, 'Emoji Emotions', '表情'),
    IconInfo(Icons.emoji_people, 'Emoji People', '表情'),
    IconInfo(Icons.emoji_nature, 'Emoji Nature', '表情'),
    IconInfo(Icons.emoji_food_beverage, 'Food', '表情'),
    IconInfo(Icons.emoji_transportation, 'Transportation', '表情'),
    IconInfo(Icons.emoji_symbols, 'Symbols', '表情'),
    IconInfo(Icons.emoji_objects, 'Objects', '表情'),
    IconInfo(Icons.sentiment_very_satisfied, 'Very Satisfied', '表情'),
    IconInfo(Icons.sentiment_satisfied, 'Satisfied', '表情'),
    IconInfo(Icons.sentiment_dissatisfied, 'Dissatisfied', '表情'),
    IconInfo(Icons.sentiment_very_dissatisfied, 'Very Dissatisfied', '表情'),
    IconInfo(Icons.sentiment_neutral, 'Neutral', '表情'),
    IconInfo(Icons.mood, 'Mood', '表情'),
    IconInfo(Icons.mood_bad, 'Mood Bad', '表情'),
    IconInfo(Icons.face, 'Face', '表情'),
    IconInfo(Icons.face_retouching_natural, 'Face Retouch', '表情'),
    IconInfo(Icons.tag_faces, 'Tag Faces', '表情'),
  ];

  // 其他常用
  static const List<IconInfo> other = [
    IconInfo(Icons.public, 'Public', '其他'),
    IconInfo(Icons.location_on, 'Location', '其他'),
    IconInfo(Icons.timer, 'Timer', '其他'),
    IconInfo(Icons.alarm, 'Alarm', '其他'),
    IconInfo(Icons.calendar_today, 'Calendar', '其他'),
    IconInfo(Icons.wb_sunny, 'Sunny', '其他'),
    IconInfo(Icons.nightlight, 'Night', '其他'),
    IconInfo(Icons.wifi, 'WiFi', '其他'),
    IconInfo(Icons.bluetooth, 'Bluetooth', '其他'),
    IconInfo(Icons.battery_full, 'Battery', '其他'),
    IconInfo(Icons.flash_on, 'Flash', '其他'),
    IconInfo(Icons.help, 'Help', '其他'),
    IconInfo(Icons.info, 'Info', '其他'),
    IconInfo(Icons.warning, 'Warning', '其他'),
    IconInfo(Icons.error, 'Error', '其他'),
    IconInfo(Icons.check_circle, 'Check Circle', '其他'),
    IconInfo(Icons.cancel, 'Cancel', '其他'),
    IconInfo(Icons.done, 'Done', '其他'),
    IconInfo(Icons.build, 'Build', '其他'),
    IconInfo(Icons.extension, 'Extension', '其他'),
    IconInfo(Icons.power_settings_new, 'Power', '其他'),
    IconInfo(Icons.restart_alt, 'Restart', '其他'),
    IconInfo(Icons.sync, 'Sync', '其他'),
    IconInfo(Icons.tune, 'Tune', '其他'),
    IconInfo(Icons.change_history, 'Change History', '其他'),
    IconInfo(Icons.code, 'Code', '其他'),
    IconInfo(Icons.terminal, 'Terminal', '其他'),
    IconInfo(Icons.bug_report, 'Bug Report', '其他'),
    IconInfo(Icons.rocket, 'Rocket', '其他'),
    IconInfo(Icons.auto_awesome, 'Auto Awesome', '其他'),
  ];
}

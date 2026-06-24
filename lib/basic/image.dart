import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// ============================================================
/// Image 完整用法示例
/// 涵盖：网络图片、本地资源、文件图片、内存图片、
/// 圆角/圆形裁剪、颜色混合、加载状态、性能优化等
/// ============================================================

class ImageDemo extends StatelessWidget {
  const ImageDemo({super.key});

  // ============================================================
  // 缓存 ImageProvider 示例（避免重复创建）
  // ============================================================
  static final _cachedNetworkImage = NetworkImage(
    'https://picsum.photos/seed/1/400/300',
    scale: 1.0,
    headers: {'Cache-Control': 'max-age=3600'},
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ============================================================
          // 1. 网络图片 - 基础用法
          // ============================================================
          _buildSectionTitle('1. 网络图片 (Image.network)', '从 URL 加载图片'),
          _buildNetworkImageExamples(),

          const SizedBox(height: 24),

          // ============================================================
          // 2. 本地资源图片
          // ============================================================
          _buildSectionTitle('2. 本地资源 (Image.asset)', '从 assets 目录加载'),
          _buildAssetImageExamples(),

          const SizedBox(height: 24),

          // ============================================================
          // 3. 文件图片
          // ============================================================
          _buildSectionTitle('3. 文件图片 (Image.file)', '从设备文件系统加载'),
          _buildFileImageExample(),

          const SizedBox(height: 24),

          // ============================================================
          // 4. 内存图片
          // ============================================================
          _buildSectionTitle('4. 内存图片 (Image.memory)', '从 Uint8List 字节数据加载'),
          _buildMemoryImageExample(),

          const SizedBox(height: 24),

          // ============================================================
          // 5. 图片尺寸控制 (BoxFit)
          // ============================================================
          _buildSectionTitle('5. 尺寸控制 (BoxFit)', '图片适配容器的 7 种方式'),
          _buildBoxFitExamples(),

          const SizedBox(height: 24),

          // ============================================================
          // 6. 圆角与圆形图片
          // ============================================================
          _buildSectionTitle('6. 圆角与圆形', 'ClipRRect / ClipOval / CircleAvatar'),
          _buildRoundedImageExamples(),

          const SizedBox(height: 24),

          // ============================================================
          // 7. 颜色混合与滤镜
          // ============================================================
          _buildSectionTitle('7. 颜色混合', 'color + colorBlendMode 实现滤镜效果'),
          _buildColorBlendExamples(),

          const SizedBox(height: 24),

          // ============================================================
          // 8. 图片重复 (ImageRepeat)
          // ============================================================
          _buildSectionTitle('8. 图片重复', 'repeat / repeatX / repeatY / noRepeat'),
          _buildRepeatExamples(),

          const SizedBox(height: 24),

          // ============================================================
          // 9. 加载状态管理
          // ============================================================
          _buildSectionTitle('9. 加载状态', 'loadingBuilder / errorBuilder / frameBuilder'),
          _buildLoadingStateExamples(),

          const SizedBox(height: 24),

          // ============================================================
          // 10. 图片缓存优化
          // ============================================================
          _buildSectionTitle('10. 缓存优化', 'cacheWidth / cacheHeight / RepaintBoundary'),
          _buildCacheOptimizationExamples(),

          const SizedBox(height: 24),

          // ============================================================
          // 11. 9宫格拉伸 (.9图)
          // ============================================================
          _buildSectionTitle('11. 9宫格拉伸', 'centerSlice 实现可拉伸背景'),
          _buildCenterSliceExample(),

          const SizedBox(height: 24),

          // ============================================================
          // 12. GIF 动画
          // ============================================================
          _buildSectionTitle('12. GIF 动画', 'frameBuilder 控制动画播放'),
          _buildGifExample(),

          const SizedBox(height: 24),

          // ============================================================
          // 13. 自定义 ImageProvider
          // ============================================================
          _buildSectionTitle('13. 自定义 ImageProvider', '复用 ImageProvider 实例'),
          _buildCustomProviderExample(),

          const SizedBox(height: 24),

          // ============================================================
          // 14. 图片预加载
          // ============================================================
          _buildSectionTitle('14. 图片预加载', 'precacheImage 提前加载'),
          _buildPrecacheExample(),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // ============================================================
  // 1. 网络图片 - 基础用法
  // ============================================================
  Widget _buildNetworkImageExamples() {
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
          const Text(
            '基础网络图片',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Image.network(
            'https://picsum.photos/seed/1/400/300',
            width: 200,
            height: 150,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),

          const Text(
            '带请求头的网络图片',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Image.network(
            'https://picsum.photos/seed/2/400/300',
            headers: {
              'Cache-Control': 'max-age=3600',
              'Accept': 'image/webp,image/*',
            },
            width: 200,
            height: 150,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 2. 本地资源图片
  // ============================================================
  Widget _buildAssetImageExamples() {
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
          const Text(
            '⚠️ 使用前需在 pubspec.yaml 中声明 assets',
            style: TextStyle(fontSize: 12, color: Colors.orange),
          ),
          const SizedBox(height: 8),

          const Text(
            '从 assets 加载图片',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Image.asset(
            'assets/images/placeholder.png',
            width: 200,
            height: 150,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 200,
                height: 150,
                color: Colors.grey[300],
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image_not_supported, color: Colors.grey),
                      Text('图片未找到', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),

          const Text(
            '从 package 加载图片',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Image.asset(
            'assets/images/icon.png',
            package: 'your_package_name',
            width: 200,
            height: 150,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 200,
                height: 150,
                color: Colors.grey[300],
                child: const Center(
                  child: Text(
                    'Package 图片',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey[200],
            child: const Text(
              'pubspec.yaml 配置示例:\n'
              'assets:\n'
              '  - assets/images/placeholder.png\n'
              '  - assets/images/icon.png',
              style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 3. 文件图片
  // ============================================================
  Widget _buildFileImageExample() {
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
          const Text(
            '从设备文件系统加载图片',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            '⚠️ 需要使用 image_picker 或 file_picker 获取文件路径',
            style: TextStyle(fontSize: 12, color: Colors.orange),
          ),
          // const SizedBox(height: 8),

          // 示例：显示选中的文件图片
          //_FileImageWidget(),
          const SizedBox(height: 12),

          const Text(
            '直接使用 File 对象（需确保文件存在）',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 4. 内存图片
  // ============================================================
  Widget _buildMemoryImageExample() {
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
          const Text(
            '从 Uint8List 字节数据加载',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _MemoryImageWidget(),
        ],
      ),
    );
  }

  // ============================================================
  // 5. 尺寸控制 (BoxFit)
  // ============================================================
  Widget _buildBoxFitExamples() {
    final imageUrl = 'https://picsum.photos/seed/3/400/300';

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
          const Text(
            '容器大小: 200×150, 图片原始大小: 400×300 (4:3)',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 12),

          // 使用 GridView 展示所有 BoxFit
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.5,
            ),
            itemCount: BoxFit.values.length,
            itemBuilder: (context, index) {
              final fit = BoxFit.values[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Image.network(
                        imageUrl,
                        fit: fit,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      color: Colors.grey[200],
                      child: Text(
                        fit.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 6. 圆角与圆形图片
  // ============================================================
  Widget _buildRoundedImageExamples() {
    final imageUrl = 'https://picsum.photos/seed/4/400/400';

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
          const Text(
            '圆角图片 (ClipRRect)',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.network(
                  imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          const Text(
            '圆形图片 (ClipOval / CircleAvatar)',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ClipOval(
                child: Image.network(
                  imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(imageUrl),
              ),
              const SizedBox(width: 12),
              CircleAvatar(
                radius: 40,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 7. 颜色混合与滤镜
  // ============================================================
  Widget _buildColorBlendExamples() {
    final imageUrl = 'https://picsum.photos/seed/5/400/300';

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
          const Text(
            '颜色叠加 (color + colorBlendMode)',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBlendExample(
                imageUrl,
                Colors.blue.withOpacity(0.5),
                BlendMode.modulate,
                'Modulate',
              ),
              _buildBlendExample(
                imageUrl,
                Colors.red.withOpacity(0.5),
                BlendMode.color,
                'Color',
              ),
              _buildBlendExample(
                imageUrl,
                Colors.green.withOpacity(0.5),
                BlendMode.screen,
                'Screen',
              ),
            ],
          ),
          const SizedBox(height: 16),

          const Text(
            '黑白/灰度效果',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBlendExample(
                imageUrl,
                Colors.black,
                BlendMode.saturation,
                '去色',
              ),
              _buildBlendExample(
                imageUrl,
                Colors.white,
                BlendMode.hue,
                '色调',
              ),
              _buildBlendExample(
                imageUrl,
                Colors.black,
                BlendMode.overlay,
                '叠加',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBlendExample(String url, Color color, BlendMode mode, String label) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              url,
              width: 100,
              height: 75,
              fit: BoxFit.cover,
              color: color,
              colorBlendMode: mode,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 11),
        ),
      ],
    );
  }

  // ============================================================
  // 8. 图片重复 (ImageRepeat)
  // ============================================================
  Widget _buildRepeatExamples() {
    final imageUrl = 'https://picsum.photos/seed/6/100/100';

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
          const Text(
            '注意: repeat 需要在容器比图片小时才有效果',
            style: TextStyle(fontSize: 12, color: Colors.orange),
          ),
          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: ImageRepeat.values.length,
            itemBuilder: (context, index) {
              final repeat = ImageRepeat.values[index];
              return Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        repeat: repeat,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      color: Colors.grey[200],
                      child: Text(
                        repeat.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 9. 加载状态管理
  // ============================================================
  Widget _buildLoadingStateExamples() {
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
          const Text(
            '带占位图/进度条 (loadingBuilder)',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Image.network(
            'https://picsum.photos/seed/7/400/300',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Container(
                height: 200,
                color: Colors.grey[200],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        loadingProgress.expectedTotalBytes != null
                            ? '${(loadingProgress.cumulativeBytesLoaded / 1024).toStringAsFixed(0)} KB / '
                                  '${(loadingProgress.expectedTotalBytes! / 1024).toStringAsFixed(0)} KB'
                            : '加载中...',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          const Text(
            '错误占位图 (errorBuilder)',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Image.network(
            'https://example.com/not_exist.jpg',
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 150,
                color: Colors.grey[200],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image,
                        size: 48,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '图片加载失败',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 10. 图片缓存优化
  // ============================================================
  Widget _buildCacheOptimizationExamples() {
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
          const Text(
            '✅ 使用 cacheWidth/cacheHeight 降低解码尺寸',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 4),
          const Text(
            '将 4K 图片解码为 200×200 内存减少 99%',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Image.network(
                  'https://picsum.photos/seed/8/4000/3000',
                  cacheWidth: 200,
                  cacheHeight: 150,
                  fit: BoxFit.cover,
                  height: 120,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Image.network(
                  'https://picsum.photos/seed/9/4000/3000',
                  cacheWidth: 100,
                  cacheHeight: 75,
                  fit: BoxFit.cover,
                  height: 120,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          const Text(
            '✅ 使用 RepaintBoundary 隔离重绘',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 4),
          const Text(
            '图片在 RepaintBoundary 中，不会随父 Widget 重绘而重绘',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          RepaintBoundary(
            child: Image.network(
              'https://picsum.photos/seed/10/400/300',
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
              cacheWidth: 400,
              cacheHeight: 300,
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            '✅ 使用 FilterQuality 控制渲染质量',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Image.network(
                      'https://picsum.photos/seed/11/400/300',
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.low,
                      cacheWidth: 200,
                      cacheHeight: 150,
                    ),
                    const Text('Low', style: TextStyle(fontSize: 11)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    Image.network(
                      'https://picsum.photos/seed/11/400/300',
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      cacheWidth: 200,
                      cacheHeight: 150,
                    ),
                    const Text('High', style: TextStyle(fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 11. 9宫格拉伸 (.9图)
  // ============================================================
  Widget _buildCenterSliceExample() {
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
          const Text(
            '9宫格拉伸 (centerSlice)',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            '⚠️ 需要 .9.png 格式图片或手动指定 centerSlice 区域',
            style: TextStyle(fontSize: 12, color: Colors.orange),
          ),
          const SizedBox(height: 8),
          const Text(
            '示例: 按钮背景拉伸',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),

          // 使用带 centerSlice 的图片（需要实际 .9 图片）
          Center(
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Image.asset(
                'assets/images/button_bg.9.png',
                fit: BoxFit.fill,
                centerSlice: const Rect.fromLTRB(20, 20, 80, 80),
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        'Button',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),

          const Text(
            '用法说明:',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Rect.fromLTRB(left, top, right, bottom)',
            style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
          const Text(
            '其中 left/right 为水平拉伸区域，top/bottom 为垂直拉伸区域',
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 12. GIF 动画
  // ============================================================
  Widget _buildGifExample() {
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
          const Text(
            'GIF 动画基础加载',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Image.network(
            'https://media.giphy.com/media/xT9IgzoKnwFNmISR8I/giphy.gif',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              // frame 为当前帧索引，首次加载为 null
              if (wasSynchronouslyLoaded) {
                return child;
              }
              return AnimatedOpacity(
                opacity: frame == null ? 0 : 1,
                duration: const Duration(milliseconds: 300),
                child: child,
              );
            },
          ),
          const SizedBox(height: 16),

          const Text(
            'GIF 加载状态 + 淡入效果',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Image.network(
            'https://media.giphy.com/media/l3vR7nTv7y0f3OPSo/giphy.gif',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Container(
                width: 200,
                height: 200,
                color: Colors.grey[200],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (frame == null) {
                return Container(
                  width: 200,
                  height: 200,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Text('加载中...'),
                  ),
                );
              }
              return child;
            },
          ),
          const SizedBox(height: 12),

          const Text(
            '⚠️ GIF 内存优化建议:',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.orange),
          ),
          const Text(
            '1. 使用 cacheWidth/cacheHeight 降低解码尺寸',
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
          const Text(
            '2. 使用 RepaintBoundary 隔离重绘',
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
          const Text(
            '3. 优先使用 WebP 替代 GIF',
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 13. 自定义 ImageProvider
  // ============================================================
  Widget _buildCustomProviderExample() {
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
          const Text(
            '✅ 缓存 ImageProvider 避免重复创建',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 4),
          const Text(
            '将 ImageProvider 定义为 static final，在 Widget 树中复用',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              // 使用缓存的 NetworkImage
              Image(
                image: _cachedNetworkImage,
                width: 150,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 12),
              // 再次使用同一个 ImageProvider
              Image(
                image: _cachedNetworkImage,
                width: 150,
                height: 100,
                fit: BoxFit.cover,
              ),
            ],
          ),
          const SizedBox(height: 12),

          const Text(
            '代码示例:',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey[200],
            child: const Text(
              'static final _cachedImage = NetworkImage(\n'
              '  \'https://example.com/image.jpg\',\n'
              '  scale: 1.0,\n'
              '  headers: {\'Cache-Control\': \'max-age=3600\'},\n'
              ');',
              style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 14. 图片预加载
  // ============================================================
  Widget _buildPrecacheExample() {
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
          const Text(
            '✅ 使用 precacheImage 提前加载',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 4),
          const Text(
            '预加载的图片会提前进入缓存，显示时无需等待',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          _PrecacheImageWidget(),
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
// 辅助 Widget: 文件图片选择,保留示例不要删除
// ============================================================
// class _FileImageWidget extends StatefulWidget {
//   @override
//   State<_FileImageWidget> createState() => _FileImageWidgetState();
// }

// class _FileImageWidgetState extends State<_FileImageWidget> {
//   File? _selectedImage;
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickImage() async {
//     final XFile? image = await _picker.pickImage(
//       source: ImageSource.gallery,
//       maxWidth: 400,
//       maxHeight: 300,
//       imageQuality: 85,
//     );
//     if (image != null) {
//       setState(() {
//         _selectedImage = File(image.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton.icon(
//           onPressed: _pickImage,
//           icon: const Icon(Icons.photo_library),
//           label: const Text('选择图片'),
//         ),
//         const SizedBox(height: 8),
//         if (_selectedImage != null)
//           Image.file(
//             _selectedImage!,
//             width: 200,
//             height: 150,
//             fit: BoxFit.cover,
//           )
//         else
//           Container(
//             width: 200,
//             height: 150,
//             color: Colors.grey[300],
//             child: const Center(
//               child: Text('点击按钮选择图片'),
//             ),
//           ),
//       ],
//     );
//   }
// }

// ============================================================
// 辅助 Widget: 内存图片
// ============================================================
class _MemoryImageWidget extends StatefulWidget {
  @override
  State<_MemoryImageWidget> createState() => _MemoryImageWidgetState();
}

class _MemoryImageWidgetState extends State<_MemoryImageWidget> {
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _loadAssetImage();
  }

  Future<void> _loadAssetImage() async {
    try {
      final ByteData data = await rootBundle.load('assets/images/placeholder.png');
      setState(() {
        _imageBytes = data.buffer.asUint8List();
      });
    } catch (e) {
      // 图片不存在，生成测试数据
      await _generateTestImage();
    }
  }

  Future<void> _generateTestImage() async {
    // 生成一个简单的测试图片
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder, const Rect.fromLTWH(0, 0, 200, 150));
    final Paint paint = Paint()..color = const Color(0xFF2196F3);
    canvas.drawRect(const Rect.fromLTWH(0, 0, 200, 150), paint);

    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'Test',
        style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, const Offset(70, 60));

    final ui.Picture picture = recorder.endRecording();
    final ui.Image img = await picture.toImage(200, 150);
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null && mounted) {
      setState(() {
        _imageBytes = byteData.buffer.asUint8List();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_imageBytes == null) {
      return Container(
        width: 200,
        height: 150,
        color: Colors.grey[300],
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Image.memory(
      _imageBytes!,
      width: 200,
      height: 150,
      fit: BoxFit.cover,
    );
  }
}

// ============================================================
// 辅助 Widget: 图片预加载
// ============================================================
class _PrecacheImageWidget extends StatefulWidget {
  @override
  State<_PrecacheImageWidget> createState() => _PrecacheImageWidgetState();
}

class _PrecacheImageWidgetState extends State<_PrecacheImageWidget> {
  bool _isPrecached = false;
  bool _isLoading = false;
  final String _imageUrl = 'https://picsum.photos/seed/12/400/300';

  Future<void> _precacheImage() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await precacheImage(
        NetworkImage(_imageUrl),
        context,
        onError: (error, stackTrace) {
          print('预加载失败: $error');
        },
      );
      setState(() {
        _isPrecached = true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : _precacheImage,
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(_isPrecached ? '已预加载 ✅' : '预加载图片'),
            ),
            const SizedBox(width: 12),
            if (_isPrecached)
              const Text(
                '图片已缓存，点击下方查看',
                style: TextStyle(color: Colors.green),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Image.network(
          _imageUrl,
          width: double.infinity,
          height: 150,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Container(
              height: 150,
              color: Colors.grey[200],
              child: const Center(
                child: Text('加载中...'),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          _isPrecached ? '✅ 预加载后显示更快' : '普通加载（首次可能较慢）',
          style: TextStyle(
            fontSize: 12,
            color: _isPrecached ? Colors.green : Colors.grey,
          ),
        ),
      ],
    );
  }
}

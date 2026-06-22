import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageTabsScafold extends StatefulWidget {
  const MessageTabsScafold({super.key});

  @override
  State<MessageTabsScafold> createState() => _MessageTabsScafoldState();
}

class _MessageTabsScafoldState extends State<MessageTabsScafold> with TickerProviderStateMixin {
  int tabIndex = 0;
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Message Center')),
      body: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: 'notifications'),
              Tab(text: 'messages'),
            ],
            onTap: (index) {
              if (tabIndex == index) return;
              setState(() {
                tabIndex = index;
              });
            },
          ),
          TabBarView(
            children: [
              MessageCenterTabCn(),
              ChatListViewPage(),
            ],
          ),
        ],
      ),
    );
  }
}

class MessageCenterTabCn extends StatefulWidget {
  const MessageCenterTabCn({super.key});

  @override
  State<MessageCenterTabCn> createState() => _MessageCenterTabCnState();
}

enum LoadingStatus {
  loadSuccess, //页面加载成功，至少有一条数据
  loadingProgress, // 页面加载中没有任何数据
  loadingFailure, //页面加载失败，没有任何数据
  loadMore, // 页面的热数据加载完成，显示加载更多按钮，电机后加载更多数据
  loadMoreInProgress, // 页面加载更多数据中，它可能是点击加载按钮加载冷数据，也可能是上拉加载热数据或者冷数据
  noHotData, // 热数据已经加载完成，并且后台没有冷数据
  noEarlierData, // 冷数据已经加载完成，所有数据都没有了
}

class _MessageCenterTabCnState extends State<MessageCenterTabCn> {
  CategoryItem current = CategoryItem(title: '', iconName: '');
  @override
  void initState() {
    super.initState();
    current = CategoryItem(title: 'home', iconName: 'home');
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          floating: false,
          pinned: false,
          delegate: CategorySliverPersistentHeader(
            items: [],
            onTap: (item) {
              if (current.iconName == item.iconName) {
              } else {
                setState(() {
                  current = item;
                });
              }
            },
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('title_$index'),
              subtitle: Text('subtitle_$index'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('title_$index was tapped')));
              },
            );
          },
        ),

        SizedBox(
          height: 80,
          child: Center(child: SizedBox(height: 40, child: CircularProgressIndicator())),
        ),
      ],
    );
  }
}

class CategorySliverPersistentHeader extends SliverPersistentHeaderDelegate {
  final List<CategoryItem> items;
  final ValueSetter<CategoryItem> onTap;
  CategorySliverPersistentHeader({
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    /**
     * 这里生成一个category,一行3列，均匀分布，边缘8，间距8，
     * 点击后某个category badge为0隐藏对应右上角红点
    */
    throw UnimplementedError();
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}

class CategoryItem {
  final String title;
  final String iconName;
  final int badge;
  CategoryItem({
    required this.title,
    required this.iconName,
    this.badge = 0,
  });
}

enum PinnedType {
  proprioty,
  pinned,
  unpinned,
}

enum DataType {
  toppingData, // proprioty,pinned
  hotData, // unpinned
  historyData, // unppined
}

class ListItem {
  final String title;
  final String iconName;
  final bool viewed;
  final PinnedType pinnedType;
  final DataType dataType;
  ListItem({
    required this.title,
    required this.iconName,
    this.viewed = false,
    this.pinnedType = PinnedType.unpinned,
    this.dataType = DataType.hotData,
  });
}

class HomePageData {
  final bool hasHistory;

  ///
  final List<ListItem> pinnedData;
  final List<ListItem> hotData;
  final String continuePageToken;
  HomePageData(
    this.hasHistory,
    this.pinnedData,
    this.hotData,
    this.continuePageToken,
  );
}

class HistoryPageData {
  final List<ListItem> historyData;
  final String continuePageToken;
  HistoryPageData(
    this.historyData,
    this.continuePageToken,
  );
}

class ChatListViewPage extends StatelessWidget {
  const ChatListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

abstract class DataCollectionProtocol {
  List<dynamic> get items;
}

class DataCollection implements DataCollectionProtocol {
  @override
  List get items => throw UnimplementedError();
}

class DataApi {
  Future<HomePageData> getPageData() async {
    throw UnimplementedError();
  }

  Future<HistoryPageData> getHistoryData() async {
    throw UnimplementedError();
  }

  Future<List<CategoryItem>> getCategoryItems() async {
    throw UnimplementedError();
  }
}

class CategoryCubit extends Cubit {
  CategoryCubit(super.initialState);
}

class MessageListCubit extends Cubit implements DataCollectionProtocol {
  MessageListCubit(super.initialState);

  @override
  // TODO: implement items
  List get items => throw UnimplementedError();
}

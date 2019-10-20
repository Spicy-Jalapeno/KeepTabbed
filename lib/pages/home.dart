import 'package:flutter/material.dart';
import '../widgets/bottom_bar.dart';
import 'calendar.dart';
import 'settings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Widget _buildTabContent() {
    return Positioned.fill(
      child: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Home(),
            Calendar(),
            Settings(),
          ]),
    );
  }

  void _tabSelected(int newIndex) {
    setState(() {
      _selectedTab = newIndex;
      _tabController.index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = Scaffold(
      body: Stack(
        children: [
          _buildTabContent(),
          _BottomTabs(
            selectedTab: _selectedTab,
            onTap: _tabSelected,
          ),
        ],
      ),
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        content,
      ],
    );
  }
}

class _BottomTabs extends StatelessWidget {
  _BottomTabs({
    @required this.selectedTab,
    @required this.onTap,
  });

  final int selectedTab;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    // final messages = MessageProvider.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: BottomBar(
        currentIndex: selectedTab,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            title: Text("Home"),
            icon: const Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Calendar'),
            icon: const Icon(Icons.calendar_today),
          ),
          BottomNavigationBarItem(
            title: Text('Settings'),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}

// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Home'),
//         ),
//         bottomNavigationBar: BottomAppBar(
//           child: new Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               IconButton(
//                 icon: Icon(Icons.home),
//                 onPressed: () {
//                   Navigator.of(context).pushReplacementNamed('/');
//                 },
//               ),
//               IconButton(
//                 icon: Icon(Icons.calendar_today),
//                 onPressed: () {
//                   Navigator.of(context).pushReplacementNamed('calendar');
//                 },
//               )
//             ],
//           ),
//         ),
//         body: Center(
//           child: RaisedButton(
//             child: Text('open route'),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Calendar()),
//               );
//             },
//           ),
//         ));
//   }
// }

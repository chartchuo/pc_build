import 'package:flutter/material.dart';

import 'package:pc_build/models/part.dart';
import 'package:pc_build/models/cpu.dart';
import 'package:pc_build/widgets/widgets.dart';

import 'cpu_state.dart';
import 'cpu_filter.dart';

class CpuPage2 extends StatefulWidget {
  @override
  _CpuPage2State createState() => _CpuPage2State();
}

class _CpuPage2State extends State<CpuPage2> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  bool showSearch = false;

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(searchListener);
    cpuState.loadData();
  }

  @override
  Widget build(BuildContext context) {
    myTextStyle.init(); // call reinit text style to work with hot reload

    return Scaffold(
      key: _scaffoldKey,
      appBar: appBarBuilder(context),
      body: Container(
        decoration: MyBackgroundDecoration2(),
        child: bodyBuilder(),
      ),
    );
  }

  searchListener() {
    if (searchController.text != null) {
      if (searchController.text.length > 1) {
        cpuState.doSearch(searchController.text);
      } else {
        cpuState.doSearch('');
      }
    }
  }

  toggleSearch() {
    setState(() {
      showSearch = !showSearch;
      if (!showSearch) cpuState.doSearch('');
    });
  }

  AppBar appBarBuilder(BuildContext context) {
    return AppBar(
      title: Text('CPU'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          tooltip: 'Search',
          onPressed: () {
            toggleSearch();
          },
        ),
        IconButton(
          icon: Icon(
            Icons.tune,
            // color: filtered.length == all.length ? Colors.white : Colors.pink,
          ),
          tooltip: 'Filter',
          onPressed: () {
            navigate2filterPage(context);
          },
        ),
        PopupMenuButton(
          onSelected: (v) => cpuState.doSort(v),
          icon: Icon(Icons.sort),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text('Latest'),
                value: Sort.latest,
              ),
              PopupMenuItem(
                child: Text('Low price'),
                value: Sort.lowPrice,
              ),
              PopupMenuItem(
                child: Text('High price'),
                value: Sort.highPrice,
              ),
            ];
          },
        ),
      ],
    );
  }

  Widget bodyBuilder() {
    return Column(
      children: <Widget>[
        showSearch
            ? SearchField(
                searchController: searchController,
              )
            : SizedBox(),
        Expanded(
          child: listBuilder(),
        ),
      ],
    );
  }

  Widget listBuilder() {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: cpuState.loadData,
      child: StreamBuilder<List<Part>>(
        stream: cpuState.list,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                var v = snapshot.data[i];
                return PartTile(
                  image: v.picture,
                  url: v.path ?? '',
                  title: v.brand,
                  subTitle: v.model,
                  price: v.price,
                  index: i,
                  onAdd: (i) {
                    Navigator.pop(context, v);
                  },
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  navigate2filterPage(BuildContext context) async {
    CpuFilter result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CpuFilterPage(
                  selectedFilter: cpuState.filter,
                  all: cpuState.all,
                )));
    if (result != null) {
      cpuState.setFilter = result;
      cpuState.doFilter();
    }
  }
}

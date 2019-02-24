import 'package:flutter/material.dart';
import 'package:pc_build/models/vga.dart';

class VgaFilterPage extends StatefulWidget {
  final VgaFilter allFilter;
  final VgaFilter selectedFilter;

  VgaFilterPage({Key key, this.allFilter, this.selectedFilter})
      : super(key: key);

  @override
  _VgaFilterPageState createState() => _VgaFilterPageState();
}

class _VgaFilterPageState extends State<VgaFilterPage> {
  VgaFilter allFilter;
  VgaFilter selectedFilter;

  @override
  void initState() {
    super.initState();
    allFilter = widget.allFilter;
    selectedFilter = widget.selectedFilter;
  }

  @override
  Widget build(BuildContext context) {
    // List<String> allBrandList = allFilter.vgaBrand.toList()..sort();
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            tooltip: 'OK',
            onPressed: () {
              Navigator.pop(context, selectedFilter);
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Brands'),
            trailing:
                selectAllMaker(allFilter.vgaBrand, selectedFilter.vgaBrand),
          ),
          filterChipMaker(allFilter.vgaBrand, selectedFilter.vgaBrand),
          ListTile(
            title: Text('vgaChipset'),
            trailing:
                selectAllMaker(allFilter.vgaChipset, selectedFilter.vgaChipset),
          ),
          filterChipMaker(allFilter.vgaChipset, selectedFilter.vgaChipset),
          ListTile(
            title: Text('vgaSeries'),
            trailing:
                selectAllMaker(allFilter.vgaSeries, selectedFilter.vgaSeries),
          ),
          filterChipMaker(allFilter.vgaSeries, selectedFilter.vgaSeries),
        ],
      ),
    );
  }

  Widget selectAllMaker(Set<String> all, Set<String> selected) {
    if (all.length == selected.length)
      return FlatButton(
        child: Text('clear all'),
        onPressed: () {
          setState(() {
            selected.clear();
          });
        },
      );
    else
      return FlatButton(
        child: Text('select all'),
        onPressed: () {
          setState(() {
            selected.addAll(all);
          });
        },
      );
  }

  Widget filterChipMaker(Set<String> all, Set<String> s) {
    Widget internalMaker(String b) {
      return Container(
        margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
        child: FilterChip(
          shape: Border.all(style: BorderStyle.none),
          avatar: Text(' '),
          label: Text(b),
          selected: s.contains(b),
          onSelected: (bool sel) {
            setState(() {
              if (sel)
                s.add(b);
              else
                s.remove(b);
            });
          },
        ),
      );
    }

    List<String> allList = all.toList()..sort();
    return Wrap(
      children: allList.map((b) => internalMaker(b)).toList(),
    );
  }
}

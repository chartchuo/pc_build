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
    List<String> allBrandList = allFilter.vgaBrand.toList()..sort();
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
            trailing: allBrandList.length == selectedFilter.vgaBrand.length
                ? FlatButton(
                    child: Text('unselect all'),
                    onPressed: () {
                      setState(() {
                        selectedFilter.vgaBrand.clear();
                      });
                    },
                  )
                : FlatButton(
                    child: Text('select all'),
                    onPressed: () {
                      setState(() {
                        selectedFilter.vgaBrand.addAll(allBrandList);
                      });
                    },
                  ),
          ),
          Wrap(
            children: allBrandList.map((b) => filterChipMaker(b)).toList(),
          )
        ],
      ),
    );
  }

  Widget filterChipMaker(String b) {
    return Container(
      margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: FilterChip(
        shape: Border.all(style: BorderStyle.none),
        avatar: Text(' '),
        label: Text(b),
        selected: selectedFilter.vgaBrand.contains(b),
        onSelected: (bool sel) {
          setState(() {
            if (sel)
              selectedFilter.vgaBrand.add(b);
            else
              selectedFilter.vgaBrand.remove(b);
          });
        },
      ),
    );
  }
}

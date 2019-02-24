import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

import 'package:pc_build/models/vga.dart';

class VgaFilterPage extends StatefulWidget {
  final VgaFilter selectedFilter;
  final List<Vga> allVgas;

  VgaFilterPage({Key key, this.selectedFilter, this.allVgas}) : super(key: key);

  @override
  _VgaFilterPageState createState() => _VgaFilterPageState();
}

class _VgaFilterPageState extends State<VgaFilterPage> {
  VgaFilter allFilter;
  VgaFilter validFilter;
  VgaFilter selectedFilter;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    allFilter = VgaFilter.fromVgas(widget.allVgas);
    validFilter = allFilter;
    selectedFilter = widget.selectedFilter;
    if (selectedFilter.maxPrice > allFilter.maxPrice)
      selectedFilter.maxPrice = allFilter.maxPrice;
    if (selectedFilter.minPrice < allFilter.minPrice)
      selectedFilter.minPrice = allFilter.minPrice;
    recalFilter();
  }

  resetData() {
    setState(() {
      allFilter = VgaFilter.fromVgas(widget.allVgas);
      validFilter = allFilter;
      selectedFilter = VgaFilter();
      selectedFilter.minPrice = allFilter.minPrice;
      selectedFilter.maxPrice = allFilter.maxPrice;
    });
  }

  recalFilter() {
    setState(() {
      validFilter = VgaFilter.clone(allFilter);
      var tmpFilter = VgaFilter.clone(allFilter);

      //calculate valid by price
      tmpFilter.minPrice = selectedFilter.minPrice;
      tmpFilter.maxPrice = selectedFilter.maxPrice;
      var tmpVgas = tmpFilter.filters(widget.allVgas);
      var resultFilter = VgaFilter.fromVgas(tmpVgas);
      validFilter.vgaBrand = resultFilter.vgaBrand;
      selectedFilter.vgaBrand =
          selectedFilter.vgaBrand.intersection(validFilter.vgaBrand);

      //caclulate valid by brand
      tmpFilter.vgaBrand =
          allFilter.vgaBrand.intersection(selectedFilter.vgaBrand);
      tmpVgas = tmpFilter.filters(widget.allVgas);
      resultFilter = VgaFilter.fromVgas(tmpVgas);
      validFilter.vgaChipset = resultFilter.vgaChipset;
      selectedFilter.vgaChipset =
          selectedFilter.vgaChipset.intersection(validFilter.vgaChipset);

      //caclulate valid by chipset
      tmpFilter.vgaChipset =
          allFilter.vgaChipset.intersection(selectedFilter.vgaChipset);
      tmpVgas = tmpFilter.filters(widget.allVgas);
      resultFilter = VgaFilter.fromVgas(tmpVgas);
      validFilter.vgaSeries = resultFilter.vgaSeries;
      selectedFilter.vgaSeries =
          selectedFilter.vgaSeries.intersection(validFilter.vgaSeries);
    });
  }

  @override
  Widget build(BuildContext context) {
    // List<String> allBrandList = allFilter.vgaBrand.toList()..sort();
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings_backup_restore),
            tooltip: 'Reset',
            onPressed: () => resetData(),
          ),
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
            title: Text('ราคา'),
            trailing: Text(
                '${selectedFilter.minPrice}-${selectedFilter.maxPrice} บาท'),
          ),
          RangeSlider(
            min: allFilter.minPrice.toDouble(),
            max: allFilter.maxPrice.toDouble(),
            lowerValue: selectedFilter.minPrice.toDouble(),
            upperValue: selectedFilter.maxPrice.toDouble(),
            divisions: 20,
            showValueIndicator: true,
            valueIndicatorMaxDecimals: 0,
            onChanged: (l, u) {
              setState(() {
                selectedFilter.minPrice = l.toInt();
                selectedFilter.maxPrice = u.toInt();
                recalFilter();
              });
            },
          ),
          ListTile(
            title: Text('Brands'),
            trailing: clearAllMaker(selectedFilter.vgaBrand),
          ),
          filterChipMaker(allFilter.vgaBrand, validFilter.vgaBrand,
              selectedFilter.vgaBrand),
          ListTile(
            title: Text('Chipset'),
            trailing: clearAllMaker(selectedFilter.vgaChipset),
          ),
          filterChipMaker(allFilter.vgaChipset, validFilter.vgaChipset,
              selectedFilter.vgaChipset),
          ListTile(
            title: Text('Series'),
            trailing: clearAllMaker(selectedFilter.vgaSeries),
          ),
          filterChipMaker(allFilter.vgaSeries, validFilter.vgaSeries,
              selectedFilter.vgaSeries,
              showInvalid: false),
        ],
      ),
    );
  }

  Widget clearAllMaker(Set<String> selected) {
    return FlatButton(
      child: Text('clear'),
      onPressed: selected.length == 0
          ? null
          : () {
              setState(() {
                selected.clear();
                recalFilter();
              });
            },
    );
  }

  Widget filterChipMaker(
      Set<String> all, Set<String> valid, Set<String> selected,
      {bool showInvalid = true}) {
    List<String> allList = all.toList()..sort();
    if (!showInvalid) allList.removeWhere((v) => !valid.contains(v));
    return Container(
      margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Wrap(
        children: allList.map((b) {
          return FilterChip(
            label: Text(b),
            selected: selected.contains(b),
            onSelected: !valid.contains(b)
                ? null
                : (bool sel) {
                    setState(() {
                      if (sel) {
                        selected.add(b);
                        recalFilter();
                      } else {
                        selected.remove(b);
                        recalFilter();
                      }
                    });
                  },
          );
        }).toList(),
      ),
    );
  }
}

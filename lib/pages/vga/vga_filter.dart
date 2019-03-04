import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

import 'package:pc_build/widgets/widgets.dart';
import 'package:pc_build/models/vga.dart';

class VgaFilterPage extends StatefulWidget {
  final VgaFilter selectedFilter;
  final List<Vga> all;

  VgaFilterPage({Key key, this.selectedFilter, this.all}) : super(key: key);

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
    allFilter = VgaFilter.fromList(widget.all);
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
      allFilter = VgaFilter.fromList(widget.all);
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
      var tmpList = tmpFilter.filters(widget.all);
      var resultFilter = VgaFilter.fromList(tmpList);
      validFilter.vgaBrand = resultFilter.vgaBrand;
      selectedFilter.vgaBrand =
          selectedFilter.vgaBrand.intersection(validFilter.vgaBrand);

      //caclulate valid by brand
      tmpFilter.vgaBrand =
          allFilter.vgaBrand.intersection(selectedFilter.vgaBrand);
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = VgaFilter.fromList(tmpList);
      validFilter.vgaChipset = resultFilter.vgaChipset;
      selectedFilter.vgaChipset =
          selectedFilter.vgaChipset.intersection(validFilter.vgaChipset);

      //caclulate valid by chipset
      tmpFilter.vgaChipset =
          allFilter.vgaChipset.intersection(selectedFilter.vgaChipset);
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = VgaFilter.fromList(tmpList);
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
        backgroundColor: Colors.orange,
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
      body: Container(
        decoration: MyBackgroundDecoration3(),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('ราคา'),
              trailing: Text(
                  '${selectedFilter.minPrice}-${selectedFilter.maxPrice} \u{0e3f}'),
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
            filterChipMaker('Brands', allFilter.vgaBrand, validFilter.vgaBrand,
                selectedFilter.vgaBrand),
            filterChipMaker('Chipset', allFilter.vgaChipset,
                validFilter.vgaChipset, selectedFilter.vgaChipset),
            filterChipMaker('Series', allFilter.vgaSeries,
                validFilter.vgaSeries, selectedFilter.vgaSeries),
          ],
        ),
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
    String label,
    Set<String> all,
    Set<String> valid,
    Set<String> selected,
  ) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(label),
          trailing: clearAllMaker(selected),
        ),
        FilterChips(
          all: all,
          valid: valid,
          selected: selected,
          onSelected: (str) {
            setState(() {
              selected.add(str);
              recalFilter();
            });
          },
          onDeselected: (str) {
            setState(() {
              selected.remove(str);
              recalFilter();
            });
          },
        ),
      ],
    );
  }
}

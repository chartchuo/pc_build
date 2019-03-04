import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

import 'package:pc_build/widgets/widgets.dart';

import 'package:pc_build/models/ssd.dart';

class SsdFilterPage extends StatefulWidget {
  final SsdFilter selectedFilter;
  final List<Ssd> all;

  SsdFilterPage({Key key, this.selectedFilter, this.all}) : super(key: key);

  @override
  _SsdFilterPageState createState() => _SsdFilterPageState();
}

class _SsdFilterPageState extends State<SsdFilterPage> {
  SsdFilter allFilter;
  SsdFilter validFilter;
  SsdFilter selectedFilter;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    allFilter = SsdFilter.fromList(widget.all);
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
      allFilter = SsdFilter.fromList(widget.all);
      validFilter = allFilter;
      selectedFilter = SsdFilter();
      selectedFilter.minPrice = allFilter.minPrice;
      selectedFilter.maxPrice = allFilter.maxPrice;
    });
  }

  recalFilter() {
    setState(() {
      validFilter = SsdFilter.clone(allFilter);
      var tmpFilter = SsdFilter.clone(allFilter);

      //import price
      tmpFilter.minPrice = selectedFilter.minPrice;
      tmpFilter.maxPrice = selectedFilter.maxPrice;

      //filter valid brand
      var tmpList = tmpFilter.filters(widget.all);
      var resultFilter = SsdFilter.fromList(tmpList);
      validFilter.ssdBrand = resultFilter.ssdBrand;
      selectedFilter.ssdBrand =
          selectedFilter.ssdBrand.intersection(validFilter.ssdBrand);

      //import brand
      tmpFilter.ssdBrand =
          allFilter.ssdBrand.intersection(selectedFilter.ssdBrand);

      //filter interface
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = SsdFilter.fromList(tmpList);
      validFilter.ssdInterface = resultFilter.ssdInterface;
      selectedFilter.ssdInterface =
          selectedFilter.ssdInterface.intersection(validFilter.ssdInterface);

      //import interface
      tmpFilter.ssdInterface =
          allFilter.ssdInterface.intersection(selectedFilter.ssdInterface);

      //filter valid capa
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = SsdFilter.fromList(tmpList);
      validFilter.ssdCapacity = resultFilter.ssdCapacity;
      selectedFilter.ssdCapacity =
          selectedFilter.ssdCapacity.intersection(validFilter.ssdCapacity);
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
            filterChipMaker('Brands', allFilter.ssdBrand, validFilter.ssdBrand,
                selectedFilter.ssdBrand),
            filterChipMaker('Interface', allFilter.ssdInterface,
                validFilter.ssdInterface, selectedFilter.ssdInterface),
            filterChipMaker('Capacity', allFilter.ssdCapacity,
                validFilter.ssdCapacity, selectedFilter.ssdCapacity),
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

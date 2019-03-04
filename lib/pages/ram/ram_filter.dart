import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

import 'package:pc_build/widgets/widgets.dart';

import 'package:pc_build/models/ram.dart';

class RamFilterPage extends StatefulWidget {
  final RamFilter selectedFilter;
  final List<Ram> all;

  RamFilterPage({Key key, this.selectedFilter, this.all}) : super(key: key);

  @override
  _RamFilterPageState createState() => _RamFilterPageState();
}

class _RamFilterPageState extends State<RamFilterPage> {
  RamFilter allFilter;
  RamFilter validFilter;
  RamFilter selectedFilter;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    allFilter = RamFilter.fromList(widget.all);
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
      allFilter = RamFilter.fromList(widget.all);
      validFilter = allFilter;
      selectedFilter = RamFilter();
      selectedFilter.minPrice = allFilter.minPrice;
      selectedFilter.maxPrice = allFilter.maxPrice;
    });
  }

  recalFilter() {
    setState(() {
      validFilter = RamFilter.clone(allFilter);
      var tmpFilter = RamFilter.clone(allFilter);

      //import price
      tmpFilter.minPrice = selectedFilter.minPrice;
      tmpFilter.maxPrice = selectedFilter.maxPrice;

      //filter valid brand
      var tmpList = tmpFilter.filters(widget.all);
      var resultFilter = RamFilter.fromList(tmpList);
      validFilter.ramBrand = resultFilter.ramBrand;
      selectedFilter.ramBrand =
          selectedFilter.ramBrand.intersection(validFilter.ramBrand);

      //import brand
      tmpFilter.ramBrand =
          allFilter.ramBrand.intersection(selectedFilter.ramBrand);

      //filter valid type
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = RamFilter.fromList(tmpList);
      validFilter.ramType = resultFilter.ramType;
      selectedFilter.ramType =
          selectedFilter.ramType.intersection(validFilter.ramType);

      //import type
      tmpFilter.ramType =
          allFilter.ramType.intersection(selectedFilter.ramType);

      //filter valid capa
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = RamFilter.fromList(tmpList);
      validFilter.ramCapa = resultFilter.ramCapa;
      selectedFilter.ramCapa =
          selectedFilter.ramCapa.intersection(validFilter.ramCapa);

      //import capa
      tmpFilter.ramCapa =
          allFilter.ramCapa.intersection(selectedFilter.ramCapa);

      //filter valid bus
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = RamFilter.fromList(tmpList);
      validFilter.ramBus = resultFilter.ramBus;
      selectedFilter.ramBus =
          selectedFilter.ramBus.intersection(validFilter.ramBus);
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
            filterChipMaker('Brands', allFilter.ramBrand, validFilter.ramBrand,
                selectedFilter.ramBrand),
            filterChipMaker('Type', allFilter.ramType, validFilter.ramType,
                selectedFilter.ramType),
            filterChipMaker('Capacity', allFilter.ramCapa, validFilter.ramCapa,
                selectedFilter.ramCapa),
            filterChipMaker('Bus', allFilter.ramBus, validFilter.ramBus,
                selectedFilter.ramBus),
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

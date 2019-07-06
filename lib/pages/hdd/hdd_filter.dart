import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as rs;

import 'package:pc_build/widgets/widgets.dart';

import 'package:pc_build/models/hdd.dart';

import 'hdd_state.dart';

class HddFilterPage extends StatefulWidget {
  final HddFilter selectedFilter = hddState.filter;
  final List<Hdd> all = hddState.all;

  @override
  _HddFilterPageState createState() => _HddFilterPageState();
}

class _HddFilterPageState extends State<HddFilterPage> {
  HddFilter allFilter;
  HddFilter validFilter;
  HddFilter selectedFilter;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    allFilter = HddFilter.fromList(widget.all);
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
      allFilter = HddFilter.fromList(widget.all);
      validFilter = allFilter;
      selectedFilter = HddFilter();
      selectedFilter.minPrice = allFilter.minPrice;
      selectedFilter.maxPrice = allFilter.maxPrice;
    });
  }

  recalFilter() {
    setState(() {
      validFilter = HddFilter.clone(allFilter);
      var tmpFilter = HddFilter.clone(allFilter);

      //import price
      tmpFilter.minPrice = selectedFilter.minPrice;
      tmpFilter.maxPrice = selectedFilter.maxPrice;

      //filter valid brand
      var tmpList = tmpFilter.filters(widget.all);
      var resultFilter = HddFilter.fromList(tmpList);
      validFilter.brand = resultFilter.brand;
      selectedFilter.brand =
          selectedFilter.brand.intersection(validFilter.brand);

      //import brand
      tmpFilter.brand = allFilter.brand.intersection(selectedFilter.brand);

      //filter valid capa
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = HddFilter.fromList(tmpList);
      validFilter.capa = resultFilter.capa;
      selectedFilter.capa = selectedFilter.capa.intersection(validFilter.capa);

      //import capa
      tmpFilter.capa = allFilter.capa.intersection(selectedFilter.capa);

      //filter rpm
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = HddFilter.fromList(tmpList);
      validFilter.rpm = resultFilter.rpm;
      selectedFilter.rpm = selectedFilter.rpm.intersection(validFilter.rpm);
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
              hddState.setFilter(selectedFilter);
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
              title: titleText('ราคา'),
              trailing: titleText(
                  '${selectedFilter.minPrice}-${selectedFilter.maxPrice} \u{0e3f}'),
            ),
            rs.RangeSlider(
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
            filterChipMaker('Brands', allFilter.brand, validFilter.brand,
                selectedFilter.brand),
            filterChipMaker('Capacity', allFilter.capa, validFilter.capa,
                selectedFilter.capa),
            filterChipMaker(
                'RPM', allFilter.rpm, validFilter.rpm, selectedFilter.rpm),
            Container(
              margin: EdgeInsets.all(8),
              child: RaisedButton(
                child: Text('OK'),
                color: Colors.blueAccent,
                onPressed: () {
                  hddState.setFilter(selectedFilter);
                  Navigator.pop(context, selectedFilter);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text titleText(String txt) {
    return Text(
      txt,
      style: TextStyle(color: Colors.white),
    );
  }

  Widget clearAllMaker(Set<String> selected) {
    return FlatButton(
      child: Text(
        'clear',
        style: TextStyle(color: Colors.white),
      ),
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
          title: titleText(label),
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

import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as rs;

import 'package:pc_build/widgets/widgets.dart';

import 'package:pc_build/models/case.dart';

import 'case_state.dart';

class CaseFilterPage extends StatefulWidget {
  final CaseFilter selectedFilter = caseState.filter;
  final List<Case> all = caseState.all;

  @override
  _CaseFilterPageState createState() => _CaseFilterPageState();
}

class _CaseFilterPageState extends State<CaseFilterPage> {
  CaseFilter allFilter;
  CaseFilter validFilter;
  CaseFilter selectedFilter;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    allFilter = CaseFilter.fromList(widget.all);
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
      allFilter = CaseFilter.fromList(widget.all);
      validFilter = allFilter;
      selectedFilter = CaseFilter();
      selectedFilter.minPrice = allFilter.minPrice;
      selectedFilter.maxPrice = allFilter.maxPrice;
    });
  }

  recalFilter() {
    setState(() {
      validFilter = CaseFilter.clone(allFilter);
      var tmpFilter = CaseFilter.clone(allFilter);

      //import price
      tmpFilter.minPrice = selectedFilter.minPrice;
      tmpFilter.maxPrice = selectedFilter.maxPrice;

      //filter valid brand
      var tmpList = tmpFilter.filters(widget.all);
      var resultFilter = CaseFilter.fromList(tmpList);
      validFilter.brand = resultFilter.brand;
      selectedFilter.brand =
          selectedFilter.brand.intersection(validFilter.brand);

      //import brand
      tmpFilter.brand = allFilter.brand.intersection(selectedFilter.brand);

      //filter type
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = CaseFilter.fromList(tmpList);
      validFilter.type = resultFilter.type;
      selectedFilter.type = selectedFilter.type.intersection(validFilter.type);

      //import type
      tmpFilter.type = allFilter.type.intersection(selectedFilter.type);

      //Todo: deal with multiple value in one field
      //filter mb support
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = CaseFilter.fromList(tmpList);
      validFilter.mbSize = resultFilter.mbSize;
      selectedFilter.mbSize =
          selectedFilter.mbSize.intersection(validFilter.mbSize);
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
              caseState.setFilter(selectedFilter);
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
            filterChipMaker(
                'Type', allFilter.type, validFilter.type, selectedFilter.type),
            filterChipMaker('Support mainboard size', allFilter.mbSize,
                validFilter.mbSize, selectedFilter.mbSize),
            Container(
              margin: EdgeInsets.all(8),
              child: RaisedButton(
                child: Text('OK'),
                color: Colors.blueAccent,
                onPressed: () {
                  caseState.setFilter(selectedFilter);
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

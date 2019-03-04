import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

import 'package:pc_build/widgets/widgets.dart';

import 'package:pc_build/models/case.dart';

class CaseFilterPage extends StatefulWidget {
  final CaseFilter selectedFilter;
  final List<Case> all;

  CaseFilterPage({Key key, this.selectedFilter, this.all}) : super(key: key);

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
      validFilter.caseBrand = resultFilter.caseBrand;
      selectedFilter.caseBrand =
          selectedFilter.caseBrand.intersection(validFilter.caseBrand);

      //import brand
      tmpFilter.caseBrand =
          allFilter.caseBrand.intersection(selectedFilter.caseBrand);

      //filter type
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = CaseFilter.fromList(tmpList);
      validFilter.caseType = resultFilter.caseType;
      selectedFilter.caseType =
          selectedFilter.caseType.intersection(validFilter.caseType);

      //import type
      tmpFilter.caseType =
          allFilter.caseType.intersection(selectedFilter.caseType);

      //Todo: deal with multiple value in one field
      //filter mb support
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = CaseFilter.fromList(tmpList);
      validFilter.caseMbSize = resultFilter.caseMbSize;
      selectedFilter.caseMbSize =
          selectedFilter.caseMbSize.intersection(validFilter.caseMbSize);
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
            filterChipMaker('Brands', allFilter.caseBrand,
                validFilter.caseBrand, selectedFilter.caseBrand),
            filterChipMaker('Type', allFilter.caseType, validFilter.caseType,
                selectedFilter.caseType),
            filterChipMaker('Support mainboard size', allFilter.caseMbSize,
                validFilter.caseMbSize, selectedFilter.caseMbSize),
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

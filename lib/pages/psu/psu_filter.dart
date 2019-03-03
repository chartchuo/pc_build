import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

import 'package:pc_build/widgets/widgets.dart';

import 'package:pc_build/models/psu.dart';

class PsuFilterPage extends StatefulWidget {
  final PsuFilter selectedFilter;
  final List<Psu> all;

  PsuFilterPage({Key key, this.selectedFilter, this.all}) : super(key: key);

  @override
  _PsuFilterPageState createState() => _PsuFilterPageState();
}

class _PsuFilterPageState extends State<PsuFilterPage> {
  PsuFilter allFilter;
  PsuFilter validFilter;
  PsuFilter selectedFilter;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    allFilter = PsuFilter.fromList(widget.all);
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
      allFilter = PsuFilter.fromList(widget.all);
      validFilter = allFilter;
      selectedFilter = PsuFilter();
      selectedFilter.minPrice = allFilter.minPrice;
      selectedFilter.maxPrice = allFilter.maxPrice;
    });
  }

  recalFilter() {
    setState(() {
      validFilter = PsuFilter.clone(allFilter);
      var tmpFilter = PsuFilter.clone(allFilter);

      //import price
      tmpFilter.minPrice = selectedFilter.minPrice;
      tmpFilter.maxPrice = selectedFilter.maxPrice;

      //filter valid brand
      var tmpList = tmpFilter.filters(widget.all);
      var resultFilter = PsuFilter.fromList(tmpList);
      validFilter.psuBrand = resultFilter.psuBrand;
      selectedFilter.psuBrand =
          selectedFilter.psuBrand.intersection(validFilter.psuBrand);

      //import brand
      tmpFilter.psuBrand =
          allFilter.psuBrand.intersection(selectedFilter.psuBrand);

      //filter valid modular
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = PsuFilter.fromList(tmpList);
      validFilter.psuModular = resultFilter.psuModular;
      selectedFilter.psuModular =
          selectedFilter.psuModular.intersection(validFilter.psuModular);

      //import modular
      tmpFilter.psuModular =
          allFilter.psuModular.intersection(selectedFilter.psuModular);

      //filter valid psuEnergyEff
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = PsuFilter.fromList(tmpList);
      validFilter.psuEnergyEff = resultFilter.psuEnergyEff;
      selectedFilter.psuEnergyEff =
          selectedFilter.psuEnergyEff.intersection(validFilter.psuEnergyEff);

      //import psuEnergyEff
      tmpFilter.psuEnergyEff =
          allFilter.psuEnergyEff.intersection(selectedFilter.psuEnergyEff);

      //filter valid maxpower
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = PsuFilter.fromList(tmpList);
      validFilter.psuMaxPw = resultFilter.psuMaxPw;
      selectedFilter.psuMaxPw =
          selectedFilter.psuMaxPw.intersection(validFilter.psuMaxPw);
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
      body: Container(
        decoration: MyBackgroundDecoration3(),
        child: ListView(
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
            filterChipMaker('Brands', allFilter.psuBrand, validFilter.psuBrand,
                selectedFilter.psuBrand),
            filterChipMaker('Modular', allFilter.psuModular,
                validFilter.psuModular, selectedFilter.psuModular),
            filterChipMaker('Energy Efficiency', allFilter.psuEnergyEff,
                validFilter.psuEnergyEff, selectedFilter.psuEnergyEff),
            filterChipMaker('Power', allFilter.psuMaxPw, validFilter.psuMaxPw,
                selectedFilter.psuMaxPw),
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

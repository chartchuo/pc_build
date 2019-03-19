import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

import 'package:pc_build/widgets/widgets.dart';

import 'package:pc_build/models/psu.dart';

import 'psu_state.dart';

class PsuFilterPage extends StatefulWidget {
  final PsuFilter selectedFilter = psuState.filter;
  final List<Psu> all = psuState.all;

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
      validFilter.brand = resultFilter.brand;
      selectedFilter.brand =
          selectedFilter.brand.intersection(validFilter.brand);

      //import brand
      tmpFilter.brand = allFilter.brand.intersection(selectedFilter.brand);

      //filter valid modular
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = PsuFilter.fromList(tmpList);
      validFilter.modular = resultFilter.modular;
      selectedFilter.modular =
          selectedFilter.modular.intersection(validFilter.modular);

      //import modular
      tmpFilter.modular =
          allFilter.modular.intersection(selectedFilter.modular);

      //filter valid psuEnergyEff
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = PsuFilter.fromList(tmpList);
      validFilter.energyEff = resultFilter.energyEff;
      selectedFilter.energyEff =
          selectedFilter.energyEff.intersection(validFilter.energyEff);

      //import psuEnergyEff
      tmpFilter.energyEff =
          allFilter.energyEff.intersection(selectedFilter.energyEff);

      //filter valid maxpower
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = PsuFilter.fromList(tmpList);
      validFilter.maxPw = resultFilter.maxPw;
      selectedFilter.maxPw =
          selectedFilter.maxPw.intersection(validFilter.maxPw);
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
              psuState.setFilter(selectedFilter);
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
            filterChipMaker('Brands', allFilter.brand, validFilter.brand,
                selectedFilter.brand),
            filterChipMaker('Modular', allFilter.modular, validFilter.modular,
                selectedFilter.modular),
            filterChipMaker('Energy Efficiency', allFilter.energyEff,
                validFilter.energyEff, selectedFilter.energyEff),
            filterChipMaker('Power', allFilter.maxPw, validFilter.maxPw,
                selectedFilter.maxPw),
            Container(
              margin: EdgeInsets.all(8),
              child: RaisedButton(
                child: Text('OK'),
                color: Colors.blueAccent,
                onPressed: () {
                  psuState.setFilter(selectedFilter);
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

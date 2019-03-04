import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

import 'package:pc_build/widgets/widgets.dart';

import 'package:pc_build/models/hdd.dart';

class HddFilterPage extends StatefulWidget {
  final HddFilter selectedFilter;
  final List<Hdd> all;

  HddFilterPage({Key key, this.selectedFilter, this.all}) : super(key: key);

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
      validFilter.hddBrand = resultFilter.hddBrand;
      selectedFilter.hddBrand =
          selectedFilter.hddBrand.intersection(validFilter.hddBrand);

      //import brand
      tmpFilter.hddBrand =
          allFilter.hddBrand.intersection(selectedFilter.hddBrand);

      //filter valid capa
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = HddFilter.fromList(tmpList);
      validFilter.hddCapa = resultFilter.hddCapa;
      selectedFilter.hddCapa =
          selectedFilter.hddCapa.intersection(validFilter.hddCapa);

      //import capa
      tmpFilter.hddCapa =
          allFilter.hddCapa.intersection(selectedFilter.hddCapa);

      //filter rpm
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = HddFilter.fromList(tmpList);
      validFilter.hddRpm = resultFilter.hddRpm;
      selectedFilter.hddRpm =
          selectedFilter.hddRpm.intersection(validFilter.hddRpm);
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
            filterChipMaker('Brands', allFilter.hddBrand, validFilter.hddBrand,
                selectedFilter.hddBrand),
            filterChipMaker('Capacity', allFilter.hddCapa, validFilter.hddCapa,
                selectedFilter.hddCapa),
            filterChipMaker('RPM', allFilter.hddRpm, validFilter.hddRpm,
                selectedFilter.hddRpm),
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

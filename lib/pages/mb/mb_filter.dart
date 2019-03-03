import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

import 'package:pc_build/widgets/widgets.dart';

import 'package:pc_build/models/mb.dart';

class MbFilterPage extends StatefulWidget {
  final MbFilter selectedFilter;
  final List<Mb> all;

  MbFilterPage({Key key, this.selectedFilter, this.all}) : super(key: key);

  @override
  _MbFilterPageState createState() => _MbFilterPageState();
}

class _MbFilterPageState extends State<MbFilterPage> {
  MbFilter allFilter;
  MbFilter validFilter;
  MbFilter selectedFilter;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    allFilter = MbFilter.fromList(widget.all);
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
      allFilter = MbFilter.fromList(widget.all);
      validFilter = allFilter;
      selectedFilter = MbFilter();
      selectedFilter.minPrice = allFilter.minPrice;
      selectedFilter.maxPrice = allFilter.maxPrice;
    });
  }

  recalFilter() {
    setState(() {
      validFilter = MbFilter.clone(allFilter);
      var tmpFilter = MbFilter.clone(allFilter);

      //import price
      tmpFilter.minPrice = selectedFilter.minPrice;
      tmpFilter.maxPrice = selectedFilter.maxPrice;

      //filter valid brand
      var tmpList = tmpFilter.filters(widget.all);
      var resultFilter = MbFilter.fromList(tmpList);
      validFilter.mbBrand = resultFilter.mbBrand;
      selectedFilter.mbBrand =
          selectedFilter.mbBrand.intersection(validFilter.mbBrand);

      //import brand
      tmpFilter.mbBrand =
          allFilter.mbBrand.intersection(selectedFilter.mbBrand);

      //filter valid form factor
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = MbFilter.fromList(tmpList);
      validFilter.mbFactor = resultFilter.mbFactor;
      selectedFilter.mbFactor =
          selectedFilter.mbFactor.intersection(validFilter.mbFactor);

      //import form factor
      tmpFilter.mbFactor =
          allFilter.mbFactor.intersection(selectedFilter.mbFactor);

      //filter valid socket
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = MbFilter.fromList(tmpList);
      validFilter.mbSocket = resultFilter.mbSocket;
      selectedFilter.mbSocket =
          selectedFilter.mbSocket.intersection(validFilter.mbSocket);

      //import mbSocket
      tmpFilter.mbSocket =
          allFilter.mbSocket.intersection(selectedFilter.mbSocket);

      //filter valid Chipset
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = MbFilter.fromList(tmpList);
      validFilter.mbChipset = resultFilter.mbChipset;
      selectedFilter.mbChipset =
          selectedFilter.mbChipset.intersection(validFilter.mbChipset);
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
            filterChipMaker('Brands', allFilter.mbBrand, validFilter.mbBrand,
                selectedFilter.mbBrand),
            filterChipMaker('Form factor', allFilter.mbFactor,
                validFilter.mbFactor, selectedFilter.mbFactor),
            filterChipMaker('Socket', allFilter.mbSocket, validFilter.mbSocket,
                selectedFilter.mbSocket),
            filterChipMaker('Chipset', allFilter.mbChipset,
                validFilter.mbChipset, selectedFilter.mbChipset),
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

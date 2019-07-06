import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as rs;

import 'package:pc_build/widgets/widgets.dart';

import 'package:pc_build/models/mb.dart';

import 'mb_state.dart';

class MbFilterPage extends StatefulWidget {
  final MbFilter selectedFilter = mbState.filter;
  final List<Mb> all = mbState.all;

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
      validFilter.brand = resultFilter.brand;
      selectedFilter.brand =
          selectedFilter.brand.intersection(validFilter.brand);

      //import brand
      tmpFilter.brand = allFilter.brand.intersection(selectedFilter.brand);

      //filter valid form factor
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = MbFilter.fromList(tmpList);
      validFilter.factor = resultFilter.factor;
      selectedFilter.factor =
          selectedFilter.factor.intersection(validFilter.factor);

      //import form factor
      tmpFilter.factor = allFilter.factor.intersection(selectedFilter.factor);

      //filter valid socket
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = MbFilter.fromList(tmpList);
      validFilter.socket = resultFilter.socket;
      selectedFilter.socket =
          selectedFilter.socket.intersection(validFilter.socket);

      //import mbSocket
      tmpFilter.socket = allFilter.socket.intersection(selectedFilter.socket);

      //filter valid Chipset
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = MbFilter.fromList(tmpList);
      validFilter.chipset = resultFilter.chipset;
      selectedFilter.chipset =
          selectedFilter.chipset.intersection(validFilter.chipset);
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
              mbState.setFilter(selectedFilter);
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
            filterChipMaker('Form factor', allFilter.factor, validFilter.factor,
                selectedFilter.factor),
            filterChipMaker('Socket', allFilter.socket, validFilter.socket,
                selectedFilter.socket),
            filterChipMaker('Chipset', allFilter.chipset, validFilter.chipset,
                selectedFilter.chipset),
            Container(
              margin: EdgeInsets.all(8),
              child: RaisedButton(
                child: Text('OK'),
                color: Colors.blueAccent,
                onPressed: () {
                  mbState.setFilter(selectedFilter);
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

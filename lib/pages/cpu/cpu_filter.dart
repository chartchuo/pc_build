import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

import 'package:pc_build/widgets/widgets.dart';

import 'package:pc_build/models/cpu.dart';

class CpuFilterPage extends StatefulWidget {
  final CpuFilter selectedFilter;
  final List<Cpu> allCpus;

  CpuFilterPage({Key key, this.selectedFilter, this.allCpus}) : super(key: key);

  @override
  _CpuFilterPageState createState() => _CpuFilterPageState();
}

class _CpuFilterPageState extends State<CpuFilterPage> {
  CpuFilter allFilter;
  CpuFilter validFilter;
  CpuFilter selectedFilter;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    allFilter = CpuFilter.fromList(widget.allCpus);
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
      allFilter = CpuFilter.fromList(widget.allCpus);
      validFilter = allFilter;
      selectedFilter = CpuFilter();
      selectedFilter.minPrice = allFilter.minPrice;
      selectedFilter.maxPrice = allFilter.maxPrice;
    });
  }

  recalFilter() {
    setState(() {
      validFilter = CpuFilter.clone(allFilter);
      var tmpFilter = CpuFilter.clone(allFilter);

      //import price
      tmpFilter.minPrice = selectedFilter.minPrice;
      tmpFilter.maxPrice = selectedFilter.maxPrice;

      //filter valid brand
      var tmpList = tmpFilter.filters(widget.allCpus);
      var resultFilter = CpuFilter.fromList(tmpList);
      validFilter.cpuBrand = resultFilter.cpuBrand;
      selectedFilter.cpuBrand =
          selectedFilter.cpuBrand.intersection(validFilter.cpuBrand);

      //import brand
      tmpFilter.cpuBrand =
          allFilter.cpuBrand.intersection(selectedFilter.cpuBrand);

      //filter valid socket
      tmpList = tmpFilter.filters(widget.allCpus);
      resultFilter = CpuFilter.fromList(tmpList);
      validFilter.cpuSocket = resultFilter.cpuSocket;
      selectedFilter.cpuSocket =
          selectedFilter.cpuSocket.intersection(validFilter.cpuSocket);

      //import cpuSocket
      tmpFilter.cpuSocket =
          allFilter.cpuSocket.intersection(selectedFilter.cpuSocket);

      //filter valid series
      tmpList = tmpFilter.filters(widget.allCpus);
      resultFilter = CpuFilter.fromList(tmpList);
      validFilter.cpuSeries = resultFilter.cpuSeries;
      selectedFilter.cpuSeries =
          selectedFilter.cpuSeries.intersection(validFilter.cpuSeries);
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
            filterChipMaker('Brands', allFilter.cpuBrand, validFilter.cpuBrand,
                selectedFilter.cpuBrand),
            filterChipMaker('Socket', allFilter.cpuSocket,
                validFilter.cpuSocket, selectedFilter.cpuSocket),
            filterChipMaker(
              'Series',
              allFilter.cpuSeries,
              validFilter.cpuSeries,
              selectedFilter.cpuSeries,
            ),
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
            print(str);
            setState(() {
              selected.add(str);
              recalFilter();
            });
          },
          onDeselected: (str) {
            print(str);
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

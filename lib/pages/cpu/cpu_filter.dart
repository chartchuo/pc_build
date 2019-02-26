import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

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
    allFilter = CpuFilter.fromVgas(widget.allCpus);
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
      allFilter = CpuFilter.fromVgas(widget.allCpus);
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
      var tmpVgas = tmpFilter.filters(widget.allCpus);
      var resultFilter = CpuFilter.fromVgas(tmpVgas);
      validFilter.cpuBrand = resultFilter.cpuBrand;
      selectedFilter.cpuBrand =
          selectedFilter.cpuBrand.intersection(validFilter.cpuBrand);

      //import brand
      tmpFilter.cpuBrand =
          allFilter.cpuBrand.intersection(selectedFilter.cpuBrand);

      //filter valid socket
      tmpVgas = tmpFilter.filters(widget.allCpus);
      resultFilter = CpuFilter.fromVgas(tmpVgas);
      validFilter.cpuSocket = resultFilter.cpuSocket;
      selectedFilter.cpuSocket =
          selectedFilter.cpuSocket.intersection(validFilter.cpuSocket);

      //import cpuSocket
      tmpFilter.cpuSocket =
          allFilter.cpuSocket.intersection(selectedFilter.cpuSocket);

      //filter valid series
      tmpVgas = tmpFilter.filters(widget.allCpus);
      resultFilter = CpuFilter.fromVgas(tmpVgas);
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
      body: ListView(
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
          ListTile(
            title: Text('Brands'),
            trailing: clearAllMaker(selectedFilter.cpuBrand),
          ),
          filterChipMaker(allFilter.cpuBrand, validFilter.cpuBrand,
              selectedFilter.cpuBrand),
          ListTile(
            title: Text('Socket'),
            trailing: clearAllMaker(selectedFilter.cpuSocket),
          ),
          filterChipMaker(allFilter.cpuSocket, validFilter.cpuSocket,
              selectedFilter.cpuSocket),
          ListTile(
            title: Text('Series'),
            trailing: clearAllMaker(selectedFilter.cpuSeries),
          ),
          filterChipMaker(
            allFilter.cpuSeries,
            validFilter.cpuSeries,
            selectedFilter.cpuSeries,
          ),
        ],
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

  //Todo will extract to stateful widget as custom UI
  Widget filterChipMaker(
      Set<String> all, Set<String> valid, Set<String> selected,
      {bool showInvalid = false}) {
    List<String> allList = all.toList()..sort();
    if (!showInvalid) allList.removeWhere((v) => !valid.contains(v));
    return Container(
      margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Wrap(
        children: allList.map((b) {
          return FilterChip(
            label: Text(b),
            selected: selected.contains(b),
            onSelected: !valid.contains(b)
                ? null
                : (bool sel) {
                    setState(() {
                      if (sel) {
                        selected.add(b);
                        recalFilter();
                      } else {
                        selected.remove(b);
                        recalFilter();
                      }
                    });
                  },
          );
        }).toList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pc_build/models/vga.dart';

class VgaFilterPage extends StatefulWidget {
  final VgaFilter vgaFilter;

  VgaFilterPage({Key key, this.vgaFilter}) : super(key: key);

  @override
  _VgaFilterPageState createState() => _VgaFilterPageState();
}

class _VgaFilterPageState extends State<VgaFilterPage> {
  VgaFilter filter;

  @override
  void initState() {
    super.initState();
    filter = widget.vgaFilter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Back'),
          onPressed: () {
            print('in');
            print(filter.vgaBrands);
            filter.vgaBrands = ['GIGABYTE'];
            Navigator.pop(context, filter);
          },
        ),
      ),
    );
  }
}

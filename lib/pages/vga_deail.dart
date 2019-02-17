import 'package:flutter/material.dart';

class VgaDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Container(
        child: RaisedButton(
          child: Text('Back'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}

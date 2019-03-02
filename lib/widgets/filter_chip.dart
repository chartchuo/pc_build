import 'package:flutter/material.dart';

class FilterChips extends StatelessWidget {
  final Set<String> all, valid, selected;
  final showInvalid;
  final ValueChanged<String> onSelected, onDeselected;

  FilterChips({
    Key key,
    this.all,
    this.valid,
    this.selected,
    this.showInvalid = false,
    this.onSelected,
    this.onDeselected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> allList = all.toList()..sort();
    if (!showInvalid) allList.removeWhere((v) => !valid.contains(v));
    return Container(
      margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Wrap(
        children: allList.map((b) {
          return FilterChip(
            // backgroundColor: Colors.black12,
            label: Text(b),
            selected: selected.contains(b),
            onSelected: !valid.contains(b)
                ? null
                : (bool sel) {
                    if (sel)
                      onSelected(b);
                    else
                      onDeselected(b);
                  },
          );
        }).toList(),
      ),
    );
  }
}

class Part {
  int id;
  String brand;
  String model;
  String picture;
  String path;
  int price;
}

enum PartSort {
  latest,
  lowPrice,
  highPrice,
}

List<Part> partSearchMap(List<Part> e, String str) {
  if (str != '')
    e = e.where((v) {
      if (v.brand.toLowerCase().contains(str.toLowerCase())) return true;
      if (v.model.toLowerCase().contains(str.toLowerCase())) return true;
      return false;
    }).toList();
  return e;
}

List<Part> partSortMap(List<Part> e, PartSort s) {
  switch (s) {
    case PartSort.lowPrice:
      e.sort((a, b) => a.price - b.price);
      break;
    case PartSort.highPrice:
      e.sort((a, b) => b.price - a.price);
      break;
    case PartSort.latest:
      e.sort((a, b) => b.id - a.id);
      break;
    default:
  }
  return e;
}

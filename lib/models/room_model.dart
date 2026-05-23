class RoomModel {
  String name;
  double width;
  double length;

  RoomModel({
    this.name = '',
    this.width = 0.0,
    this.length = 0.0,
  });

  double get area => width * length;
}

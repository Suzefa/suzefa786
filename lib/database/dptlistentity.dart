import 'package:floor/floor.dart';

@entity
class DptListEntity{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  String dptName;

  DptListEntity({this.id,required this.dptName});

}
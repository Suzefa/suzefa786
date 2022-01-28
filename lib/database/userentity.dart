import 'package:floor/floor.dart';

@entity
class UserEntity{
  @PrimaryKey(autoGenerate:true)
  final int? id;

  String name;

  String email;

  String pass;

  String rollNo;

  String dpt;

  UserEntity({
      this.id,
        required this.name,
        required this.email,
        required this.pass,
        required this.dpt,
        required this.rollNo
      });
}
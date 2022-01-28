import 'package:checkasync/database/dptlistdao.dart';
import 'package:checkasync/database/dptlistentity.dart';
import 'package:checkasync/database/userdao.dart';
import 'package:checkasync/database/userentity.dart';
import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart'as sqflite;

part 'psschooldb.g.dart';

@Database(version: 1, entities:[UserEntity,DptListEntity])
abstract class PsSchoolDB extends FloorDatabase{
  UserDao get userDao;
  DptListDao get dptDao;
}

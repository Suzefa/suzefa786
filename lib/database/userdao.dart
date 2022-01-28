import 'package:checkasync/database/userentity.dart';
import 'package:floor/floor.dart';

@dao
abstract class UserDao{

  @insert
  Future<List<int>> addUser(List<UserEntity> ue);

  @update
  Future<void> updateUser(UserEntity ue);

  @Query('SELECT * FROM UserEntity')
  Future<List<UserEntity>> getAllUser();

  @Query('SELECT * FROM UserEntity WHERE email=:_email')
  Future<UserEntity?> getUserByEmail(String _email);

  @Query("SELECT * FROM UserEntity WHERE dpt=:dept")
  Future<List<UserEntity>> getUserDptWise(String dept);

  @Query('SELECT * FROM UserEntity WHERE id=:id')
  Future<UserEntity?> getSingleUser(int id);

  @delete
  Future<void> deleteUser(UserEntity ue);

}
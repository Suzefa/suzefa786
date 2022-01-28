
import 'package:checkasync/database/dptlistentity.dart';
import 'package:floor/floor.dart';

@dao
abstract class DptListDao{

  @insert
  Future<List<int>> addDpt(List<DptListEntity> dlEntity);

  @Query('SELECT * FROM DptListEntity')
  Future<List<DptListEntity>> getAllDpt();

  @Query('SELECT * FROM DptListEntity WHERE newDpt IS NOT :dpt')
  Future<List<DptListEntity>> getAllDptExcept(String dpt);

  @Query('SELECT * FROM DptListEntity WHERE newDpt=:oldDpt')
  Future<DptListEntity?> getOnlyDpt(String oldDpt);

  @Query('SELECT * FROM DptListEntity WHERE id=:_id')
  Future<DptListEntity?> getDptFromId(int _id);

  @update
  Future<void> updateDpt(DptListEntity upDlEntity);

  @delete
  Future<void> deleteDPt(DptListEntity dDlEntity);

}
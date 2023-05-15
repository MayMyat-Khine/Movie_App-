import 'package:hive/hive.dart';
import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/persistence/hive_constants.dart';

abstract class ActorDao {
  void saveActorList(List<ActorVO> actorList);
  List<ActorVO> getActorList();
}

import 'package:hive/hive.dart';
import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/persistence/daos/actor_dao.dart';
import 'package:movie_app_ui/persistence/hive_constants.dart';

class ActorDaoImpl extends ActorDao {
  static final ActorDaoImpl _singleton = ActorDaoImpl._internal();

  factory ActorDaoImpl() {
    return _singleton;
  }

  ActorDaoImpl._internal();

  @override
  void saveActorList(List<ActorVO> actorList) async {
    Map<int, ActorVO> actorMap = Map.fromIterable(actorList,
        key: (actor) => actor.id, value: (actor) => actor);
    await getActorBox().putAll(actorMap);
  }

  @override
  List<ActorVO> getActorList() {
    return getActorBox().values.toList();
  }

  Box<ActorVO> getActorBox() {
    return Hive.box<ActorVO>(BOX_NAME_ACTOR_VO);
  }
}

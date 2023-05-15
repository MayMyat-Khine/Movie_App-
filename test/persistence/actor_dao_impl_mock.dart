import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/persistence/daos/actor_dao.dart';
import 'package:movie_app_ui/persistence/daos/impls/actor_dao_imple.dart';

class ActorDaoImplMock extends ActorDao {
  Map<int, ActorVO> actorListFromDatabaseMock = {};
  @override
  List<ActorVO> getActorList() {
    return actorListFromDatabaseMock.values.toList();
  }

  @override
  void saveActorList(List<ActorVO> actorList) {
    actorList.forEach((actor) {
      actorListFromDatabaseMock[actor.id ?? 0] = actor;
    });
  }
}

import 'package:hive/hive.dart';
import 'package:programming_memo_for_mac_app/infra/persistence/entities/persistent_template.dart';


part 'persistent_memo.g.dart';

@HiveType(typeId: PersistenceTypeId.memoTypeId)
class PersistentMemo implements DataWithId {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime createdAt;

  @HiveField(2)
  DateTime lastModifiedAt;

  @HiveField(3)
  DateTime lastOpenedAt;

  @HiveField(4)
  DateTime? willDeleteAt;

  @HiveField(5)
  String title;

  @HiveField(6)
  String content;

  PersistentMemo({
    required this.id,
    required this.createdAt,
    required this.lastModifiedAt,
    required this.lastOpenedAt,
    required this.willDeleteAt,
    required this.title,
    required this.content
  });

  @override
  String getId() => id;
}
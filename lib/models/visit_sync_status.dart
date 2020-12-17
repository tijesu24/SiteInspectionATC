import 'package:json_annotation/json_annotation.dart';

/// This allows the `VisitSyncStatus` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'visit_sync_status.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class VisitSyncStatus {
  static const NOTSYNCED = 1;
  static const SYNCING = 2;
  static const UPLOADED = 3;

  Map<String, bool> syncMap = {};

  VisitSyncStatus();

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory VisitSyncStatus.fromJson(Map<String, dynamic> json) =>
      _$VisitSyncStatusFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$VisitSyncStatusToJson(this);

  void readFromFile() {}

  void savetoFile() {}
}

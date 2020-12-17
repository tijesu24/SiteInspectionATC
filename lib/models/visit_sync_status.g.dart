// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_sync_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitSyncStatus _$VisitSyncStatusFromJson(Map<String, dynamic> json) {
  return VisitSyncStatus()
    ..syncMap = (json['syncMap'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as bool),
    );
}

Map<String, dynamic> _$VisitSyncStatusToJson(VisitSyncStatus instance) =>
    <String, dynamic>{
      'syncMap': instance.syncMap,
    };

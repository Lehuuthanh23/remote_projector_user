import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

import 'camp_profile_model.dart';
import 'time_run_model.dart';

part 'camp_model.g.dart';

@JsonSerializable()
class CampModel {
  @JsonKey(name: 'campaign_id')
  String? campaignId;

  @JsonKey(name: 'campaign_name')
  String? campaignName;

  String? status;

  @JsonKey(name: 'video_id')
  String? videoId;

  @JsonKey(name: 'from_date')
  String? fromDate;

  @JsonKey(name: 'to_date')
  String? toDate;

  @JsonKey(name: 'from_time')
  String? fromTime;

  @JsonKey(name: 'to_time')
  String? toTime;

  @JsonKey(name: 'days_of_week')
  String? daysOfWeek;

  @JsonKey(name: 'video_type')
  String? videoType;

  @JsonKey(name: 'url_youtobe')
  String? urlYoutube;

  @JsonKey(name: 'customer_id')
  String? customerId;

  @JsonKey(name: 'url_usp')
  String? urlUSP;

  @JsonKey(name: 'computer_id')
  String? computerId;

  @JsonKey(name: 'id_dir')
  String? idDir;

  @JsonKey(name: 'id_computer')
  String? idComputer;

  @JsonKey(name: 'video_duration')
  String? videoDuration;

  @JsonKey(name: 'approved_yn')
  String? approvedYn;

  @JsonKey(includeFromJson: false, includeToJson: false)
  Color? colorChart;

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<TimeRunModel>? listTimeRun;

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<CampProfileModel>? listCampProfile;

  CampModel({
    this.campaignId,
    this.campaignName,
    this.status,
    this.videoId,
    this.fromDate,
    this.toDate,
    this.fromTime,
    this.toTime,
    this.daysOfWeek,
    this.videoType,
    this.urlYoutube,
    this.urlUSP,
    this.customerId,
    this.computerId,
    this.idDir,
    this.idComputer,
    this.listTimeRun,
    this.listCampProfile,
    this.colorChart,
    this.videoDuration,
    this.approvedYn,
  });

  factory CampModel.fromJson(Map<String, dynamic> json) =>
      _$CampModelFromJson(json);
  Map<String, dynamic> toJson() => _$CampModelToJson(this);

  CampModel cloningItem() {
    return CampModel(
      status: status,
      videoId: videoId,
      fromDate: fromDate,
      toDate: toDate,
      fromTime: fromTime,
      toTime: toTime,
      daysOfWeek: daysOfWeek,
      videoType: videoType,
      customerId: customerId,
      idDir: idDir,
      listTimeRun: listTimeRun,
      videoDuration: videoDuration,
    );
  }
}

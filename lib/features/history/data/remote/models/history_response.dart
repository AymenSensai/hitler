import 'package:json_annotation/json_annotation.dart';
import 'package:stocks_app/features/history/data/remote/models/history_model.dart';

part 'history_response.g.dart';

@JsonSerializable()
class HistoryResponse {
  final String message;
  final List<HistoryModel> data;

  HistoryResponse({
    required this.message,
    required this.data,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryResponseToJson(this);
}

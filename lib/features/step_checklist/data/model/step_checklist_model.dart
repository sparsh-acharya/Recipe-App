// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StepChecklistModel {
  final int stepNo;
  final String stepTask;

  StepChecklistModel({required this.stepNo, required this.stepTask});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stepNo': stepNo,
      'stepTask': stepTask,
    };
  }

  factory StepChecklistModel.fromMap(Map<String, dynamic> map) {
    return StepChecklistModel(
      stepNo: map['stepNo'] as int,
      stepTask: map['stepTask'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StepChecklistModel.fromJson(String source) => StepChecklistModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

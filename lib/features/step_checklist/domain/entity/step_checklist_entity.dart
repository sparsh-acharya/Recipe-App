// ignore_for_file: public_member_api_docs, sort_constructors_first
class StepChecklistEntity {
  final int stepNo;
  final String stepTask;
  final bool isChecked;

  StepChecklistEntity({required this.stepNo, required this.stepTask, this.isChecked = false});


  StepChecklistEntity copyWith({
    int? stepNo,
    String? stepName,
    bool? isChecked,
  }) {
    return StepChecklistEntity(
      stepNo: stepNo ?? this.stepNo,
      stepTask: stepName ?? this.stepTask,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}

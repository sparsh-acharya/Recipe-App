import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/Colors/app_colors.dart';
import 'package:recipe_app/core/widgets/Error_screen.dart';
import 'package:recipe_app/core/widgets/app_button.dart';
import 'package:recipe_app/core/widgets/loading_screen.dart';
import 'package:recipe_app/features/equipment_checklist/presentation/bloc/equ_checklist_bloc.dart';
import 'package:recipe_app/features/ingredients_checklist/presentation/bloc/ing_checklist_bloc.dart';
import 'package:recipe_app/features/step_checklist/presentation/bloc/step_checklist_bloc.dart';
import 'package:recipe_app/features/step_checklist/presentation/pages/step_checklist_page.dart';

class EquChecklistPage extends StatefulWidget {
  final int id;
  const EquChecklistPage({super.key, required this.id});

  @override
  State<EquChecklistPage> createState() => _EquChecklistPageState();
}

class _EquChecklistPageState extends State<EquChecklistPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EquChecklistBloc, EquChecklistState>(
      builder: (context, state) {
        if (state is EquChecklistLoadingState) {
          return LoadingScreen();
        } else if (state is EquChecklistErrorState) {
          return ErrorScreen(message: state.message);
        } else if (state is EquChecklistLoadedState) {
          return Scaffold(
            backgroundColor: AppColors.primaryBackgroundColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              title: Text(
                'Equipment Checklist',
                style: TextStyle(color: AppColors.primary),
              ),
              elevation: 0,
              centerTitle: true,
            ),
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${state.completed}/${state.total}',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Equipments Collected',
                        style: TextStyle(color: AppColors.primary),
                      ),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(
                        value:
                            state.total > 0 ? state.completed / state.total : 0,
                        backgroundColor: AppColors.primaryBackgroundColor,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        minHeight: 8,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.equipmentList.length,
                    itemBuilder: (context, index) {
                      final equipment = state.equipmentList[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: AppColors.secondary),
                        ),
                        child: CheckboxListTile(
                          tileColor: AppColors.secondaryBackgroundColor,
                          title: Text(
                            equipment.name,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          value: equipment.isChecked,
                          activeColor: AppColors.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          onChanged: (bool? value) {
                            context.read<EquChecklistBloc>().add(
                              ToggleEquChecklistEvent(index: index),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            bottomNavigationBar: AppButton(
              onPressed: () {
                if (state.completed == state.total) {
                  context.read<StepChecklistBloc>().add(
                    FetchStepsByIdEvent(id: widget.id),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StepChecklistPage(id: widget.id),
                    ),
                  );
                }
              },
              text: 'Next',
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

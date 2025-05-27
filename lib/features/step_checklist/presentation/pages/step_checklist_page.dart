import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/Colors/app_colors.dart';
import 'package:recipe_app/core/widgets/app_button.dart';
import 'package:recipe_app/core/widgets/error_screen.dart';
import 'package:recipe_app/core/widgets/loading_screen.dart';
import 'package:recipe_app/features/ingredient_selection/presentation/bloc/ingredient_bloc.dart';
import 'package:recipe_app/features/ingredient_selection/presentation/pages/ingredient_selection_page.dart';
import 'package:recipe_app/features/step_checklist/presentation/bloc/step_checklist_bloc.dart';

class StepChecklistPage extends StatefulWidget {
  final int id;
  const StepChecklistPage({super.key, required this.id});

  @override
  State<StepChecklistPage> createState() => _StepChecklistPageState();
}

class _StepChecklistPageState extends State<StepChecklistPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepChecklistBloc, StepChecklistState>(
      builder: (context, state) {
        if (state is StepChecklistLoadingState) {
          return LoadingScreen();
        } else if (state is StepChecklistErrorState) {
          return ErrorScreen(message: state.message);
        } else if (state is StepChecklistLoadedState) {
          return Scaffold(
            backgroundColor: AppColors.primaryBackgroundColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              title: Text(
                'Ingredients Checklist',
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
                        '${state.completedSteps}/${state.totalSteps}',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ingredients Completed',
                        style: TextStyle(color: AppColors.primary),
                      ),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(
                        value:
                            state.totalSteps > 0
                                ? state.completedSteps / state.totalSteps
                                : 0,
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
                    itemCount: state.steps.length,
                    itemBuilder: (context, index) {
                      final step = state.steps[index];
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
                            step.stepNo.toString(),
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            step.stepTask,
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: step.isChecked,
                          activeColor: AppColors.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          onChanged: (bool? value) {
                            context.read<StepChecklistBloc>().add(
                              ToggleStepChecklistEvent(index: index),
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
                if (state.completedSteps == state.totalSteps) {
                  context.read<IngredientBloc>().add(LoadIngredientsEvent());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IngredientSelectionPage(),
                    ),
                  );
                }
              },
              text: 'Finish',
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

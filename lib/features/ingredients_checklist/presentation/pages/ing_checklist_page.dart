import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/Colors/app_colors.dart';
import 'package:recipe_app/core/widgets/Error_screen.dart';
import 'package:recipe_app/core/widgets/app_button.dart';
import 'package:recipe_app/core/widgets/loading_screen.dart';
import 'package:recipe_app/features/equipment_checklist/presentation/bloc/equ_checklist_bloc.dart';
import 'package:recipe_app/features/equipment_checklist/presentation/pages/equ_checklist_page.dart';
import 'package:recipe_app/features/ingredients_checklist/presentation/bloc/ing_checklist_bloc.dart';

class IngChecklistPage extends StatefulWidget {
  final int id;
  const IngChecklistPage({super.key, required this.id});

  @override
  State<IngChecklistPage> createState() => _IngChecklistPageState();
}

class _IngChecklistPageState extends State<IngChecklistPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IngChecklistBloc, IngChecklistState>(
      builder: (context, state) {
        if (state is IngChecklistLoadingState) {
          return const LoadingScreen();
        } else if (state is IngChecklistErrorState) {
          return ErrorScreen(message: state.message);
        } else if (state is IngChecklistloadedState) {
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
                        '${state.completedIngredients}/${state.totalIngredients}',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ingredients Collected',
                        style: TextStyle(color: AppColors.primary),
                      ),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(
                        value:
                            state.totalIngredients > 0
                                ? state.completedIngredients /
                                    state.totalIngredients
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
                    itemCount: state.ingredientList.length,
                    itemBuilder: (context, index) {
                      final ingredient = state.ingredientList[index];
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
                            ingredient.name,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${ingredient.value.toStringAsFixed(2)} ${ingredient.unit}',
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: ingredient.isChecked,
                          activeColor: AppColors.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          onChanged: (bool? value) {
                            context.read<IngChecklistBloc>().add(
                              ToggleIngChecklistEvent(index: index),
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
                if (state.completedIngredients == state.totalIngredients) {
                  context.read<EquChecklistBloc>().add(
                    FetchEquByIdEvent(id: widget.id),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EquChecklistPage(id: widget.id),
                    ),
                  );
                }
              },
              text: 'Next',
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/Colors/app_colors.dart';
import 'package:recipe_app/core/widgets/Error_screen.dart';
import 'package:recipe_app/core/widgets/loading_screen.dart';
import 'package:recipe_app/core/widgets/loading_screen.dart';
import 'package:recipe_app/features/ingredient_selection/presentation/bloc/ingredient_bloc.dart';
import 'package:recipe_app/features/ingredient_selection/presentation/widget/category_selection_widget.dart';
import 'package:recipe_app/features/recipe_selection/presentation/bloc/recipe_list_bloc.dart';
import 'package:recipe_app/features/recipe_selection/presentation/pages/recipe_selection_page.dart';

import '../../domain/entity/ingredient_entity.dart';

class IngredientSelectionPage extends StatefulWidget {
  const IngredientSelectionPage({super.key});

  @override
  State<IngredientSelectionPage> createState() =>
      _IngredientSelectionPageState();
}

class _IngredientSelectionPageState extends State<IngredientSelectionPage> {
  @override
  void initState() {
    super.initState();

    context.read<IngredientBloc>().add(LoadIngredientsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IngredientBloc, IngredientState>(
      builder: (context, state) {
        // if(state is IngredientLoading){
        //   return LoadingScreen();
        // }
        // else if(state is IngredientError){
        //   return ErrorScreen(message: state.message);
        // }
        if (state is IngredientLoaded) {
          return CategoryPageWidget(ingredients: state.ingredients);
        }
        return CircularProgressIndicator();
      },
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Choose Ingredients"),
    //     actions: [
    //       IconButton(
    //         icon: const Icon(Icons.clear_all),
    //         onPressed: () {
    //           context.read<IngredientBloc>().add(ClearSelectionEvent());
    //         },
    //       ),
    //     ],
    //   ),
    //   body: BlocBuilder<IngredientBloc, IngredientState>(
    //     builder: (context, state) {
    //       if (state is IngredientLoading) {
    //         return const Center(child: CircularProgressIndicator());
    //       } else if (state is IngredientLoaded) {
    //         final grouped = groupByCategory(state.ingredients);
    //         return ListView(
    //           children: grouped.entries.map((entry) {
    //             return ExpansionTile(
    //               title: Text(entry.key),
    //               children: entry.value
    //                   .map((e) => CheckboxListTile(
    //                         title: Text(e.name),
    //                         value: state.selectedIngredients.contains(e),
    //                         onChanged: (_) {
    //                           context.read<IngredientBloc>().add(
    //                                 ToggleIngredientEvent(e),
    //                               );
    //                         },
    //                       ))
    //                   .toList(),
    //             );
    //           }).toList(),
    //         );
    //       } else if (state is IngredientError) {
    //         return Center(child: Text(state.message));
    //       }
    //       return const SizedBox();
    //     },
    //   ),
    //   floatingActionButton: BlocBuilder<IngredientBloc, IngredientState>(
    //     builder: (context, state) {
    //       return FloatingActionButton.extended(
    //         onPressed: () {
    //           if (state is IngredientLoaded) {
    //             final selected = state.selectedIngredients;
    //             print('Selected ingredients: ${selected.map((e) => e.name).join(', ')}');
    //             context.read<RecipeListBloc>().add(FetchRecipesByIngredientsEvent(selected));
    //             Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeSelectionPage()));
    //           }
    //         },
    //         label: const Text("Find Recipes"),
    //         icon: const Icon(Icons.search),
    //       );
    //     },
    //   ),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    // );
  }
}

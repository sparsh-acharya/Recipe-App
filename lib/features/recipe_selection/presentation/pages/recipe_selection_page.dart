import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/widgets/error_screen.dart';
import 'package:recipe_app/core/widgets/loading_screen.dart';
import 'package:recipe_app/features/recipe_detail/presentation/bloc/recipe_detail_bloc.dart';
import 'package:recipe_app/features/recipe_detail/presentation/pages/recipe_detail_page.dart';
import 'package:recipe_app/features/recipe_selection/presentation/bloc/recipe_list_bloc.dart';
import 'package:recipe_app/features/recipe_selection/presentation/widgets/recipe_list_widget.dart';

class RecipeSelectionPage extends StatefulWidget {
  const RecipeSelectionPage({super.key});

  @override
  State<RecipeSelectionPage> createState() => _RecipeSelectionPageState();
}

class _RecipeSelectionPageState extends State<RecipeSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeListBloc, RecipeListState>(
      builder: (context, state) {
        if (state is RecipeListLoading) {
          return LoadingScreen();
        } else if (state is RecipeListError) {
          return ErrorScreen(message: state.message);
        } else if (state is RecipeListLoaded) {
          return RecipeListWidget();
        }
        return const SizedBox.shrink();
      },
    );
  }
}

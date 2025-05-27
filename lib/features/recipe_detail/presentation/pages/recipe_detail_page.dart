import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/Colors/app_colors.dart';
import 'package:recipe_app/core/widgets/app_button.dart';
import 'package:recipe_app/core/widgets/error_screen.dart';
import 'package:recipe_app/core/widgets/loading_screen.dart';
import 'package:recipe_app/features/ingredients_checklist/presentation/bloc/ing_checklist_bloc.dart';
import 'package:recipe_app/features/ingredients_checklist/presentation/pages/ing_checklist_page.dart';
import 'package:recipe_app/features/recipe_detail/presentation/bloc/recipe_detail_bloc.dart';

class RecipeDetailPage extends StatefulWidget {
  const RecipeDetailPage({super.key});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
      builder: (context, state) {
        if (state is RecipeDataLoadingState) {
          return LoadingScreen();
        } else if (state is RecipeDataErrorState) {
          return ErrorScreen(message: state.message);
        } else if (state is RecipeDataLoadedState) {
          final recipe = state.detailEntity;
          return Scaffold(
            backgroundColor: AppColors.primaryBackgroundColor,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 300,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(recipe.image, fit: BoxFit.cover),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    centerTitle: true,
                    title: Text(
                      recipe.title,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildInfoCard(
                          title: 'Source',
                          content: recipe.sourceName,
                          icon: Icons.restaurant,
                        ),
                        SizedBox(height: 12),
                        buildInfoCard(
                          title: 'Ready In',
                          content: '${recipe.readyInMinutes} minutes',
                          icon: Icons.timer,
                        ),
                        SizedBox(height: 12),
                        buildInfoCard(
                          title: 'Dish Types',
                          content: recipe.dishTypes.join(', '),
                          icon: Icons.category,
                        ),
                        SizedBox(height: 12),
                        buildInfoCard(
                          title: 'Spoonacular ID',
                          content: '${recipe.id}',
                          icon: Icons.tag,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: AppButton(
              onPressed: () {
                context.read<IngChecklistBloc>().add(
                  FetchIngredientsByIdEvent(id: recipe.id),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IngChecklistPage(id: recipe.id),
                  ),
                );
              },
              text: 'Start Cooking',
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget buildInfoCard({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  content,
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

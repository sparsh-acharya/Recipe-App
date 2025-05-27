import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/Colors/app_colors.dart';
import 'package:recipe_app/core/widgets/app_button.dart';
import 'package:recipe_app/features/ingredient_selection/domain/entity/ingredient_entity.dart';
import 'package:recipe_app/features/ingredient_selection/presentation/bloc/ingredient_bloc.dart';
import 'package:recipe_app/features/recipe_selection/presentation/bloc/recipe_list_bloc.dart';
import 'package:recipe_app/features/recipe_selection/presentation/pages/recipe_selection_page.dart';

class CategoryPageWidget extends StatefulWidget {
  final List<IngredientEntity> ingredients;

  const CategoryPageWidget({super.key, required this.ingredients});

  @override
  State<CategoryPageWidget> createState() => _CategoryPageWidgetState();
}

class _CategoryPageWidgetState extends State<CategoryPageWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<String> categories;
  @override
  void initState() {
    super.initState();
    categories = widget.ingredients.map((e) => e.category).toSet().toList();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IngredientBloc, IngredientState>(
      builder: (context, state) {
        if (state is IngredientLoaded) {
          return Scaffold(
            backgroundColor: AppColors.primaryBackgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                'Select Ingredients',
                style: TextStyle(color: AppColors.primary),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<IngredientBloc>().add(ClearSelectionEvent());
                  },
                  icon: Icon(
                    Icons.clear_all_sharp,
                    color: AppColors.secondary,
                  ),
                ),
              ],
              bottom: TabBar(
                isScrollable: true,
                controller: _tabController,
                dividerColor: AppColors.secondary,
                unselectedLabelColor: AppColors.secondary,
                labelColor: AppColors.primary,
                indicatorColor: AppColors.primary,
                tabs: categories.map((cat) => Tab(text: cat)).toList(),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children:
                  categories.map((category) {
                    final items =
                        widget.ingredients
                            .where((e) => e.category == category)
                            .toList();
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GridView.builder(
                        itemCount: items.length,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 3,
                            ),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return GestureDetector(
                            onTap: () {
                              context.read<IngredientBloc>().add(
                                ToggleIngredientEvent(item),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.secondaryBackgroundColor,
                                border: Border.all(
                                  color:
                                      state.selectedIngredients.contains(item)
                                          ? AppColors.primary
                                          : AppColors.secondary,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  item.name,
                                  style: TextStyle(
                                    color:
                                        state.selectedIngredients.contains(
                                              item,
                                            )
                                            ? AppColors.primary
                                            : AppColors.secondary,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
            ),
            bottomNavigationBar: AppButton(
              onPressed: () {
                if (state.selectedIngredients.isNotEmpty) {
                  context.read<RecipeListBloc>().add(
                    FetchRecipesByIngredientsEvent(state.selectedIngredients),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeSelectionPage(),
                    ),
                  );
                }
              }, text: 'Find Recipes',
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

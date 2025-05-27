import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/Colors/app_colors.dart';
import 'package:recipe_app/features/ingredient_selection/domain/entity/ingredient_entity.dart';
import 'package:recipe_app/features/recipe_detail/presentation/bloc/recipe_detail_bloc.dart';
import 'package:recipe_app/features/recipe_detail/presentation/pages/recipe_detail_page.dart';
import 'package:recipe_app/features/recipe_selection/domain/entity/recipe_list_enttity.dart';
import 'package:recipe_app/features/recipe_selection/presentation/bloc/recipe_list_bloc.dart';

class RecipeListWidget extends StatefulWidget {
  const RecipeListWidget({super.key});

  @override
  State<RecipeListWidget> createState() => _RecipeListWidgetState();
}

class _RecipeListWidgetState extends State<RecipeListWidget> {
  late List<String> categories;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeListBloc, RecipeListState>(
      builder: (context, state) {
        if (state is RecipeListLoaded) {
          return Scaffold(
            backgroundColor: AppColors.primaryBackgroundColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                'Recipes For You',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      context.read<RecipeDetailBloc>().add(
                        FetchDetailsByIdEvent(id: state.recipes[index].id),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width * 0.5,
                                color: Colors.transparent,
                                child: Text(
                                  state.recipes[index].title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Text(
                                'You Need ${state.recipes[index].missedIngredientCount} More Ingredients',
                                style: TextStyle(color: AppColors.primary),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.favorite_border_sharp,color: AppColors.primary,size: 15,),
                                  Text(state.recipes[index].likes.toString(),style: TextStyle(color: AppColors.secondary),),
                                ],
                              ),
                            ],
                          ),

                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: AppColors.primaryBackgroundColor,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Image.network(
                                state.recipes[index].image ?? '',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: state.recipes.length,
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

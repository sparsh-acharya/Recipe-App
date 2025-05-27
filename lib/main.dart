import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipe_app/features/equipment_checklist/data/datasource/remote_equ_checklist_datasource.dart';
import 'package:recipe_app/features/equipment_checklist/data/repo/equ_checklist_repo_impl.dart';
import 'package:recipe_app/features/equipment_checklist/domain/usecase/fetch_equ_by_id_usecase.dart';
import 'package:recipe_app/features/equipment_checklist/presentation/bloc/equ_checklist_bloc.dart';
import 'package:recipe_app/features/ingredient_selection/data/datasource/local_ingredient_datasource.dart';
import 'package:recipe_app/features/ingredient_selection/data/repo/ingredient_repo_impl.dart';
import 'package:recipe_app/features/ingredient_selection/domain/usecase/get_ingredient_usecase.dart';
import 'package:recipe_app/features/ingredient_selection/presentation/bloc/ingredient_bloc.dart';
import 'package:recipe_app/features/ingredient_selection/presentation/pages/ingredient_selection_page.dart';
import 'package:recipe_app/features/ingredients_checklist/data/datasource/remote_ing_checklist_datasource.dart';
import 'package:recipe_app/features/ingredients_checklist/data/repo/ing_checklist_repo_impl.dart';
import 'package:recipe_app/features/ingredients_checklist/domain/usecase/fetch_ingredients_by_id.dart';
import 'package:recipe_app/features/ingredients_checklist/presentation/bloc/ing_checklist_bloc.dart';
import 'package:recipe_app/features/recipe_detail/data/datasources/remote_recipe_detail_datasource.dart';
import 'package:recipe_app/features/recipe_detail/data/repo/recipe_detail_repo_impl.dart';
import 'package:recipe_app/features/recipe_detail/domain/usecase/fetch_details_by_id.dart';
import 'package:recipe_app/features/recipe_detail/presentation/bloc/recipe_detail_bloc.dart';
import 'package:recipe_app/features/recipe_selection/data/datasource/remote_recipe_datasource.dart';
import 'package:recipe_app/features/recipe_selection/data/repo/recipe_repo_impl.dart';
import 'package:recipe_app/features/recipe_selection/domain/usecase/get_recipe_by_ingredients_usecase.dart';
import 'package:recipe_app/features/recipe_selection/presentation/bloc/recipe_list_bloc.dart';
import 'package:recipe_app/features/step_checklist/data/datasource/remote_step_checklist_datasource.dart';
import 'package:recipe_app/features/step_checklist/data/repo/step_checklist_repo_impl.dart';
import 'package:recipe_app/features/step_checklist/domain/usecase/fetch_steps_by_id_usecase.dart';
import 'package:recipe_app/features/step_checklist/presentation/bloc/step_checklist_bloc.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => IngredientBloc(
                useCase: GetIngredientUsecase(
                  repo: IngredientRepoImpl(
                    datasource: LocalIngredientDatasource(),
                  ),
                ),
              ),
        ),
        BlocProvider(
          create:
              (context) => RecipeListBloc(
                usecase: GetRecipeByIngredientsUsecase(
                  repo: RecipeRepoImpl(datasource: RemoteRecipeDatasource()),
                ),
              ),
        ),
        BlocProvider(
          create:
              (context) => RecipeDetailBloc(
                usecase: FetchDetailsById(
                  repo: RecipeDetailRepoImpl(
                    datasource: RemoteRecipeDetailDatasource(),
                  ),
                ),
              ),
        ),
        BlocProvider(
          create:
              (context) => IngChecklistBloc(
                usecase: FetchIngredientsByIdUsecase(
                  repo: IngChecklistRepoImpl(
                    datasource: RemoteIngChecklistDatasource(),
                  ),
                ),
              ),
          child: Container(),
        ),
        BlocProvider(
          create:
              (context) => EquChecklistBloc(
                usecase: FetchEquByIdUsecase(
                  repo: EquChecklistRepoImpl(
                    datasource: RemoteEquChecklistDatasource(),
                  ),
                ),
              ),
          child: Container(),
        ),
        BlocProvider(
          create:
              (context) => StepChecklistBloc(
                usecase: FetchStepsByIdUsecase(
                  repo: StepChecklistRepoImpl(
                    datasource: RemoteStepChecklistDatasource(),
                  ),
                ),
              ),
          child: Container(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const IngredientSelectionPage(),
      ),
    );
  }
}

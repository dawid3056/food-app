import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/pages/categories.dart';
import 'package:food_app/pages/filters.dart';
import 'package:food_app/pages/meals.dart';
import 'package:food_app/providers/meals_provider.dart';
import 'package:food_app/widgets/main_drawer.dart';
import 'package:food_app/providers/favourites_provider.dart';
import 'package:food_app/providers/filters_provider.dart';

const kInitialFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };

class TabsPage extends ConsumerStatefulWidget {
  const TabsPage({super.key});

  @override
  ConsumerState<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends ConsumerState<TabsPage> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setPage(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filtersProvider);
    final choosenMeals = meals.where((meal) {
      if(activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if(activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if(activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if(activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = CategoriesPage(
      choosenMeals: choosenMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      activePage = MealsPage(
        meals: favouriteMeals,
      );
      activePageTitle = 'Your favourites';
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          activePageTitle,
        ),
      ),
      drawer: MainDrawer(
        onSelectPage: _setPage,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}

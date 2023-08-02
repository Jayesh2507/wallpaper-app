import 'package:flutter/cupertino.dart';

import '../model/categories_model.dart';

String apiKey = "8vfRzb0F6ZIzz5HqaHMHeIrQeMVAFYB9RQt12pUnwK6PrNA2LRdcTxnU";
//Note that you need to specify the data type of the list elements using generic type <Type> syntax
// (e.g., List<int> or List<String>).
// This ensures that the list can only hold elements of the specified type.
List<CategoriesModel> getCategories(){
    List<CategoriesModel> categories = []; //created empty of type class

    categories.add(CategoriesModel(
        categoriesName: "Street Art",
        imgUrl: "https://images.pexels.com/photos/1154198/pexels-photo-1154198.jpeg"
    ));
    categories.add(CategoriesModel(
      imgUrl:"https://images.pexels.com/photos/46519/leopard-cat-big-cat-wildcat-46519.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" ,
      categoriesName: "Wild Life"
    ));
    categories.add(CategoriesModel(
        imgUrl:"https://images.pexels.com/photos/3225517/pexels-photo-3225517.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" ,
        categoriesName: "Nature"
    ));
    categories.add(CategoriesModel(
        imgUrl:"https://images.pexels.com/photos/15521600/pexels-photo-15521600/free-photo-of-photo-of-a-city.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" ,
        categoriesName: "City"
    ));
    categories.add(CategoriesModel(
        imgUrl:"https://images.pexels.com/photos/2045600/pexels-photo-2045600.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" ,
        categoriesName: "Motivation"
    ));
    categories.add(CategoriesModel(
        imgUrl:"https://images.pexels.com/photos/2611691/pexels-photo-2611691.jpeg" ,
        categoriesName: "Bikes"
    ));
    categories.add(CategoriesModel(
        imgUrl:"https://images.pexels.com/photos/1402787/pexels-photo-1402787.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" ,
        categoriesName: "Cars"
    ));

  return categories;
}
class RecipeModel {
  late String applabel;
  late String appimguUrl;
  late String appcalories;
  late String appurl;

  RecipeModel({
    this.applabel = "label",
    this.appimguUrl = "img",
    this.appcalories = "0.0000",
    this.appurl = "url",
  });

  factory RecipeModel.fromMap(Map recipe) {
    return RecipeModel(
      applabel: recipe["label"],
      appcalories: recipe["calories"],
      appimguUrl: recipe["image"],
      appurl: recipe["url"],
    );
  }
}

class Urls {
  //base
  static const String _baseUrl = "https://ecommerce-api.codesilicon.com/api";

  //Auth
  static const String dummyUrl = "$_baseUrl/login";

  // Slider & Category
  static const String sliderListUrl = "$_baseUrl/ListProductSlider";
  static const String categoryList = "$_baseUrl/CategoryList";

  // dynamic remarks: popular, new, special
  static String productListByRemark(String remark) =>
      "$_baseUrl/ListProductByRemark/$remark";

  static String productListByCategory(int categoryId) =>
      "$_baseUrl/ListProductByCategory/$categoryId";

  static String productDetailsById(int productId) =>
      "$_baseUrl/ProductDetailsById/$productId";

  static String verifyEmail(String email) => '$_baseUrl/UserLogin/$email';
}

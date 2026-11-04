class Urls {
  //base
  static const String _baseUrl = "https://ecommerce-api.codesilicon.com/api";

  //Auth
  static const String dummyUrl = "$_baseUrl/login";

  // Slider & Category
  static const String sliderListUrl = "$_baseUrl/ListProductSlider";
  static const String categoryList = "$_baseUrl/CategoryList";
  static const String readProfile = "$_baseUrl/ReadProfile";
  static const String addToCart = "$_baseUrl/CreateCartList";
  static const String createProfile = "$_baseUrl/CreateProfile";
  static const String createInvoice = "$_baseUrl/InvoiceCreate";
  static const String cartList = "$_baseUrl/CartList";

  //wish list  
  static const String wishList = "$_baseUrl/ProductWishList";
  static String createWishList(int createwishId) => "$_baseUrl/CreateWishList/$createwishId";
  static String removeWishList(int removewishId) => "$_baseUrl/RemoveWishList/$removewishId";

  static String deleteCartItem(int cartItemId) =>
      "$_baseUrl/DeleteCartList/$cartItemId";

  // dynamic remarks: popular, new, special
  static String productListByRemark(String remark) =>
      "$_baseUrl/ListProductByRemark/$remark";

  static String productListByCategory(int categoryId) =>
      "$_baseUrl/ListProductByCategory/$categoryId";

  static String productDetailsById(int productId) =>
      "$_baseUrl/ProductDetailsById/$productId";

  static String verifyEmail(String email) => '$_baseUrl/UserLogin/$email';

  static String verifyOtp(String email, String otp) =>
      '$_baseUrl/VerifyLogin/$email/$otp';
}

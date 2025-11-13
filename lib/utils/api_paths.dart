class ApiPaths {
  static String user(String uid) => 'users/$uid';
  static String cartItem(String uid, String cartItemId) =>
      'users/$uid/cart/$cartItemId';
  static String cartItems(String uid) => 'users/$uid/cart/';
  static String products() => 'products/';
  static String product(String productId) => 'products/$productId';
  static String setFavorites(String uid, String productId) =>
      'users/$uid/favorites/$productId';
  static String favorites(String uid) => 'users/$uid/favorites';

  static String announcements() => 'announcement/';
  static String category() => 'category/';
  static String paymentCards(String uid) => 'users/$uid/paymentCards/';
  static String paymentCard(String uid, String cardId) =>
      'users/$uid/paymentCards/$cardId';
  static String locations(String uid) => 'users/$uid/locations/';
  static String location(String uid, String locationId) =>
      'users/$uid/locations/$locationId';

}

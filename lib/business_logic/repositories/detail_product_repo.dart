import 'package:e_commerce_app/business_logic/entities/cart_item.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/business_logic/services/abstract/i_cart_service.dart';
import 'package:e_commerce_app/business_logic/services/abstract/i_product_service.dart';
import 'package:e_commerce_app/business_logic/services/cart_service.dart';
import 'package:e_commerce_app/business_logic/services/product_service.dart';

class DetailProductRepository {
  final ICartService _cartService = CartService();
  final IProductService _productService = ProductService();

  Future<void> addToCart(String uid, CartItem cartItem) async {
    await _cartService.addCartItem(uid, cartItem);
  }

  Future<List<Product>> getRelatedProducts(
    String pid,
    String categoryId,
  ) async {
    List<Product> productsByCategory =
        await _productService.getProductsByCategory(categoryId) ?? [];

    return productsByCategory.where((p) => p.id != pid).toList();
  }
}

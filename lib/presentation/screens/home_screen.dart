import 'package:demo_project_app/data/models/product_model.dart';
import 'package:demo_project_app/domain/entity/cart_entity.dart';
import 'package:demo_project_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:demo_project_app/presentation/bloc/auth/auth_event.dart';
import 'package:demo_project_app/presentation/bloc/auth/auth_state.dart';
import 'package:demo_project_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:demo_project_app/presentation/bloc/cart/cart_event.dart';
import 'package:demo_project_app/presentation/bloc/cart/cart_state.dart';
import 'package:demo_project_app/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entity/product_entity.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/custom_button.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int _itemsPerPage = 5;
  int _currentPage = 1;
  bool _hasMoreItems = true;
  String? selectedCartId;

  ProductModel _convertToProductModel(ProductEntity product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      createdAt: product.createdAt,
    );
  }

  void _showCartSelectionDialog(BuildContext context, ProductEntity product) {
    // Reset selectedCartId when opening dialog
    setState(() => selectedCartId = null);
    
    showDialog(
      context: context,
      builder: (context) => BlocBuilder<CartBloc, CartState>(
        builder: (context, cartState) {
          final userId = context.read<AuthBloc>().state.userState.data?.id;
          final carts = cartState.cartListState.data ?? [];

          return AlertDialog(
            title: const Text('Select Cart'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...carts.map((cart) => RadioListTile<String>(
                  title: Text('Cart ${cart.id} (${cart.items.length} items)'),
                  subtitle: Text('Created at: ${cart.createdAt.toString()}'),
                  value: cart.id,
                  groupValue: selectedCartId,
                  onChanged: (value) {
                    setState(() => selectedCartId = value);
                    Navigator.pop(context);
                    _addToCart(context, product);
                  },
                )),
                TextButton(
                  onPressed: () {
                    if (userId != null) {
                      context.read<CartBloc>().add(
                        CreateCartEvent(
                          cart: CartEntity(
                            id: '',
                            userId: userId,
                            items: [],
                            createdAt: DateTime.now(),
                          ),
                          items: [],
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Create New Cart'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _addToCart(BuildContext context, ProductEntity product) {
    if (selectedCartId != null) {
      context.read<CartBloc>().add(
        AddItemToCartEvent(
          cartId: selectedCartId!,
          item: CartItemEntity(
            product: _convertToProductModel(product),
            quantity: 1,
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product added to cart'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final userId = state.userState.data?.id;
        
        // Load carts when screen is opened
        if (userId != null) {
          context.read<CartBloc>().add(LoadCartsEvent(userId: userId));
        }
        return CustomScaffold(
          appBar: CustomAppBar(
            title: 'Products',
            actions: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  context.read<AuthBloc>().add(LogoutEvent());
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen(),),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(16.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.w,
                  ),
                  itemBuilder: (context, index) {
                    final product = ProductEntity(
                      id: index.toString(),
                      name: 'Product ${index + 1}',
                      description: 'Description for product ${index + 1}',
                      price: (index + 1) * 10.0,
                      imageUrl: 'https://jesa6.com/wp-content/uploads/2023/08/hacks1-scaled.jpg',
                      createdAt: DateTime.now(),
                    );

                    return Card(
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDetailScreen(product: product),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(product.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                CustomButton(
                                  textOnButton: 'Add to Cart',
                                  onPressed: () => _showCartSelectionDialog(context, product),
                                  height: 32.h,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: _currentPage * _itemsPerPage,
                ),
              ),
              if (_hasMoreItems)
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: CustomButton(
                    textOnButton: 'Load More',
                    onPressed: () {
                      setState(() {
                        _currentPage++;
                        // For demo purposes, let's limit to 5 pages
                        if (_currentPage >= 5) {
                          _hasMoreItems = false;
                        }
                      });
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

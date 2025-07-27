import 'package:demo_project_app/data/models/product_model.dart';
import 'package:demo_project_app/domain/entity/product_entity.dart';
import 'package:demo_project_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:demo_project_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:demo_project_app/presentation/bloc/cart/cart_event.dart';
import 'package:demo_project_app/presentation/bloc/cart/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entity/cart_entity.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/custom_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Set<String> _selectedCartIds = {};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final userId = context.read<AuthBloc>().state.userState.data?.id;
        
        if (userId != null) {
          context.read<CartBloc>().add(LoadCartsEvent(userId: userId));
        }

        final carts = state.cartListState.data ?? [];
        final totalSelected = carts
          .where((cart) => _selectedCartIds.contains(cart.id))
          .fold<double>(0, (sum, cart) => sum + cart.totalAmount);

        return CustomScaffold(
          appBar: const CustomAppBar(
            title: 'Shopping Carts',
          ),
          body: Column(
            children: [
              Expanded(
                child: carts.isEmpty
                    ? Center(
                        child: Text(
                          'No carts yet',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(16.w),
                        itemCount: carts.length,
                        itemBuilder: (context, cartIndex) {
                          final cart = carts[cartIndex];
                          return Card(
                            margin: EdgeInsets.only(bottom: 16.h),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Checkbox(
                                    value: _selectedCartIds.contains(cart.id),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (value ?? false) {
                                          _selectedCartIds.add(cart.id);
                                        } else {
                                          _selectedCartIds.remove(cart.id);
                                        }
                                      });
                                    },
                                  ),
                                  title: Text(
                                    'Cart ${cartIndex + 1}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Created on ${cart.createdAt.toString().split('.')[0]}',
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                  trailing: Text(
                                    '\$${cart.totalAmount.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: cart.items.length,
                                  itemBuilder: (context, itemIndex) {
                                    final item = cart.items[itemIndex];
                                    return ListTile(
                                      leading: Container(
                                        width: 50.w,
                                        height: 50.w,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(item.product.imageUrl),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      title: Text(item.product.name),
                                      subtitle: Text('Quantity: ${item.quantity}'),
                                      trailing: Text(
                                        '\$${(item.product.price * item.quantity).toStringAsFixed(2)}',
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              if (carts.isNotEmpty)
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      Text(
                        'Selected Total: \$${totalSelected.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      CustomButton(
                        onPressed: _selectedCartIds.isEmpty ? null : () {
                          // Delete selected carts
                          for (String cartId in _selectedCartIds) {
                            context.read<CartBloc>().add(DeleteCartEvent(cartId: cartId));
                          }
                          setState(() {
                            _selectedCartIds.clear(); // Clear selected carts after checkout
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Checkout successful!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        textOnButton: 'Checkout Selected',
                      ),
                    ],
                  ),
                ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (userId != null) {
                context.read<CartBloc>().add(
                  CreateCartEvent(
                    cart: CartEntity(
                      id: '', // Will be set by datasource
                      userId: userId,
                      items: [],
                      createdAt: DateTime.now(),
                    ),
                    items: [],
                  ),
                );
              }
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}

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
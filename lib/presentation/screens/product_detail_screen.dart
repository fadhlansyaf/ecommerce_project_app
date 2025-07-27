import 'package:demo_project_app/data/models/product_model.dart';
import 'package:demo_project_app/domain/entity/cart_entity.dart';
import 'package:demo_project_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:demo_project_app/presentation/bloc/auth/auth_state.dart';
import 'package:demo_project_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:demo_project_app/presentation/bloc/cart/cart_event.dart';
import 'package:demo_project_app/presentation/bloc/cart/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entity/product_entity.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/custom_button.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            final userId = authState.userState.data?.id;
            final carts = cartState.cartListState.data ?? [];

            // Load carts when screen is opened
            if (userId != null) {
              context.read<CartBloc>().add(LoadCartsEvent(userId: userId));
            }

            return CustomScaffold(
              appBar: CustomAppBar(
                title: widget.product.name,
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('https://jesa6.com/wp-content/uploads/2023/08/hacks1-scaled.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            '\$${widget.product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            widget.product.description,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          SizedBox(height: 24.h),
                          Row(
                            children: [
                              Text(
                                'Quantity:',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 16.w),
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  if (quantity > 1) {
                                    setState(() {
                                      quantity--;
                                    });
                                  }
                                },
                              ),
                              Text(
                                '$quantity',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.h),
                          Text(
                            'Select Cart',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          if (carts.isEmpty)
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'No carts available',
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                ),
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
                                    }
                                  },
                                  child: Text('Create New Cart'),
                                ),
                              ],
                            )
                          else
                            Column(
                              children: [
                                ...carts.map((cart) => RadioListTile<String>(
                                  title: Text('Cart ${cart.id} (${cart.items.length} items)'),
                                  subtitle: Text(
                                    'Created on ${cart.createdAt.toString().split('.')[0]}',
                                  ),
                                  value: cart.id,
                                  groupValue: selectedCartId,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCartId = value;
                                    });
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
                                    }
                                  },
                                  child: Text('Create New Cart'),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          Text(
                            '\$${(widget.product.price * quantity).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: CustomButton(
                        textOnButton: 'Add to Cart',
                        onPressed: (selectedCartId == null || userId == null) ? null : () {
                          context.read<CartBloc>().add(
                            AddItemToCartEvent(
                              cartId: selectedCartId!,
                              item: CartItemEntity(
                                product: _convertToProductModel(widget.product),
                                quantity: quantity,
                              ),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Product added to cart'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

import 'package:demo_project_app/data/datasources/auth_local_datasource.dart';
import 'package:demo_project_app/data/datasources/cart_local_datasource.dart';
import 'package:demo_project_app/data/repository/auth_repository_impl.dart';
import 'package:demo_project_app/data/repository/cart_repository_impl.dart';
import 'package:demo_project_app/domain/usecase/cart/create_cart_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/models/cart_model.dart';
import 'data/models/product_model.dart';
import 'data/models/user_model.dart';
import 'domain/usecase/auth/check_auth_status_usecase.dart';
import 'domain/usecase/auth/login_usecase.dart';
import 'domain/usecase/auth/logout_usecase.dart';
import 'domain/usecase/cart/add_item_to_cart_usecase.dart';
import 'domain/usecase/cart/get_cart_by_id_usecase.dart';
import 'domain/usecase/cart/get_carts_usecase.dart';
import 'domain/usecase/cart/remove_item_from_cart_usecase.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/cart/cart_bloc.dart';
import 'presentation/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Adapters
  Hive.registerAdapter(CartModelAdapter());
  Hive.registerAdapter(CartItemModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());

  // Open Boxes
  final cartBox = await Hive.openBox<CartModel>('carts');
  final prefs = await SharedPreferences.getInstance();

  runApp(MyApp(cartBox: cartBox, prefs: prefs));
}

class MyApp extends StatelessWidget {
  final Box<CartModel> cartBox;
  final SharedPreferences prefs;

  const MyApp({super.key, required this.cartBox, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) {
                final authDatasource = AuthLocalDatasource(prefs: prefs);
                final authRepository =
                    AuthRepositoryImpl(authDatasource, prefs);
                return AuthBloc(
                  loginUseCase: LoginUseCase(authRepository),
                  logoutUseCase: LogoutUseCase(authRepository),
                  checkAuthStatusUseCase:
                      CheckAuthStatusUseCase(authRepository),
                );
              },
            ),
            BlocProvider(
              create: (context) {
                final cartDatasource = CartLocalDatasource(cartBox: cartBox);
                final cartRepository = CartRepositoryImpl(cartDatasource);
                return CartBloc(
                  // getCartsUseCase: GetCartsUseCase(cartRepository),
                  createCartUseCase: CreateCartUseCase(cartRepository),
                  addItemToCartUseCase: AddItemToCartUseCase(cartRepository),
                  removeItemFromCartUseCase:
                      RemoveItemFromCartUseCase(cartRepository),
                );
              },
            ),
          ],
          child: MaterialApp(
            title: 'E-Commerce App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
            ),
            home: const LoginScreen(),
          ),
        );
      },
    );
  }
}

import 'package:builder_bloc_template/core/config/router.dart';
import 'package:builder_bloc_template/presentation/views/home/bloc/cart/cart_bloc.dart';
import 'package:builder_bloc_template/presentation/widgets/home/product_card.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:builder_bloc_template/presentation/views/auth/login_page.dart';
import 'package:builder_bloc_template/presentation/views/home/bloc/produk/produk_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:builder_bloc_template/core/constants/app_color.dart';
import 'package:builder_bloc_template/core/di/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final FirebaseAuth _fAuth;
  DateTime? _lastPressedBack;
  bool _allowPop = false;

  @override
  void initState() {
    _fAuth = sl<FirebaseAuth>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ProdukBloc>()..add(GetProduksEvent())),
        BlocProvider(create: (_) => sl<CartBloc>()..add(LoadCart())),
      ],
      child: PopScope(
        canPop: _allowPop,
        onPopInvokedWithResult: (didPop, result) async {
          if(didPop) {
            return;
          }

          final now = DateTime.now();
          const maxDuration = Duration(seconds: 2);

          if(_lastPressedBack == null || now.difference(_lastPressedBack!) > maxDuration) {
            _lastPressedBack = now;

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Tekan sekali lagi untuk keluar"),
                duration: maxDuration,
              ),
            );

            return;
          }

          // Navigator.of(context).pop();
          _allowPop = true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("AppName"),
            backgroundColor: AppColor.light,
            surfaceTintColor: AppColor.light,
            elevation: 8,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.sunny)
              ),
              IconButton(
                onPressed: () {},
                icon: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    int shoppingCart = 0;
                    if(state is CartLoaded) {
                      shoppingCart = state.cart!.products.length;
                    }
                    return Badge.count(
                      count: shoppingCart,
                      isLabelVisible: shoppingCart > 0,
                      child: const Icon(Icons.shopping_cart)
                    );
                  }
                )
              )
            ],
            shadowColor: AppColor.dark.withAlpha(125),
          ),
          drawer: _buildDrawerApp(),
          body: _buildListProduks()
        ),
      )
    );
  }

  Widget _buildDrawerApp() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColor.primary400),
            child: Text("Drawer Header ${_fAuth.currentUser?.displayName ?? "-"}"),
          ),
          ListTile(
            onTap: () async {
              await _fAuth.signOut();
              sl<AppRouter>().pushReplacement(const LoginPage());
            },
            trailing: const Icon(Icons.exit_to_app),
            title: const Text("Keluar")
          )
        ],
      ),
    );
  }

  Widget _buildListProduks() {
    // const String viewType = "com.aal.flutter.builder_bloc_template/custom_view";
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Produk",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700
            )
          ),
          // SizedBox(
          //   height: 50,
          //   child: const AndroidView(viewType: viewType)
          // ),
          const SizedBox(height: 15),
          Expanded(
            child: BlocBuilder<ProdukBloc, ProdukState>(
              builder: (context, state) {
                if(state is ProdukLoading) {
                  return GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    childAspectRatio: 4/5,
                    children: List.generate(10, (index) => const Skeletonizer(
                      enabled: true,
                      child: ProductCard(produk: null),
                    ))
                  );
                }
      
                if(state is ProdukError) {
                  return Text("abcd default ${state.message}");
                }
      
                if(state is ProdukLoaded) {
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      childAspectRatio: 4/5
                    ),
                    itemCount: state.produks.length,
                    itemBuilder: (_, index) {
                      final row = state.produks[index];
                      return ProductCard(produk: row);
                    }
                  );
                }
      
                return const SizedBox();
              }
            ),
          )
        ],
      ),
    );
  }
}
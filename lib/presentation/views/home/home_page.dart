import 'package:builder_bloc_template/core/config/router.dart';
import 'package:builder_bloc_template/domain/entities/produk.dart';
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
  final _fAuth = FirebaseAuth.instance;
  DateTime? _lastPressedBack;
  bool _allowPop = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProdukBloc>()..add(GetProduksEvent()),
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
            elevation: 6,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.sunny)
              )
            ],
            shadowColor: AppColor.dark,
          ),
          drawer: _buildDrawerApp(),
          body: _buildListProduks()
        ),
      )
    );
  }

  Widget _buildDrawerApp() {
    return Drawer(
      child: TextButton(
        onPressed: () {
          _fAuth.signOut();
          sl<AppRouter>().pushReplacement(const LoginPage());
        },
        child: const Text("Keluar"),
      ),
    );
  }

  Widget _buildListProduks() {
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
                    children: List.generate(10, (index) => Skeletonizer(
                      enabled: true,
                      child: _buildProductCard(null),
                    ))
                  );
                }

                if(state is ProdukError) {
                  return Text("abcd default");
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
                      return _buildProductCard(row);
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

  Widget _buildProductCard(Produk? produk) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: produk != null
              ? Image.network(
                produk.image,
                fit: BoxFit.cover,
              ) : Container(color: Colors.grey.shade200)
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  produk?.title ?? 'Loading Name',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  produk?.price ?? '\$0.00',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
import 'package:builder_bloc_template/domain/entities/produk.dart';
import 'package:flutter/material.dart';

class DetailProdukPage extends StatelessWidget {
  const DetailProdukPage({
    super.key,
    required this.produk
  });

  final Produk produk;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Produk"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Hero(
            tag: "image_produk_${produk.id}",
            child: SizedBox(
              width: 250,
              height: 400,
              child: Image.network(
                produk.image,
                fit: BoxFit.cover,
              ),
            )
          ),
          Text(produk.title)
        ],
      ),
    );
  }
}
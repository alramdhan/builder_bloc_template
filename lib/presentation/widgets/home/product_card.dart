import 'package:builder_bloc_template/domain/entities/produk.dart';
import 'package:builder_bloc_template/presentation/views/home/detail_produk_page.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    this.produk
  });

  final Produk? produk;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: produk != null ? () => DetailProdukPage(produk: produk!) : null,
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: "image_product",
                child: produk != null
                  ? Image.network(
                    produk!.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.network("https://placehold.co/400"),
                  ) : Container(color: Colors.grey.shade200),
              )
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
      ),
    );
  }
}
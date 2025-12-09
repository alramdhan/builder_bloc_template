import 'package:builder_bloc_template/data/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    this.category
  });

  final CategoryModel? category;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        side: BorderSide(color: Colors.grey)
      ),
      child: Column(
        children: [
          Expanded(
            child: category != null
              ? Image.network(
                "https://picsum.photos/id/237/200/300",
                fit: BoxFit.cover,
                width: 100,
                errorBuilder: (context, error, stackTrace) => Image.network("https://placehold.co/400"),
              ) : Container(color: Colors.grey.shade200)
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category?.text ?? 'Loading Name',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
              ],
            ),
          )
        ],
      ),
    );
  }
}
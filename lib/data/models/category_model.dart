const listCategories = [
  CategoryModel(
    image: "https://picsum.photos/id/870/200/300?grayscale&blur=2",
    text: "Category 1"
  ),
  CategoryModel(
    image: "https://picsum.photos/id/870/200/300?grayscale&blur=2",
    text: "Category 2"
  ),
  CategoryModel(
    image: "https://picsum.photos/id/237/200/300",
    text: "Category 3"
  ),
  CategoryModel(
    image: "https://picsum.photos/id/237/200/300",
    text: "Category 4"
  ),
];

class CategoryModel {
  final String image;
  final String text;

  const CategoryModel({
    required this.image,
    required this.text
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    image: json['image'],
    text: json['text']
  );
}
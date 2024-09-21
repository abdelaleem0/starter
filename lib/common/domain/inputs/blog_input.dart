class BlogInput {
  final String? searchKey;
  final List<String>? categoryIds;
  final BlogType type;

  BlogInput({this.searchKey, this.categoryIds, required this.type});
}

enum BlogType {
  blog,
  news,
}

class BookmarkData {
  BookmarkData(
      {this.date, this.user, this.title, this.desc, this.featured, this.id});
  final String? date, user, title, desc, featured, id;

  factory BookmarkData.fromJson(Map<String, dynamic> json) => BookmarkData(
      title: json['title'],
      id: json['id'],
      desc: json['description'],
      featured: json['featured'],
      date: json['created_at']);
}

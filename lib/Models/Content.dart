// ignore_for_file: file_names

class Content {
  Content({required this.status, required this.payload});

  final int status;
  var payload;

  factory Content.fromJson(Map<String, dynamic> json) =>
      Content(status: json['status'], payload: json['payload']);
}

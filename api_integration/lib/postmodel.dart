import 'dart:convert';

Post? postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post? data) => json.encode(data!.toJson());

class Post {
  Post({
    this.name,
    this.job,
    this.id,
    this.createdAt,
  });

  String? name;
  String? job;
  String? id;
  DateTime? createdAt;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    name: json["name"],
    job: json["job"],
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "job": job,
    "id": id,
    "createdAt": createdAt?.toIso8601String(),
  };
}

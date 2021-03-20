import 'package:hive/hive.dart';

part 'savedPost.g.dart';

@HiveType(typeId: 0)
class SavedPost extends HiveObject {
  SavedPost(
      {this.id,
      this.title,
      this.summary,
      this.link,
      this.postType,
      this.editorName,
      this.publishedAt,
      this.updatedAt,
      this.imageUrl,
      this.categoryName,
      this.contentHtml,
      this.videoUrl,
      this.videoEmbedCode});

  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String summary;
  @HiveField(3)
  String link;
  @HiveField(4)
  String postType;
  @HiveField(5)
  String editorName;
  @HiveField(6)
  String publishedAt;
  @HiveField(7)
  String updatedAt;
  @HiveField(8)
  String imageUrl;
  @HiveField(9)
  String categoryName;
  @HiveField(10)
  String contentHtml;
  @HiveField(11)
  String videoUrl;
  @HiveField(12)
  String videoEmbedCode;
}

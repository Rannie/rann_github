import 'package:json_annotation/json_annotation.dart';
import 'package:rann_github/model/user.dart';

/**
 * Created by guoshuyu
 * Date: 2018-07-31
 */

part 'CommitComment.g.dart';

@JsonSerializable()
class CommitComment{
  int id;
  String body;
  String path;
  int position;
  int line;
  @JsonKey(name: "commit_id")
  String commitId;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "updated_at")
  DateTime updatedAt;
  @JsonKey(name: "html_url")
  String htmlUrl;
  String url;
  User user;

  CommitComment(
    this.id,
    this.body,
    this.path,
    this.position,
    this.line,
    this.commitId,
    this.createdAt,
    this.updatedAt,
    this.htmlUrl,
    this.url,
    this.user,
  );

  factory CommitComment.fromJson(Map<String, dynamic> json) => _$CommitCommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommitCommentToJson(this);
}

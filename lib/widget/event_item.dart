import 'package:flutter/material.dart';
import 'package:rann_github/model/Event.dart';
import 'package:rann_github/model/RepoCommit.dart';
import 'package:rann_github/style/style.dart';
import 'package:rann_github/util/event_utils.dart';
import 'package:rann_github/util/utils.dart';
import 'package:rann_github/model/Notification.dart' as Model;

class EventItem extends StatelessWidget {
  final EventViewModel eventViewModel;
  final VoidCallback onPressed;
  final bool needImage;

  EventItem(this.eventViewModel, {this.onPressed, this.needImage = true}) : super();

  @override
  Widget build(BuildContext context) {
    Widget des = (eventViewModel.actionDes == null || eventViewModel.actionDes.length == 0) ?
        Container() : Container(
      child: Text(
        eventViewModel.actionDes,
        style: Style.smallSubText,
        maxLines: 3,
      ),
      margin: EdgeInsets.only(top: 6.0, bottom: 2.0),
      alignment:  Alignment.topLeft,
    );

    Widget userImage;
    return null;
  }
}

class EventViewModel {
  String actionUser;
  String actionUserPic;
  String actionDes;
  String actionTime;
  String actionTarget;

  fromEventMap(Event event) {
    this.actionTime = Utils.getNewsTimeStr(event.createdAt);
    this.actionUser = event.actor.login;
    this.actionUserPic = event.actor.avatar_url;
    var other = EventUtils.getActionAndDes(event);
    this.actionDes = other['des'];
    this.actionTarget = other['actionStr'];
  }

  fromCommitMap(RepoCommit eventMap) {
    this.actionTime = Utils.getNewsTimeStr(eventMap.commit.committer.date);
    this.actionUser = eventMap.commit.committer.name;
    this.actionDes = 'sha:' + eventMap.sha;
    this.actionTarget = eventMap.commit.message;
  }

  fromNotify(BuildContext context, Model.Notification eventMap) {
    this.actionTime = Utils.getNewsTimeStr(eventMap.updateAt);
    this.actionUser = eventMap.repository.fullName;
    String type = eventMap.subject.type;
    String status = eventMap.unread ? Utils.getLocale(context).notifyUnread :
        Utils.getLocale(context).notifyRead;
    this.actionDes = eventMap.reason + '${Utils.getLocale(context).notifyType}: $type,'
        + ' ${Utils.getLocale(context).notifyStatus}: $status';
    this.actionTarget = eventMap.subject.title;
  }
}
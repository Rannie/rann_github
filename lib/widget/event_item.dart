import 'package:flutter/material.dart';
import 'package:rann_github/model/Event.dart';
import 'package:rann_github/model/RepoCommit.dart';
import 'package:rann_github/style/style.dart';
import 'package:rann_github/util/event_utils.dart';
import 'package:rann_github/util/navigator_utils.dart';
import 'package:rann_github/util/utils.dart';
import 'package:rann_github/model/Notification.dart' as Model;
import 'package:rann_github/widget/card_item.dart';
import 'package:rann_github/widget/user_icon_widget.dart';

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

    Widget userImage = (needImage) ? HubUserIconWidget(
      padding: EdgeInsets.only(top: 0.0, right: 5.0, left: 0.0),
      width: 30.0,
      height: 30.0,
      image: eventViewModel.actionUserPic,
      onPressed: () {
        NavigatorUtils.goPerson(context, eventViewModel.actionUser);
      },
    ) : Container();

    return Container(
      child: HubCardItem(
        child: FlatButton(
          onPressed: onPressed,
          child: Padding(
            padding: EdgeInsets.only(left: 0.0, top: 10.0, right: 0.0, bottom: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    userImage,
                    Expanded(child: Text(eventViewModel.actionUser, style: Style.smallSubText,)),
                    Text(eventViewModel.actionTime, style: Style.smallSubText)
                  ],
                ),
                Container(
                  child: Text(eventViewModel.actionTarget, style: Style.smallSubText),
                  margin: EdgeInsets.only(top: 6.0, bottom: 2.0),
                  alignment: Alignment.topLeft,
                ),
                des
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventViewModel {
  String actionUser;
  String actionUserPic;
  String actionDes;
  String actionTime;
  String actionTarget;

  EventViewModel.fromEventMap(Event event) {
    this.actionTime = Utils.getNewsTimeStr(event.createdAt);
    this.actionUser = event.actor.login;
    this.actionUserPic = event.actor.avatar_url;
    var other = EventUtils.getActionAndDes(event);
    this.actionDes = other['des'];
    this.actionTarget = other['actionStr'];
  }

  EventViewModel.fromCommitMap(RepoCommit eventMap) {
    this.actionTime = Utils.getNewsTimeStr(eventMap.commit.committer.date);
    this.actionUser = eventMap.commit.committer.name;
    this.actionDes = 'sha:' + eventMap.sha;
    this.actionTarget = eventMap.commit.message;
  }

  EventViewModel.fromNotify(BuildContext context, Model.Notification eventMap) {
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
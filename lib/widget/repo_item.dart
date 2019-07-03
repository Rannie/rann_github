import 'package:flutter/material.dart';
import 'package:rann_github/model/Repository.dart';
import 'package:rann_github/style/style.dart';
import 'package:rann_github/util/navigator_utils.dart';
import 'package:rann_github/widget/card_item.dart';
import 'package:rann_github/widget/icon_text.dart';
import 'package:rann_github/widget/user_icon_widget.dart';

class ReposItem extends StatelessWidget {
  final ReposViewModel reposViewModel;
  final VoidCallback onPressed;

  ReposItem(this.reposViewModel, {this.onPressed}) : super();

  _getBottomItem(BuildContext context, IconData icon, String text, {int flex =3}) {
    return Expanded(
      flex: flex,
      child: Center(
        child: HubIconText(
          icon,
          text,
          Style.smallSubText,
          Color(HubColors.subTextColor),
          15.0,
          padding: 5.0,
          textWidth: flex == 4 ?
                (MediaQuery.of(context).size.width - 100) / 3
              : (MediaQuery.of(context).size.width - 100) / 5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HubCardItem(
        child: FlatButton(
          onPressed: onPressed,
          child: Padding(
            padding: EdgeInsets.only(left: 0.0, top: 10.0, right: 10.0, bottom: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    HubUserIconWidget(
                      padding: EdgeInsets.only(top: 0.0, right: 5.0, left: 0.0),
                      width: 40.0,
                      height: 40.0,
                      image: reposViewModel.ownerPic,
                      onPressed: () {
                        NavigatorUtils.goPerson(context, reposViewModel.ownerName);
                      },
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            reposViewModel.repositoryName ?? '', style: Style.normalText,
                          ),
                          HubIconText(
                            HubIcons.REPOS_ITEM_USER,
                            reposViewModel.ownerName,
                            Style.smallSubLightText,
                            Color(HubColors.subLightTextColor),
                            10.0,
                            padding: 3.0,
                          )
                        ],
                      ),
                    ),
                    Text(
                      reposViewModel.repositoryType, style: Style.smallSubText,
                    )
                  ],
                ),
                Container(
                  child: Text(
                    reposViewModel.repositoryDes,
                    style: Style.smallSubText,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  margin: EdgeInsets.only(top: 6.0, bottom: 2.0),
                  alignment: Alignment.topLeft,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _getBottomItem(context, HubIcons.REPOS_ITEM_STAR, reposViewModel.repositoryStar),
                    SizedBox(width: 5),
                    _getBottomItem(context, HubIcons.REPOS_ITEM_FORK, reposViewModel.repositoryFork),
                    SizedBox(width: 5),
                    _getBottomItem(context, HubIcons.REPOS_ITEM_ISSUE, reposViewModel.repositoryWatch, flex: 4)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReposViewModel {
  String ownerName;
  String ownerPic;
  String repositoryName;
  String repositoryStar;
  String repositoryFork;
  String repositoryWatch;
  String hideWatchIcon;
  String repositoryType = "";
  String repositoryDes;

  ReposViewModel();

  ReposViewModel.fromMap(Repository data) {
    ownerName = data.owner.login;
    ownerPic = data.owner.avatar_url;
    repositoryName = data.name;
    repositoryStar = data.watchersCount.toString();
    repositoryFork = data.forksCount.toString();
    repositoryWatch = data.openIssuesCount.toString();
    repositoryType = data.language ?? '---';
    repositoryDes = data.description ?? '---';
  }

  ReposViewModel.fromTrendMap(model) {
    ownerName = model.name;
    if (model.contributors.length > 0) {
      ownerPic = model.contributors[0];
    } else {
      ownerPic = "";
    }
    repositoryName = model.reposName;
    repositoryStar = model.starCount;
    repositoryFork = model.forkCount;
    repositoryWatch = model.meta;
    repositoryType = model.language;
    repositoryDes = model.description;
  }
}
import 'package:flutter/material.dart';

class HubColors {
    static const int primaryColor = 0xFF4284F3;
    static const int textWhite = 0xFFFFFFFF;
    static const int whiteThemeColor = 0xFFFFFFFF;
    static const int mainTextColor = 0xFF121917;
    static const int subTextColor = 0xff959595;
    static const int subLightTextColor = 0xffc4c4c4;
    static const int textColorWhite = 0xFFFFFFFF;

    static const MaterialColor primarySwatch = const MaterialColor(
        primaryColor,
        const <int, Color> {
            50: const Color(primaryColor),
            100: const Color(primaryColor),
            200: const Color(primaryColor),
            300: const Color(primaryColor),
            400: const Color(primaryColor),
            500: const Color(primaryColor),
            600: const Color(primaryColor),
            700: const Color(primaryColor),
            800: const Color(primaryColor),
            900: const Color(primaryColor)
        }
    );
}

class HubIcons {
    static const String FONT_FAMILY = 'HubIconFont';

    static const String DEFAULT_USER_ICON = 'assets/image/logo.png';
    static const String DEFAULT_IMAGE = 'assets/image/default_img.png';
    static const String DEFAULT_REMOTE_PIC = 'https://raw.githubusercontent.com/CarGuo/GSYGithubAppFlutter/master/static/images/logo.png';

    static const IconData HOME = const IconData(0xe624, fontFamily: HubIcons.FONT_FAMILY);
    static const IconData MORE = const IconData(0xe674, fontFamily: HubIcons.FONT_FAMILY);
    static const IconData SEARCH = const IconData(0xe61c, fontFamily: HubIcons.FONT_FAMILY);

    static const IconData MAIN_DT = const IconData(0xe684, fontFamily: HubIcons.FONT_FAMILY);
    static const IconData MAIN_QS = const IconData(0xe818, fontFamily: HubIcons.FONT_FAMILY);
    static const IconData MAIN_MY = const IconData(0xe6d0, fontFamily: HubIcons.FONT_FAMILY);
    static const IconData MAIN_SEARCH = const IconData(0xe61c, fontFamily: HubIcons.FONT_FAMILY);

    static const IconData LOGIN_USER = const IconData(0xe666, fontFamily: HubIcons.FONT_FAMILY);
    static const IconData LOGIN_PW = const IconData(0xe60e, fontFamily: HubIcons.FONT_FAMILY);

    static const IconData REPOS_ITEM_USER = const IconData(0xe63e, fontFamily: HubIcons.FONT_FAMILY);
    static const IconData REPOS_ITEM_STAR = const IconData(0xe643, fontFamily: HubIcons.FONT_FAMILY);
    static const IconData REPOS_ITEM_FORK = const IconData(0xe67e, fontFamily: HubIcons.FONT_FAMILY);
    static const IconData REPOS_ITEM_ISSUE = const IconData(0xe661, fontFamily: HubIcons.FONT_FAMILY);

    static const IconData REPOS_ITEM_STARED = const IconData(0xe698, fontFamily: HubIcons.FONT_FAMILY);
    static const IconData REPOS_ITEM_WATCH = const IconData(0xe681, fontFamily: HubIcons.FONT_FAMILY);
    static const IconData REPOS_ITEM_WATCHED = const IconData(0xe629, fontFamily: HubIcons.FONT_FAMILY);
    static const IconData REPOS_ITEM_DIR = Icons.folder;
    static const IconData REPOS_ITEM_FILE = const IconData(0xea77, fontFamily: HubIcons.FONT_FAMILY);
    static const IconData REPOS_ITEM_NEXT = const IconData(0xe610, fontFamily: HubIcons.FONT_FAMILY);

    static const IconData USER_ITEM_COMPANY = const IconData(0xe63e, fontFamily: HubIcons.FONT_FAMILY);
    static const IconData USER_ITEM_LOCATION = const IconData(0xe7e6, fontFamily: HubIcons.FONT_FAMILY);
    static const IconData USER_ITEM_LINK = const IconData(0xe670, fontFamily: HubIcons.FONT_FAMILY);
    static const IconData USER_NOTIFY = const IconData(0xe600, fontFamily: HubIcons.FONT_FAMILY);

    static const IconData ISSUE_ITEM_ISSUE = const IconData(0xe661, fontFamily: HubIcons.FONT_FAMILY);
    static const IconData ISSUE_ITEM_COMMENT = const IconData(0xe6ba, fontFamily: HubIcons.FONT_FAMILY);
    static const IconData ISSUE_ITEM_ADD = const IconData(0xe662, fontFamily: HubIcons.FONT_FAMILY);

    static const IconData ISSUE_EDIT_H1 = Icons.filter_1;
    static const IconData ISSUE_EDIT_H2 = Icons.filter_2;
    static const IconData ISSUE_EDIT_H3 = Icons.filter_3;
    static const IconData ISSUE_EDIT_BOLD = Icons.format_bold;
    static const IconData ISSUE_EDIT_ITALIC = Icons.format_italic;
    static const IconData ISSUE_EDIT_QUOTE = Icons.format_quote;
    static const IconData ISSUE_EDIT_CODE = Icons.format_shapes;
    static const IconData ISSUE_EDIT_LINK = Icons.insert_link;

    static const IconData NOTIFY_ALL_READ = const IconData(0xe62f, fontFamily: HubIcons.FONT_FAMILY);

    static const IconData PUSH_ITEM_EDIT = Icons.mode_edit;
    static const IconData PUSH_ITEM_ADD = Icons.add_box;
    static const IconData PUSH_ITEM_MIN = Icons.indeterminate_check_box;
}

class Style {
    static const lagerTextSize = 30.0;
    static const bigTextSize = 23.0;
    static const normalTextSize = 18.0;
    static const middleTextWhiteSize = 16.0;
    static const smallTextSize = 14.0;
    static const minTextSize = 12.0;

    static const normalTextWhite = TextStyle(
        color: Color(HubColors.textWhite),
        fontSize: normalTextSize
    );

    static const normalText = TextStyle(
        color: Color(HubColors.mainTextColor),
        fontSize: normalTextSize,
    );

    static const smallSubText = TextStyle(
        color: Color(HubColors.subTextColor),
        fontSize: smallTextSize,
    );

    static const smallSubLightText = TextStyle(
        color: Color(HubColors.subLightTextColor),
        fontSize: smallTextSize,
    );

    static const middleTextWhite = TextStyle(
        color: Color(HubColors.textColorWhite),
        fontSize: middleTextWhiteSize,
    );
}

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../constants/general.dart';
import '../../constants/info_screen.dart';
import '../../components/hero_section.dart';
import '../../components/zadatko_button.dart';
import '../../models/auth.dart';
import '../start_screen/start_screen.dart';

// Shows various information about the app, way to use it and the developer
class InfoScreen extends StatelessWidget {
  static const routeName = '/info-screen';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: darkColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 24.0,
          ),
          width: size.width,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: lightColor,
                    size: 30.0,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(height: 8.0),
                Center(
                  child: HeroSection(
                    upperText: upperInfoText,
                  ),
                ),
                SizedBox(height: 64.0),
                Text(
                  whatTitleString,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 30.0),
                ),
                SizedBox(height: 24.0),
                RichText(
                  text: TextSpan(
                    text: appName,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: tagColors[2],
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: whatFirstString,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 20.0),
                      ),
                      TextSpan(
                        text: whatSecondString,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: tagColors[0],
                            ),
                      ),
                      TextSpan(
                        text: whatThirdString,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 36.0),
                Text(
                  signupLoginTitleString,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 28.0),
                ),
                SizedBox(height: 24.0),
                RichText(
                  text: TextSpan(
                    text: signupLoginFirstString,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: tagColors[6],
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: signupLoginSecondString,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 20.0),
                      ),
                      TextSpan(
                        text: signupLoginThirdString,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: tagColors[3],
                            ),
                      ),
                      TextSpan(
                        text: signupLoginFourthString,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 20.0),
                      ),
                      TextSpan(
                        text: signupLoginFifthString,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: tagColors[1],
                            ),
                      ),
                      TextSpan(
                        text: signupLoginSixthString,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 20.0),
                      ),
                      TextSpan(
                        text: signupLoginSeventhString,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: tagColors[0],
                            ),
                      ),
                      TextSpan(
                        text: signupLoginEigthString,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 36.0),
                Text(
                  tagsTitleString,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 28.0),
                ),
                SizedBox(height: 24.0),
                RichText(
                  text: TextSpan(
                    text: tagsFirstString,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: tagColors[5],
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: tagsSecondString,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 20.0),
                      ),
                      TextSpan(
                        text: tagsThirdString,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: tagColors[2],
                            ),
                      ),
                      TextSpan(
                        text: tagsFourthString,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 20.0),
                      ),
                      TextSpan(
                        text: tagsFifthString,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: tagColors[9],
                            ),
                      ),
                      TextSpan(
                        text: tagsSixthString,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 36.0),
                Text(
                  updateTitleString,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 28.0),
                ),
                SizedBox(height: 24.0),
                RichText(
                  text: TextSpan(
                    text: updateFirstString,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 20.0),
                    children: <TextSpan>[
                      TextSpan(
                        text: updateSecondString,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: tagColors[3],
                            ),
                      ),
                      TextSpan(
                        text: updateThirdString,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 36.0),
                Text(
                  deleteTitleString,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 28.0),
                ),
                SizedBox(height: 24.0),
                RichText(
                  text: TextSpan(
                    text: deleteFirstString,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 20.0),
                    children: <TextSpan>[
                      TextSpan(
                        text: deleteSecondString,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: tagColors[2],
                            ),
                      ),
                      TextSpan(
                        text: deleteThirdString,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 20.0),
                      ),
                      TextSpan(
                        text: deleteFourthString,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: tagColors[1],
                            ),
                      ),
                      TextSpan(
                        text: deleteFifthString,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 36.0),
                Text(
                  signoutTitleString,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 28.0),
                ),
                SizedBox(height: 24.0),
                RichText(
                  text: TextSpan(
                    text: signoutFirstString,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 20.0),
                    children: <TextSpan>[
                      TextSpan(
                        text: signoutSecondString,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: tagColors[0],
                            ),
                      ),
                      TextSpan(
                        text: signoutThirdString,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 20.0),
                      ),
                      TextSpan(
                        text: signoutFourthString,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: tagColors[9],
                            ),
                      ),
                      TextSpan(
                        text: signoutFifthString,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 36.0),
                Center(
                  child: ZadatkoButton(
                    text: signoutTitleString,
                    onTap: () async {
                      await Auth().signOutFirebase();
                      startFieldsState = StartFieldsState.start;
                      Navigator.popAndPushNamed(
                        context,
                        StartScreen.routeName,
                      );
                    },
                    color: redColor,
                  ),
                ),
                SizedBox(height: 56.0),
                Center(
                  child: Text(
                    thankYouString,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontSize: 26.0),
                  ),
                ),
                SizedBox(height: 36.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

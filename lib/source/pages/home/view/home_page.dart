import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vietnamcovidtracking/source/config/size_app.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/homePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget _header() {
      Widget _btnCallSms(
          {required String title,
          required IconData icon,
          required Function onTap,
          required Color backgroundcolor}) {
        return Flexible(
          child: TextButton(
            onPressed: () => onTap(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 24, color: Colors.white),
                const SizedBox(width: 4.0),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width * 0.45, 54)),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12)),
              backgroundColor:
                  MaterialStateProperty.all(backgroundcolor), //Background Color
              elevation: MaterialStateProperty.all(6), //Defines Elevation
              shadowColor: MaterialStateProperty.all(Colors.grey), //Define
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  // side: BorderSide(color: Colors.red),
                ),
              ),
            ),
          ),
        );
      }

      return Container(
        padding: const EdgeInsets.only(
            left: SizeApp.normalPadding,
            right: SizeApp.normalPadding,
            bottom: SizeApp.normalPadding),
        decoration: BoxDecoration(
            color: ThemePrimary.primaryColor,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "T??nh tr???ng s???c kh???e c???a b???n h??m nay th??? n??o?",
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(height: SizeApp.normalPadding),
            Text(
              "B???n c?? c???m th???y nh?? b??? b???nh kh??ng?",
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(height: SizeApp.normalPadding),
            Text(
              "N???u b???n c???m th???y b??? b???nh v???i b???t k??? tri???u ch???ng Covid-19 n??o, vui l??ng g???i ho???c nh???n tin SMS cho ch??ng t??i ngay l???p t???c ????? ???????c gi??p ?????",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(height: SizeApp.normalPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _btnCallSms(
                    title: "G???i ngay",
                    icon: Icons.phone,
                    backgroundcolor: ThemePrimary.green,
                    onTap: () async {
                      const _url = "tel:19003228";
                      if (await canLaunch(_url)) {
                        await launch(_url);
                      } else {
                        throw 'Could not launch $_url';
                      }
                    }),
                // const SizedBox(width: 16.0),
                _btnCallSms(
                    title: "G???i tin nh???n",
                    backgroundcolor: ThemePrimary.orange,
                    icon: LineIcons.sms,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                backgroundColor: Colors.transparent,
                                insetPadding: const EdgeInsets.only(
                                    top: 10, bottom: 10, left: 32, right: 8),
                                child: Stack(
                                  // ignore: deprecated_member_use
                                  overflow: Overflow.visible,
                                  alignment: Alignment.topCenter,
                                  children: <Widget>[
                                    Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.only(
                                            right: 24.0, top: 40),
                                        height:
                                            // MediaQuery.of(context).size.height *
                                            //     0.3,
                                            120.0,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white),
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 28, 10, 20),
                                        child: Column(
                                          children: [
                                            Text("Th??ng b??o",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2!
                                                    .copyWith(
                                                        color: ThemePrimary
                                                            .primaryColor)),
                                            const SizedBox(height: 8.0),
                                            Text("T??nh n??ng n??y ??ang ph??t tri???n",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!),
                                          ],
                                        )),
                                    Positioned(
                                        top: 0,
                                        child: Container(
                                            height: 60,
                                            width: 60,
                                            margin: const EdgeInsets.only(
                                                right: 24),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    ThemePrimary.primaryColor),
                                            child: const Center(
                                                child: Icon(
                                              Icons.info,
                                              color: Colors.white,
                                              size: 34,
                                            )))),
                                    Positioned(
                                        top: 0,
                                        right: 0,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Ink(
                                            padding: const EdgeInsets.all(4.0),
                                            height: 40,
                                            width: 40,
                                            decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle),
                                            child: const Icon(Icons.clear,
                                                color: Colors.white),
                                          ),
                                        ))
                                  ],
                                ));
                          });
                    })
              ],
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      );
    }

    Widget _center() {
      Widget __preventionItem({required String title, required String svgUrl}) {
        return Expanded(
          // width: MediaQuery.of(context).size.width / 3,
          // height: MediaQuery.of(context).size.width / 3,
          child: Column(
            children: [
              SvgPicture.asset(svgUrl, fit: BoxFit.fill),
              const SizedBox(height: SizeApp.paddingTxt),
              Text(title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        );
      }

      return Container(
        padding: const EdgeInsets.all(SizeApp.normalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Ph??ng ng???a", style: Theme.of(context).textTheme.headline2!),
            const SizedBox(height: SizeApp.normalPadding + 8),
            SizedBox(
              // height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  __preventionItem(
                    title: "Tr??nh ti???p x??c g???n",
                    svgUrl: "assets/svg/avoidclosecontact.svg",
                  ),
                  __preventionItem(
                    title: "L??m s???ch tay th?????ng xuy??n",
                    svgUrl: "assets/svg/cleanhands.svg",
                  ),
                  __preventionItem(
                    title: "Lu??n mang kh???u trang",
                    svgUrl: "assets/svg/facemask.svg",
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget _bottom() {
      return Container(
        // height: MediaQuery.of(context).size.height * 0.2,
        padding: const EdgeInsets.symmetric(horizontal: SizeApp.normalPadding),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 24.0),
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.18,
                  right: SizeApp.normalPadding,
                  top: SizeApp.normalPadding,
                  bottom: SizeApp.normalPadding),
              decoration: BoxDecoration(
                  // color: ThemePrimary.primaryColor,
                  gradient: LinearGradient(colors: [
                    ThemePrimary.primaryColor,
                    ThemePrimary.primaryColor.withOpacity(0.4)
                  ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "B???n ???? s???n s??ng?",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colors.white),
                  ),
                  // const SizedBox(height: 4),
                  Text(
                    "Chung s???c v?? c???ng ?????ng v?????t qua ?????i d???ch",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 0,
                bottom: 0,
                left: 15,
                child: SvgPicture.asset(
                  "assets/svg/owntest.svg",
                  // height: MediaQuery.of(context).size.height * 0.15,
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                ))
          ],
        ),
      );
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [_header(), _center(), _bottom()],
      ),
    );
  }
}

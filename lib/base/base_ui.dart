import 'package:flutter/material.dart';

class LoadingV1 extends StatelessWidget {
  const LoadingV1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const Center(child: CircularProgressIndicator());
    return Center(
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).primaryColor.withOpacity(0.3),
        ),
        margin: const EdgeInsets.all(4),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}



void toDialog(BuildContext context, String TITLE, String MSG, int TYPE, VoidCallback? action,) {
  //type 1 = success->back
  //type 2 = info->stay
  //type 3 = info->back
  //type 4 = confirm
  //type 5 = snackbar
  //type 6 = action
  if (TITLE.isNotEmpty && MSG.isNotEmpty) {
    if (TYPE == 1) {
      showInfoDialog(
        context,
        TITLE,
        MSG,
        "OK",
            () {
          Navigator.pop(context);
          Navigator.pop(context, true);
        },
        MainAxisAlignment.center,
      );
    } else if (TYPE == 2) {
      showInfoDialog(
        context,
        TITLE,
        MSG,
        "OK",
            () {
          Navigator.pop(context);
        },
        MainAxisAlignment.center,
      );
    } else if (TYPE == 3) {
      showInfoDialog(
        context,
        TITLE,
        MSG,
        "OK",
            () {
          Navigator.pop(context);
          Navigator.pop(context, true);
        },
        MainAxisAlignment.center,
      );
    } else if (TYPE == 4) {
    } else if (TYPE == 5) {
    } else if (TYPE == 6) {
      showInfoDialog(
        context,
        TITLE,
        MSG,
        "OK",
        action,
        MainAxisAlignment.center,
      );
    } else {}
  }
}

/*
showInfoDialog(
  context,
  "Perhatian",
  "Pengajuan izin anda berhasil diajukan.",
  "Ok",
  () {
    Navigator.pop(context);
    Navigator.pop(context);
  },
  MainAxisAlignment.center,
);
 */
Future<void> showInfoDialog(
    BuildContext context,
    String title,
    String? msg,
    String confirmLabel,
    VoidCallback? confirmAction,
    MainAxisAlignment position,
    ) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        elevation: 0.0,
        content: Column(
          mainAxisAlignment: position,
          children: [
            Container(
              width: width,
              decoration: radius10(),
              child: Padding16HV(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextNormal(
                      title,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    space10(),
                    TextNormal(msg),
                    space10(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: confirmAction,
                          child: TextNormal(confirmLabel),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Decoration radius10() => _baseRadius(10.0);


Decoration _baseRadius(double radius) => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(
    Radius.circular(radius),
  ),
);



class Padding16HV extends StatelessWidget {
  final Widget? child;

  const Padding16HV({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: child,
    );
  }
}


class TextNormal extends StatelessWidget {
  // ignore: constant_identifier_names
  static const double PP7 = 28;
  static const double PP6 = 26;
  static const double PP5 = 24;
  static const double PP4 = 22;
  static const double PP3 = 20;
  static const double PP2 = 18;
  static const double PP1 = 16;
  static const double P = 14;
  static const double PS1 = 12;
  static const double PS2 = 10;

  final String? title;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign? textAlign;

  const TextNormal(
      this.title, {
        Key? key,
        this.color,
        this.fontSize = P,
        this.fontWeight = FontWeight.normal,
        this.textAlign = TextAlign.start,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      overflow: TextOverflow.clip,
      '$title',
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        overflow: TextOverflow.clip,
      ),
    );
  }
}

Widget space10 () => _baseSpace(10);

Widget _baseSpace (double space) => SizedBox(height: space, width: space);



class NoData extends StatelessWidget {
  const NoData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // return const Center(child: CircularProgressIndicator());
    return Center(
      child: Container(
        height: 50,
        width: (width*0.5)+50,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).primaryColor.withOpacity(0.3),
        ),
        margin: const EdgeInsets.all(4),
        child: const Center(child: Text('Tidak ada data yang ditemukan')),
      ),
    );
  }
}



class ContainerParentStroke extends StatelessWidget {
  final Widget child;
  final double vertical;

  const ContainerParentStroke({
    Key? key,
    required this.child,
    this.vertical = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin16(),
      decoration: BoxDecoration(
          color: Colors.white,

          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(16))
      ),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: vertical),
      child: Padding(
        padding: padding16(),
        child: child,
      ),
    );
  }
}

EdgeInsets padding16() =>  _basePadding(16);

EdgeInsets _basePadding(double padding) => EdgeInsets.all(padding);

EdgeInsets margin16() => _baseMargin(16, 16, 16, 16);

EdgeInsets _baseMargin(
    double top,
    double right,
    double bottom,
    double left,
    ) => EdgeInsets.only(top: top, right: right, bottom: bottom, left: left);



class ContainerParentList extends StatelessWidget {
  final Widget child;
  final double vertical;

  const ContainerParentList({
    Key? key,
    required this.child,
    this.vertical = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: vertical),
      color: Colors.red.withOpacity(0.5),
      child: child,
    );
  }
}
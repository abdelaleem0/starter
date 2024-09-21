// import 'package:starter/common/utils/app_style/app_colors.dart';
// import 'package:starter/common/utils/dimensions.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
//
// class PdfWidgets {
//
//   static Future<String> getHeaderIcon() async {
//     String headerIcon=  await rootBundle.loadString('images/weekly_planner/tick_circle.svg');
//     return headerIcon;
//   }
//   static pw.Row getHeaderPdfWidget(
//       {required String questionTitle,String? svgIcon }) {
//     return pw.Row(
//         mainAxisAlignment: pw.MainAxisAlignment.start,
//         crossAxisAlignment: pw.CrossAxisAlignment.start,
//         children: [
//           svgIcon !=null ?pw.SvgImage(svg:svgIcon,colorFilter: PdfColor.fromInt(AppColors.primary_500.value)) : pw.SizedBox(),
//           pw.SizedBox(
//             width: PaddingDimensions.normal,
//           ),
//           pw.Text(questionTitle, overflow: pw.TextOverflow.span),
//         ]);
//   }
//
//   static pw.Text getAnswerPdfWidget(
//       {required String answer,
//         String? secondAnswer,
//         required bool isQuestionHisTwoAnswers}) {
//     return pw.Text(
//         isQuestionHisTwoAnswers == false
//             ? answer
//             : ("If: ") + (answer),
//         overflow: pw.TextOverflow.span);
//
//   }
//
// }

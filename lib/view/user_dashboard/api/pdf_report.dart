import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:wmsm_flutter/model/chart.dart';
import 'package:wmsm_flutter/view/user_dashboard/api/save_openfile.dart';

class PdfReportApi {
  static Future<void> generate(
      List<ChartData> genderData,
      List<ChartData> vTypeData,
      int totalvCount,
      List<ChartData> vPriceData,
      List<int> quantityForOne,
      List<ChartData> challengeData) async {
    final pdfFile = Document();
    pdfFile.addPage(MultiPage(
        build: (context) => [
              buildTitle(),
              buildUserAnalytics(genderData),
              buildChallengeAnalytics(challengeData),
              buildVoucherAnalytics(
                  vPriceData, vTypeData, totalvCount, quantityForOne),
            ]));

    List<int> bytes = await pdfFile.save();
    saveAndLaunchFile(bytes, 'wmsm_report.pdf');
  }
}

Widget buildTitle() =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('WMSM Monthly Report',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      SizedBox(height: 0.3 * PdfPageFormat.cm),
      Text('Last updated: ${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
          style: const TextStyle(fontSize: 10)),
      SizedBox(height: 1.2 * PdfPageFormat.cm),
    ]);

Widget buildUserAnalytics(List<ChartData> genderData) {
  final headers = ['Gender', 'Total users'];

  final mapData = genderData.map((e) => [e.x, e.y]).toList();
  //reduce to add the data
  final totalRegUsers = genderData.map((e) => e.y).reduce((a, b) => a + b);

  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('User Gender Analytics',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
    SizedBox(height: 0.4 * PdfPageFormat.cm),
    buildTable2(headers, mapData),
    SizedBox(height: 0.5 * PdfPageFormat.cm),
    Text('Total registered users: $totalRegUsers'),
    SizedBox(height: 1.2 * PdfPageFormat.cm),
  ]);
}

Widget buildChallengeAnalytics(List<ChartData> challengeData) {
  final headers = ['Challenge name', 'Number of participants'];

  final mapData = challengeData.map((e) => [e.x, e.y]).toList();

  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('Challenge Analytics',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
    SizedBox(height: 0.4 * PdfPageFormat.cm),
    buildTable2(headers, mapData),
    SizedBox(height: 0.5 * PdfPageFormat.cm),
    Text('Total challenge added: ${challengeData.length}'),
    SizedBox(height: 1.2 * PdfPageFormat.cm),
  ]);
}

Widget buildVoucherAnalytics(List<ChartData> vPriceData,
    List<ChartData> vTypeData, int totalvCount, List<int> quantity) {
  final headers1 = ['Voucher type', 'Number of vouchers'];
  final headers2 = [
    'Voucher name',
    'Quantity',
    'Price per One (RM)',
    'Total voucher price per column (RM)'
  ];

  double overallVoucherPrice = 0.0;

  final mapData1 = vTypeData.map((e) => [e.x, e.y]).toList();
  final mapData2 = vPriceData.map((e) {
    return [
      e.x,
      quantity[vPriceData.indexOf(e)],
      e.y,
      e.y * quantity[vPriceData.indexOf(e)]
    ];
  }).toList();

  //calculate the overall voucher price
  for (int i = 0; i < totalvCount; i++) {
    overallVoucherPrice += vPriceData[i].y * quantity[i];
  }

  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('Voucher Analytics',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
    SizedBox(height: 0.4 * PdfPageFormat.cm),
    buildTable2(headers1, mapData1),
    SizedBox(height: 0.5 * PdfPageFormat.cm),
    Text('Total voucher quantity: $totalvCount'),
    SizedBox(height: 1.2 * PdfPageFormat.cm),
    buildTable4(headers2, mapData2),
    SizedBox(height: 0.5 * PdfPageFormat.cm),
    Text('Overall voucher price: RM${overallVoucherPrice.toStringAsFixed(2)}'),
  ]);
}

Widget buildTable2(final headers, final mapData) {
  return Table.fromTextArray(
      headers: headers,
      data: mapData,
      cellAlignments: {0: Alignment.center, 1: Alignment.centerRight},
      headerStyle: TextStyle(
          fontSize: 11, fontWeight: FontWeight.bold, color: PdfColors.white),
      headerDecoration: const BoxDecoration(color: PdfColors.blueGrey400));
}

Widget buildTable4(final headers, final mapData) {
  return Table.fromTextArray(
      headers: headers,
      data: mapData,
      cellAlignments: {
        0: Alignment.center,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight
      },
      headerStyle: TextStyle(
          fontSize: 11, fontWeight: FontWeight.bold, color: PdfColors.white),
      headerDecoration: const BoxDecoration(color: PdfColors.blueGrey400));
}

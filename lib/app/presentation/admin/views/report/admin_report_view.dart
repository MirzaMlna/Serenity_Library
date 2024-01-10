// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:serenity/app/presentation/db_helper/report_helper/report_db_helper.dart';
import 'package:serenity/app/utlis/color_pallete.dart';

import 'package:serenity/app/widgets/text_style.dart';

class AdminReportView extends StatefulWidget {
  const AdminReportView({super.key});

  @override
  State<AdminReportView> createState() => _AdminReportViewState();
}

class _AdminReportViewState extends State<AdminReportView> {
  List<Map<String, dynamic>> _allReportData = [];
  //get all report data
  bool _isLoading = true;
  void _refreshReportData() async {
    final data = await ReportSQLHelper.getAllData();
    setState(() {
      _allReportData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshReportData();
  }

// //add data
//   Future<void> _addData() async {
//     try {
//       await ReportSQLHelper.createData(
//           _reportTitleController.text, _reportDescController.text);
//       _refreshReportData();
//     } catch (e) {
//       print('Error adding data: $e');
//       // Show an error message to the user
//     }
//   }

// //update data
//   Future<void> _updateData(int reportId) async {
//     try {
//       await ReportSQLHelper.updateData(
//           reportId, _reportTitleController.text, _reportDescController.text);
//       _refreshReportData();
//     } catch (e) {
//       print('Error updating data: $e');
//       // Show an error message to the user
//     }
//   }

//delete data
  void _deleteData(int reportId) async {
    await ReportSQLHelper.deleteData(reportId);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Pesan Laporan Berhasil Dihapus',
          style: serenityTitle,
        )));
    _refreshReportData();
  }

  // final TextEditingController _reportTitleController = TextEditingController();
  // final TextEditingController _reportDescController = TextEditingController();

//   void showBottomSheet(int? reportId) async {
//     if (reportId != null) {
//       final existingData = _allReportData
//           .firstWhere((element) => element['reportId'] == reportId);
//       _reportTitleController.text = existingData['reportTitle'];
//       _reportDescController.text = existingData['reportDesc'];
//     }
//     showModalBottomSheet(
//         elevation: 5,
//         isScrollControlled: true,
//         context: context,
//         builder: (_) => Container(
//               padding: EdgeInsets.only(
//                   top: 30,
//                   left: 15,
//                   right: 15,
//                   bottom: MediaQuery.of(context).viewInsets.bottom + 50),
//               color: serenityBlack,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   TextField(
//                     controller: _reportTitleController,
//                     decoration:
//                         customInputDecoration('Judul', Icons.abc).copyWith(),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   TextField(
//                     controller: _reportDescController,
//                     decoration: customInputDecoration('Deskripsi', Icons.abc),
//                   ),
//                   const SizedBox(height: 10),
//                   RectangleButton(
//                     color: serenitySecondary,
//                     shadowColor: serenityPrimary,
//                     text: reportId == null ? 'Tambahkan Data' : 'Perbarui',
//                     onTap: () async {
//                       if (reportId == null) {
//                         await _addData();
//                       }
//                       if (reportId != null) {
//                         await _updateData(reportId);
//                       }
//                       _reportTitleController.text = '';
//                       _reportDescController.text = '';
// //hide bottom sheet
//                       Navigator.of(context).pop();
//                     },
//                   )
//                 ],
//               ),
//             ));
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Report Page'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _allReportData.length,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      _allReportData[index]['reportTitle'],
                      style: serenityTitle,
                    ),
                  ),
                  subtitle: Text(_allReportData[index]['reportDesc']),
                  trailing: IconButton(
                    onPressed: () =>
                        _deleteData(_allReportData[index]['reportId']),
                    icon:
                        const Icon(Icons.delete_forever, color: serenityWhite),
                  ),
                ),
              ),
            ),
      //       floatingActionButton: FloatingActionButton(
      //   onPressed: () => showBottomSheet(null),
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

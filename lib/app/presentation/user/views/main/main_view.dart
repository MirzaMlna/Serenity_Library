// ignore_for_file: use_build_context_synchronously, avoid_print, duplicate_ignore

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:serenity/app/presentation/db_helper/ebook_helper/budha_db_helper.dart';
import 'package:serenity/app/presentation/db_helper/ebook_helper/hindu_db_helper.dart';
import 'package:serenity/app/presentation/db_helper/ebook_helper/islam_db_helper.dart';
import 'package:serenity/app/presentation/db_helper/ebook_helper/konghucu_db_helper.dart';
import 'package:serenity/app/presentation/db_helper/ebook_helper/kristen_db_helper.dart';
import 'package:serenity/app/presentation/db_helper/report_helper/report_db_helper.dart';
import 'package:serenity/app/utlis/color_pallete.dart';
import 'package:serenity/app/widgets/buttons.dart';
import 'package:serenity/app/utlis/input_decoration.dart';
import 'package:serenity/app/widgets/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final user = FirebaseAuth.instance.currentUser!;
  List<Map<String, dynamic>> _allReportData = [];
  List<Map<String, dynamic>> _allIslamBookData = [];
  List<Map<String, dynamic>> _allKristenBookData = [];
  List<Map<String, dynamic>> _allHinduBookData = [];
  List<Map<String, dynamic>> _allBudhaBookData = [];
  List<Map<String, dynamic>> _allKonghucuBookData = [];
  //get all report data

  void _refreshReportData() async {
    final data = await ReportSQLHelper.getAllData();
    setState(() {
      _allReportData = data;
    });
  }

  void _refreshIslamBookData() async {
    final data = await IslamEBookSQLHelper.getAllIslamEBooks();
    setState(() {
      _allIslamBookData = data;
    });
  }

  void _refreshKristenBookData() async {
    final data = await KristenEBookSQLHelper.getAllkristenEBooks();
    setState(() {
      _allKristenBookData = data;
    });
  }

  void _refreshHinduBookData() async {
    final data = await HinduEBookSQLHelper.getAllhinduEBooks();
    setState(() {
      _allHinduBookData = data;
    });
  }

  void _refreshBudhaBookData() async {
    final data = await BudhaEBookSQLHelper.getAllbudhaEBooks();
    setState(() {
      _allBudhaBookData = data;
    });
  }

  void _refreshKonghucuBookData() async {
    final data = await KonghucuEBookSQLHelper.getAllkonghucuEBooks();
    setState(() {
      _allKonghucuBookData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshReportData();
    _refreshIslamBookData();
    _refreshKristenBookData();
    _refreshHinduBookData();
    _refreshBudhaBookData();
    _refreshKonghucuBookData();
  }

//add data
  Future<void> _addData() async {
    try {
      await ReportSQLHelper.createData(
          _reportTitleController.text, _reportDescController.text);
      _refreshReportData();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Center(
            child: Text(
              'Laporan dikirim',
              style: serenityTitle,
            ),
          )));
    } catch (e) {
      print('Error adding data: $e');
      // Show an error message to the user
    }
  }

//update data
  Future<void> _updateData(int reportId) async {
    try {
      await ReportSQLHelper.updateData(
          reportId, _reportTitleController.text, _reportDescController.text);
      _refreshReportData();
    } catch (e) {
      print('Error updating data: $e');
      // Show an error message to the user
    }
  }

// //delete data
//   void _deleteData(int reportId) async {
//     await ReportSQLHelper.deleteData(reportId);
//     // ignore: use_build_context_synchronously
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         backgroundColor: Colors.red,
//         content: Center(
//           child: Text(
//             'Pesan Laporan Berhasil Dihapus',
//             style: serenityTitle,
//           ),
//         )));
//     _refreshReportData();
//   }

  final TextEditingController _reportTitleController = TextEditingController();
  final TextEditingController _reportDescController = TextEditingController();

  void showBottomSheet(int? reportId) async {
    if (reportId != null) {
      final existingData = _allReportData
          .firstWhere((element) => element['reportId'] == reportId);
      _reportTitleController.text = existingData['reportTitle'];
      _reportDescController.text = existingData['reportDesc'];
    }
    showModalBottomSheet(
        elevation: 5,
        isScrollControlled: true,
        context: context,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                  top: 30,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 50),
              color: serenityBlack,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _reportTitleController,
                    decoration:
                        customInputDecoration('Judul Laporan', Icons.abc)
                            .copyWith(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _reportDescController,
                    decoration: customInputDecoration('Laporan', Icons.abc),
                  ),
                  const SizedBox(height: 10),
                  RectangleButton(
                    color: serenitySecondary,
                    shadowColor: serenityPrimary,
                    text: reportId == null ? 'Tambahkan Data' : 'Perbarui',
                    onTap: () async {
                      if (reportId == null) {
                        await _addData();
                      }
                      if (reportId != null) {
                        await _updateData(reportId);
                      }
                      _reportTitleController.text = '';
                      _reportDescController.text = '';
//close bottom sheet
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.person),
        title: Text(
          user.email.toString(),
          style: serenityTitle,
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 100,
            padding: const EdgeInsets.only(top: 20),
            width: double.infinity,
            decoration: const BoxDecoration(
                color: serenityPrimary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: serenityPrimary,
                      offset: Offset(0, 0),
                      blurRadius: 10)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TopMenu(
                    onTap: () => showBottomSheet(null),
                    icon: CupertinoIcons.exclamationmark_circle,
                    text: 'Laporkan'),
                TopMenu(
                    onTap: () {},
                    icon: CupertinoIcons.bookmark,
                    text: 'Bookmark'),
                TopMenu(
                    onTap: () {},
                    icon: CupertinoIcons.goforward,
                    text: 'Riwayat '),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Islam E Book',
                style: serenityHeader,
              ),
            ),
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              itemCount: _allIslamBookData.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      final url = _allIslamBookData[index]['islamEBookPdf'];
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        // Gagal membuka tautan
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Gagal membuka tautan',
                              style: serenityTitle,
                            ),
                          ),
                        );
                        // ignore: avoid_print
                        print('waluh');
                      }
                    },
                    splashColor: serenityPrimary,
                    child: Container(
                      height: 200,
                      width: 150,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: serenityWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          _allIslamBookData[index]['islamEBookCover'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(_allIslamBookData[index]['islamEBookTitle']),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Kristen E Book',
                style: serenityHeader,
              ),
            ),
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              itemCount: _allKristenBookData.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      final url = _allKristenBookData[index]['kristenEBookPdf'];
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        // Gagal membuka tautan
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Gagal membuka tautan',
                              style: serenityTitle,
                            ),
                          ),
                        );
                        // ignore: avoid_print
                        print('waluh');
                      }
                    },
                    splashColor: serenityPrimary,
                    child: Container(
                      height: 200,
                      width: 150,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: serenityWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          _allKristenBookData[index]['kristenEBookCover'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(_allKristenBookData[index]['kristenEBookTitle']),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Hindu E Book',
                style: serenityHeader,
              ),
            ),
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              itemCount: _allHinduBookData.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      final url = _allHinduBookData[index]['hinduEBookPdf'];
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        // Gagal membuka tautan
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Gagal membuka tautan',
                              style: serenityTitle,
                            ),
                          ),
                        );
                        // ignore: avoid_print
                        print('waluh');
                      }
                    },
                    splashColor: serenityPrimary,
                    child: Container(
                      height: 200,
                      width: 150,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: serenityWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          _allHinduBookData[index]['hinduEBookCover'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(_allHinduBookData[index]['hinduEBookTitle']),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Budha E Book',
                style: serenityHeader,
              ),
            ),
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              itemCount: _allBudhaBookData.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      final url = _allBudhaBookData[index]['budhaEBookPdf'];
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        // Gagal membuka tautan
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Gagal membuka tautan',
                              style: serenityTitle,
                            ),
                          ),
                        );
                        // ignore: avoid_print
                        print('waluh');
                      }
                    },
                    splashColor: serenityPrimary,
                    child: Container(
                      height: 200,
                      width: 150,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: serenityWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          _allBudhaBookData[index]['budhaEBookCover'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(_allBudhaBookData[index]['budhaEBookTitle']),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Konghucu E Book',
                style: serenityHeader,
              ),
            ),
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              itemCount: _allKonghucuBookData.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      final url =
                          _allKonghucuBookData[index]['konghucuEBookPdf'];
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        // Gagal membuka tautan
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Gagal membuka tautan',
                              style: serenityTitle,
                            ),
                          ),
                        );
                        // ignore: avoid_print
                        print('waluh');
                      }
                    },
                    splashColor: serenityPrimary,
                    child: Container(
                      height: 200,
                      width: 150,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: serenityWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          _allKonghucuBookData[index]['konghucuEBookCover'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(_allKonghucuBookData[index]['konghucuEBookTitle']),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}

//Top Option
class TopMenu extends StatelessWidget {
  const TopMenu({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.text,
  }) : super(key: key);
  final VoidCallback onTap;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
            color: serenityWhite,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: serenityTitle,
          )
        ],
      ),
    );
  }
}

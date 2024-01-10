import 'package:flutter/material.dart';
import 'package:serenity/app/presentation/db_helper/ebook_helper/konghucu_db_helper.dart';
import 'package:serenity/app/utlis/color_pallete.dart';
import 'package:serenity/app/utlis/input_decoration.dart';
import 'package:serenity/app/widgets/buttons.dart';
import 'package:serenity/app/widgets/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class KonghucuAddView extends StatefulWidget {
  const KonghucuAddView({Key? key}) : super(key: key);

  @override
  State<KonghucuAddView> createState() => _KonghucuAddViewState();
}

class _KonghucuAddViewState extends State<KonghucuAddView> {
  List<Map<String, dynamic>> _allEbookData = [];

  void _refreshData() async {
    final data = await KonghucuEBookSQLHelper.getAllkonghucuEBooks();
    setState(() {
      _allEbookData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _addEbookData() async {
    await KonghucuEBookSQLHelper.createkonghucuEBook(_eBookTitleController.text,
        _eBookLinkController.text, _eBookCoverController.text);
    _refreshData();
  }

  Future<void> _updateEbookData(int id) async {
    await KonghucuEBookSQLHelper.updatekonghucuEBook(
        id,
        _eBookTitleController.text,
        _eBookLinkController.text,
        _eBookCoverController.text);
    _refreshData();
  }

  Future<void> _deleteEbookData(int id) async {
    await KonghucuEBookSQLHelper.deletekonghucuEBook(id);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Ebook Berhasil Dihapus',
          style: serenityTitle,
        )));
    _refreshData();
  }

  final TextEditingController _eBookTitleController = TextEditingController();
  final TextEditingController _eBookLinkController = TextEditingController();
  final TextEditingController _eBookCoverController = TextEditingController();

  void showBottomSheet(int? id) async {
    if (id != null) {
      final existingData =
          _allEbookData.firstWhere((element) => element['id'] == id);
      _eBookTitleController.text = existingData['konghucuEBookTitle'];
      _eBookLinkController.text = existingData['konghucuEBookPdf'];
      _eBookCoverController.text = existingData['konghucuEBookCover'];
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
                  TextFormField(
                      controller: _eBookTitleController,
                      decoration: customInputDecoration(
                          'Judul Buku', Icons.title_rounded)),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: _eBookLinkController,
                      decoration:
                          customInputDecoration('Book Link', Icons.link)),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: _eBookCoverController,
                      decoration:
                          customInputDecoration('Cover Link', Icons.link)),
                  const SizedBox(
                    height: 20,
                  ),
                  RectangleButton(
                      color: serenitySecondary,
                      shadowColor: serenityPrimary,
                      text: 'Masukkan',
                      onTap: () async {
                        if (id == null) {
                          await _addEbookData();
                        }
                        if (id != null) {
                          await _updateEbookData(id);
                        }
                        // _eBookTitleController.text = '';
                        // _eBookLinkController.text = '';
                        // _eBookCoverController.text = '';
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      })
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add konghucu E-Book')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              RectangleButton(
                color: serenityPrimary,
                shadowColor: serenitySecondary,
                text: 'Tambahkan Data',
                onTap: () => showBottomSheet(null),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 80,
                child: ListView.builder(
                    itemCount: _allEbookData.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => SizedBox(
                          child: Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    _deleteEbookData(
                                        _allEbookData[index]['id']);
                                  },
                                  icon: const Icon(Icons.delete)),
                              Row(
                                children: [
                                  Text(_allEbookData[index]
                                      ['konghucuEBookTitle']),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: _allEbookData.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Column(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () async {
                          final url = _allEbookData[index]['konghucuEBookPdf'];
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
                              _allEbookData[index]['konghucuEBookCover'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Text(_allEbookData[index]['konghucuEBookTitle']),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

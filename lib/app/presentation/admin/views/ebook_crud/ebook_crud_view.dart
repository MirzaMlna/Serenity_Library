import 'package:flutter/material.dart';
import 'package:serenity/app/presentation/admin/views/ebook_crud/ebook_add/budha_add_view.dart';
import 'package:serenity/app/presentation/admin/views/ebook_crud/ebook_add/hindu_add_view.dart';
import 'package:serenity/app/presentation/admin/views/ebook_crud/ebook_add/islam_add_view.dart';
import 'package:serenity/app/presentation/admin/views/ebook_crud/ebook_add/konghucu_add_view.dart';
import 'package:serenity/app/presentation/admin/views/ebook_crud/ebook_add/kristen_add_view.dart';
import 'package:serenity/app/widgets/text_style.dart';

class EBookCrud extends StatefulWidget {
  const EBookCrud({super.key});

  @override
  State<EBookCrud> createState() => _EBookCrudState();
}

class _EBookCrudState extends State<EBookCrud> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User Report Page'),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Islam',
                      style: serenityHeader,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const IslamAddView())));
                        },
                        icon: const Icon(Icons.add)),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Kristen',
                      style: serenityHeader,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const KristenAddView())));
                        },
                        icon: const Icon(Icons.add)),
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
                child: Row(
                  children: [
                    Text(
                      'Hindu',
                      style: serenityHeader,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const HinduAddView())));
                        },
                        icon: const Icon(Icons.add)),
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
                child: Row(
                  children: [
                    Text(
                      'Budha',
                      style: serenityHeader,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const BudhaAddView())));
                        },
                        icon: const Icon(Icons.add)),
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
                child: Row(
                  children: [
                    Text(
                      'Konghucu',
                      style: serenityHeader,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const KonghucuAddView())));
                        },
                        icon: const Icon(Icons.add)),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}

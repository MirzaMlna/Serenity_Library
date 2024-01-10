import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:serenity/app/presentation/admin/views/ebook_crud/ebook_crud_view.dart';
import 'package:serenity/app/presentation/admin/views/report/admin_report_view.dart';
import 'package:serenity/app/utlis/color_pallete.dart';
import 'package:serenity/app/widgets/text_style.dart';

class AdminMainView extends StatefulWidget {
  const AdminMainView({super.key});

  @override
  State<AdminMainView> createState() => _AdminMainViewState();
}

class _AdminMainViewState extends State<AdminMainView> {
  final user = FirebaseAuth.instance.currentUser!;
  void adminLogOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hai ${user.email.toString()}',
          style: serenityTitle,
        ),
        actions: [
          IconButton(
              onPressed: adminLogOut,
              icon: const Icon(CupertinoIcons.square_arrow_left))
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AdminCard(
                  pageTarget: EBookCrud(),
                  title: 'E-Book CRUD',
                  icon: Icons.edit_note_rounded),
              SizedBox(
                height: 10,
              ),
              AdminCard(
                  pageTarget: AdminReportView(),
                  title: 'Users Report',
                  icon: CupertinoIcons.exclamationmark_circle),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminCard extends StatelessWidget {
  const AdminCard({
    Key? key,
    required this.pageTarget,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final Widget pageTarget;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: serenitySecondary,
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: serenityBlack,
              blurRadius: 10.0,
            ),
          ],
        ),
        child: InkWell(
          excludeFromSemantics: true,
          borderRadius: BorderRadius.circular(10),
          highlightColor: serenityPrimary,
          splashColor: Colors.white.withOpacity(0.5),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => pageTarget));
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: serenityHeader,
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(icon),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

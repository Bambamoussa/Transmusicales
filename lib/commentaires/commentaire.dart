import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:tp3/commentaires/commentaire_liste.dart';
import 'package:tp3/provider/commentaire_provider.dart';


class Commentaire extends StatefulWidget {
  final String recordid;

  const Commentaire({Key? key, required this.recordid}) : super(key: key);

  @override
  _CommentaireState createState() => _CommentaireState();
}

class _CommentaireState extends State<Commentaire> {
  TextEditingController commentaireController = TextEditingController();

  Future<void> addCommentaire() async {
    if (commentaireController.text.length > 0) {
      ProgressDialog pr = ProgressDialog(context: context);
      print("dddddddddddddddddddddddddddddddddddddd ${commentaireController.text}");
      pr.show(
          max: 100,
          msg: 'commentaire sending...',
          progressType: ProgressType.valuable,
          backgroundColor: Color(0xff212121),
          progressValueColor: Color(0xff3550B4),
          progressBgColor: Colors.white70,
          msgColor: Colors.white,
          valueColor: Colors.white);
      await Future.delayed(Duration(milliseconds: 3000));
      for (int i = 0; i <= 100; i++) {
        /// You can indicate here that the download has started.
        pr.update(value: i, msg: 'commentaire sending...');
        i++;
        await Future.delayed(Duration(milliseconds: 100));
      }
      await Provider.of<CommentaireProvider>(context, listen: false)
          .commentaire(widget.recordid, commentaireController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('commentaire ajouté'),
          backgroundColor: Colors.green,
        ),
      );
      commentaireController.clear();
    }
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 16.0, bottom: 6.0),
                  hintText: "Tapez un commentaire",
                  border: InputBorder.none,
                ),
                textCapitalization: TextCapitalization.sentences,
                controller: commentaireController,
              ),
            ),
            Container(
              height: 30.0,
              width: 30.0,
              margin: EdgeInsets.only(left: 4.0, right: 4.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.greenAccent),
              child: IconButton(
                icon: Icon(
                  Icons.send,
                  size: 20.0,
                  color: Colors.white,
                ),
                onPressed: () => addCommentaire(),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0,),
        FlatButton(onPressed: (){
          Navigator.pushNamed(context, CommentaireListe.routeName, arguments: widget.recordid);
        },
          color: Colors.yellow,
          child: const Text("voir commentaires"),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)
          ),
        ),
      ],
    );
  }
}

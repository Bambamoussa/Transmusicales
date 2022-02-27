import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp3/form/connexion.dart';
import 'package:tp3/home/home_screen.dart';
import 'package:tp3/provider/user_provider.dart';
class Inscription extends StatefulWidget {
  static const String routeName = '/inscription';
  const Inscription({Key? key}) : super(key: key);

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  String email = "";
  String password = " ";
  String username = " ";
  final _formkey = GlobalKey<FormState>();
Future<void> submitForm()async {
  UserProvider userProvider = Provider.of<UserProvider>(context,listen: false);
  if(_formkey.currentState!.validate()){
    final _result =  await userProvider.registerWithEmailAndPassword(email,password,username);
    if(_result != null) {
      Navigator.pushNamed(context, HomeScreen.routeName,arguments: username);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('cet utilisateur existe déja'), backgroundColor: Colors.red,),
      );
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("TRANSMUSICAL"),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 200.0,horizontal: 40.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "email",
                      border: OutlineInputBorder()
                  ),
                  validator: (value) => EmailValidator.validate(value!) ? null : "veuillez entrer un email valide",
                  onChanged: (value)=> email = value,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "password",
                      border: OutlineInputBorder()
                  ),
                  validator: (value)  {
                    if(value == null || value!.isEmpty){
                      return "veuillez entrer un password";
                    }

                  },
                  onChanged: (value)=> password = value,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "username",
                      border: OutlineInputBorder()
                  ),
                  validator: (value)  {
                    if(value == null || value!.isEmpty){
                      return "veuillez entrer un username";
                    }

                  },
                  onChanged: (value)=> username = value,
                ),
                FlatButton(onPressed:submitForm,
                  color: Colors.yellow,
                  child: const Text("inscription"),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(20.0)
                   ),
                ),
                OutlineButton(onPressed: (){
                  Navigator.pushNamed(context, Connexion.routeName);
                },
                  borderSide: const BorderSide(width: 1.0,color: Colors.black),
                  color: Colors.yellow,
                  child: const Text(" vous aviez déja un compte"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                )
              ],
            ),
          ),

        ),
      ),
    );
  }
}


/*
class Inscription extends StatefulWidget {
  static const String routeName = '/inscription';
  Inscription({Key? key}) : super(key: key);
  @override
  @override
  _InscriptionState createState() => _InscriptionState();
}
class _InscriptionState extends State<Inscription>{
  void action(){
    print("fffff");
  }
  final _globalKey = GlobalKey<FormState>();
  String email = "";
  String password = " ";
  String username = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("TWISTIC"),
    backgroundColor: Colors.blueGrey,
    ),
    backgroundColor:  Colors.blueGrey,
      body: Form(
        key: _globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            const Align(
              widthFactor: 3,
              child: Text(
                'email',
                style: TextStyle(

                ),
              ),
            ),

             Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your Email',
                ),
                 validator: (value) {
                  if(value == " "){
                    return "veuillez entrez un email";
                  }
                 },
                 onChanged: (value) => email = value,
              ),
            ),
            const Align(
              widthFactor: 2,
              child: Text(
                'password',
                style: TextStyle(

                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:25, vertical: 15),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your password',
                ),
                validator: (value) {
                  if(value == " "){
                    return "veuillez entrez un password";
                  }
                },
                onChanged: (value) => password = value,
                obscureText: true,
              ),
            ),

            const Align(
              widthFactor: 2,
              child: Text(
                'username',
                style: TextStyle(

                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:25, vertical: 15),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your username',
                ),
                validator: (value) {
                  if(value == " "){
                    return "veuillez entrez un email";
                  }
                },
                onChanged: (value) => username = value,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: action,
                  child: const Text("inscription"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                  ),
                )
              ],
            )
          ],
        ),
      )

      );
  }


}
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp3/home/home_screen.dart';
import 'package:tp3/provider/user_provider.dart';
import 'package:email_validator/email_validator.dart';


import 'inscription.dart';
class Connexion extends StatefulWidget {
  static const String routeName = '/';
  const Connexion({Key? key}) : super(key: key);

  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  String email = "";
  String password = "";
  String username = "";
  final _formkey = GlobalKey<FormState>();
  Future <void> submitForm()async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    if(_formkey.currentState!.validate()){
      final _result = await userProvider.signInWithEmailAndPassword(email, password);
      username = await userProvider.fetchUsername();
      if (_result != null) {
        Navigator.pushNamed(context, HomeScreen.routeName, arguments: username);
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('mot de passe  ou email invalide'), backgroundColor: Colors.red,),
        );
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TRANSMUSICAL"),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 200.0,horizontal: 40.0),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  obscureText: true,
                  validator: (value){
                    if(value == null || value!.isEmpty){
                      return "veuillez entrer un password";
                    }
                  },
                  onChanged: (value)=> password = value,
                ),
               const  SizedBox(
                  height: 10,
                ),
                FlatButton(onPressed: submitForm,
                  color: Colors.yellow,
                  child: const Text("connexion"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                ),
                OutlineButton(onPressed: (){
                  Navigator.pushNamed(context, Inscription.routeName);
                },
                  borderSide: BorderSide(width: 1.0,color: Colors.black),
                  color: Colors.yellow,
                  child: const Text("vous n' avez pas de compte"),
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
class Connexion extends StatelessWidget {
  static const String routeName = '/connexion';
  final _globalKey = Values().getKey("signIn");
   Connexion({Key? key}) : super(key: key);
  void action(){
    print("fffff");
  }


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

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your Email',
              ),
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
              obscureText: true,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(onPressed: action,
                child: const Text("connection"),
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

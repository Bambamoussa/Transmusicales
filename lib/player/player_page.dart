import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Player extends StatefulWidget {
  static const String routeName = '/player';
  const Player({Key? key}) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              ImageAuthor(),
              PlayerControler(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MusicControllerButtonSection(),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const Text("TRANSMUSICAL"),
    backgroundColor: Colors.blue,
    actions: [
    IconButton(
    icon: Icon(
    Icons.more_vert,
    color: Colors.white,
    ),
    onPressed: null,
    ),
    ],
    );
  }
}

class ImageAuthor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: 550.0,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/fally.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 60.0,
            left: 130,
            child: TitleSection(),
          ),
          ArtistPictureSection(),
        ],
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Artiste",
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w300,
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
          Text(
            'Ariana Grande',
            style: GoogleFonts.lato(
                fontWeight: FontWeight.w800,
                fontSize: 17.0,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class ArtistPictureSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      margin: const EdgeInsets.only(top: 200),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 65.0,
            child: Container(
              height: 250,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: const BorderRadius.only(topRight: Radius.circular(50)),
              ),
            ),
          ),
          Positioned(
            top: 50.0,
            child: Container(
              height: 275,
              width: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/fally.jpeg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.blue.withOpacity(0.5), BlendMode.darken),
                ),
                borderRadius: const BorderRadius.only(topRight: Radius.circular(50)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerControler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PlayingMusicTitle(),
          MusicSliderSection(),
          DurationSection(),
        ],
      ),
    );
  }
}

class PlayingMusicTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Text(
            'Save yours tears',
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w700,
              fontSize: 25.0,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Text(
            'Ariana Grande',
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}

class MusicSliderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Slider(
        value: 19,
        min: 1.0,
        max: 100,
        activeColor: Colors.blue,
        inactiveColor: Colors.grey,
        onChanged: (double newValue) {},
      ),
    );
  }
}

class DurationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 27, right: 27, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '1.30',
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
          Text(
            '3.11',
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}

class MusicControllerButtonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 15),
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.shuffle,
              color: Colors.grey,
              size: 35,
            ),
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.skip_previous,
              color: Colors.black,
              size: 40,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.pause,
                color: Colors.blue  ,
                size: 40,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: const CircleBorder(),
              side: const BorderSide(
                width: 1.0,
                color: Colors.grey,
              ),
            ),
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.skip_next,
              color: Colors.black,
              size: 40,
            ),
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.repeat,
              color: Colors.grey,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}

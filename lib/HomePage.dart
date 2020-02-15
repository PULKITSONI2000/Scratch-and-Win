import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //TODO: import images

  AssetImage circle = AssetImage("images/circle.png");
  AssetImage lucky = AssetImage("images/rupee.png");
  AssetImage unlucky = AssetImage("images/sadFace.png");


  //TODO: get an array

  List<String> itemArray;
  int luckyNumber;
  int chancesLeft;
  String message;


  //TODO: init array with 25 element

  @override
  void initState() {
    super.initState();
    itemArray = List<String>.generate(25,(index)=>"empty");
    generateRendomNumber();
  }

  generateRendomNumber(){
      int random = Random().nextInt(25);
      setState(() {
        luckyNumber = random;
        chancesLeft = 5;
        message = "";
      });
    }


  //TODO: define a getimage
  AssetImage getImage(int index){
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
          return lucky;
        break;
      case "unlucky":
          return unlucky;
        break;
    }
    return circle;
  }


  //TODO: play game method

  playGame(int index){
    
    if(itemArray[index] != "unlucky" ){
      chancesLeft = chancesLeft-1;
    }
    if(chancesLeft <= 0){
      message = "GAME OVER";
      showAll();
        Timer(Duration(seconds: 3), (){
          resetGame();
        });
    }

    if(luckyNumber == index){
      setState(() {
        itemArray[index] = "lucky";
        message = "YOU WON";
        showAll();
        Timer(Duration(seconds: 3), (){
          resetGame();
        });
        
      }
      );
    }else{
      setState(() {
        itemArray[index] = "unlucky";
      });
    }
    
  }

  //TODO: showall

  showAll(){
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckyNumber] = "lucky";
    });
  }


  //TODO: reset all

  resetGame(){
    setState(() {
      itemArray = List<String>.filled(25, "empty");
    });
    generateRendomNumber();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scratch and Win"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,                
              ),
              itemCount: itemArray.length,
              itemBuilder: (context,i) => SizedBox(
                width: 50.0,
                height: 50.0,
                child: RaisedButton(
                  onPressed: (){
                    this.playGame(i);
                  },
                  child: Image(
                    image: this.getImage(i),
                  ),
                ),
              ),
            )
          ),
          
          Center(
            child: Text("$chancesLeft Chances left",
              style: TextStyle(
                fontSize: 35.0,
                color: Colors.pink,
              ),
            ),
          ),
          Center(
            child: Text("$message",
              style: TextStyle(
                fontSize: 35.0,
                color: Colors.red
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: (){
                this.showAll();
              },
              color: Colors.pink,
              padding: EdgeInsets.all(20.0),
              child: Text("Show All",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: (){
                this.resetGame();
              },
              color: Colors.pink,
              padding: EdgeInsets.all(20.0),
              child: Text("Reset Game",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
          Center(
            child: Text("LearnCodeOnline.in",
              style: TextStyle(
                backgroundColor: Colors.black,
                color: Colors.white,
                fontSize: 30.0
              ),
            ),
          )
        ],
      ),
    );
  }
}
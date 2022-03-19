import 'package:flutter/material.dart';
import 'package:homework12/models/foods_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final foodsModel food = foodsModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FLUTTER FOOD'),
      ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: _handleClickButton,
              child: Text('LOAD FOODS DATA'),
            ),
            SizedBox(height: 20.0,),
            _viewFoods(),
          ]
      ),
    );
  }

  Future<void> _handleClickButton() async {
    final Uri url = Uri.parse('https://cpsu-test-api.herokuapp.com/foods');
    var result = await http.get(url);
    var json = jsonDecode(result.body);
    setState(() {
      food.setData(json['data']);
    });
  }

  Widget _viewFoods() {
    return Flexible(
      child: ListView.builder(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0,),
          shrinkWrap: true,
          itemCount: food.getLength(),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: InkWell(
                onTap: () {
                },
                child: Row(
                  children: [
                    Image.network(food.getImage(index).toString(), width: 125.0,),
                    SizedBox(width: 10.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${food.getName(index)}", style: TextStyle(fontSize: 30.0,),),
                        Text("${food.getPrice(index)} บาท", style: TextStyle(fontSize: 20.0),),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
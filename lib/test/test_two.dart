import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class TestTwo extends StatefulWidget {
  const TestTwo({super.key});

  @override
  State<TestTwo> createState() => _TestTwoState();
}

class _TestTwoState extends State<TestTwo> {
  late List myList;
  ScrollController _scrollController = ScrollController();

  int _currenMax = 10;

  @override
  void initState() {
    // TODO: implement initState
    myList = List.generate(10, (i) => "Item : ${i + 1}");
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _getMoreData();
        }
      },
    );

    super.initState();
  }

  _getMoreData() {
    for (int i = _currenMax; i < _currenMax + 10; i++) {
      myList.add("Item : ${i + 1}");
    }
    _currenMax = _currenMax + 10;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemExtent: 80,
        itemBuilder: (context, i) {
          if (i == myList.length) {
            return const CupertinoActivityIndicator(
              color: Colors.amber,
              radius: 20,
            );
          }
          return ListTile(
            title: Text(
              myList[i],
            ),
          );
        },
        itemCount: myList.length + 1,
      ),
    );
  }
}

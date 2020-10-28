import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recruit_test/home/elementui.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
          child: Scaffold(
        appBar: AppBar(
          title: Text('Cars List'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Total list',
              ),
              Tab(text: 'Ford and 500 price',),
              Tab(text: '400 price',)
            ],
          ),
        ),
        body: TabBarView(
        children: [
          ElementUI(stream: FirebaseFirestore.instance.collection('testdata').snapshots(),),
          ElementUI(stream: FirebaseFirestore.instance.collection('testdata').where('car',isEqualTo:'ford').where('price',isEqualTo: 500).snapshots(),),
          ElementUI(stream: FirebaseFirestore.instance.collection('testdata').where('price',isEqualTo: 400).snapshots(),),

        ],
        )
      ),
    );
  }
}
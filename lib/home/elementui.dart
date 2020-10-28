import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ElementUI extends StatefulWidget {
   final Stream stream;

  const ElementUI({Key key, @required this.stream}) : super(key: key);
 
  @override
  _ElementUIState createState() => _ElementUIState();
}

class _ElementUIState extends State<ElementUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: widget.stream,
        builder: (context,carscollection){
          if(carscollection.hasError){
            return Center(
              child: Text('An error has occured'),
            );
          }else if(!carscollection.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return ListView.builder(
              itemCount: carscollection.data.docs.length,
              itemBuilder: (context,index){
                DocumentSnapshot doc=carscollection.data.docs[index];
                return ListTile(
                  title: Text(doc.data()['car']),
                  subtitle: Text(doc.data()['price'].toString()),
                );
              },
            );
          }
        },
      ),
    );
  }
}
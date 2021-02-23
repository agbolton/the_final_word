import 'package:flutter/material.dart';
import '../../services/get_name.dart';

class MyGirl extends StatefulWidget {
  @override
  _MyGirlState createState() => _MyGirlState();
}

class _MyGirlState extends State<MyGirl> {
  @override
  Widget build(BuildContext context) {
    //return _buildBody(context);
    // return Center(
    //   child: returnGirlName(context)
    // );
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 220.0),
            child: returnGirlName(context)
          ),
          Padding(
            padding: EdgeInsets.only(top: 175.0),
            child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.stop_circle_outlined),
                    color: Colors.red,
                    iconSize: 80,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.help),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.check_box),
                    color: Colors.green,
                    iconSize: 80,
                    onPressed: () {},
                  )
                  ])
            )
        ])
      );
  }
}





// Widget _buildBody(BuildContext context) {
//   return StreamBuilder<QuerySnapshot>(
//     stream: FirebaseFirestore.instance
//         .collection('baby names')
//         .where('gender', isEqualTo: 'female')
//         .limit(1)
//         .snapshots(),
//     builder: (context, snapshot) {
//       if (!snapshot.hasData) return LinearProgressIndicator();
//       return _buildList(context, snapshot.data.docs);
//     },
//   );
// }



// Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//   return ListView(
//     padding: const EdgeInsets.all(50),
//     children: snapshot.map((data) => _buildListItem(context, data)).toList(),
//   );
// }

// Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//   var gender = data.data()['gender'].toString();

//   if (gender != "female") {
//     print("here");
//   }

//   var name = data.data()['name'].toString();
//   print(name);
//   print(gender);

//   return Padding(
//     key: ValueKey(data.data()['name']),
//     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 200.0),
//     child: Container(
//       height: 500,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(5.0),
//       ),
//       child: GestureDetector(
//         child: Text(name)
//       ),
//     ),
//   );
// }
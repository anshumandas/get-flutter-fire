import 'package:flutter/material.dart';
import 'package:bucketlist/services/firestoreservices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bucketlist/screens/Loginscreen.dart'; 

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _HomePageState();
}

class _HomePageState extends State<Mainscreen> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController textController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  void openBucketItemBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: InputDecoration(hintText: "Enter bucket list item"),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (docID == null) {
                firestoreService.addBucketListItem(
                    textController.text, user?.uid ?? '');
              } else {
                firestoreService.updateBucketListItem(docID, textController.text);
              }
              textController.clear();
              Navigator.pop(context);
            },
            child: Text(docID == null ? "Add" : "Update"),
          )
        ],
      ),
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginScreen(), // Navigate to login screen
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bucket List"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: signOut,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openBucketItemBox,
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Welcome, ${user?.email ?? 'User'}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestoreService.getBucketListStream(user?.uid ?? ''),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                  
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No bucket list items found"));
                }
                List bucketListItems = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: bucketListItems.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = bucketListItems[index];
                    String docID = document.id;
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    String itemText = data['item'];

                    return ListTile(
                      title: Text(itemText),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => openBucketItemBox(docID: docID),
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () => firestoreService.deleteBucketListItem(docID),
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

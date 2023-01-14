import 'dart:convert';

import 'package:api_integration/postmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  Post? _post;
  TextEditingController nameController= TextEditingController();
  TextEditingController jobController= TextEditingController();

  Future<Post?>submitData(String name,String job)async{
    var response=await http.post(Uri.https('reqres.in','api/users'),body: json.encode({
      'name':name,
      'job': job,
    }),headers: { 'Content-type': 'application/json',
      'Accept': 'application/json'}
    );
    var data=response.body;
    print(data);
    if(response.statusCode==201){
      String stringResponse=response.body;
      postFromJson(stringResponse);
      print(stringResponse);
    } else {
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP POST'),
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
              controller: nameController,
            ),
            const SizedBox(height: 20,),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'job',
              ),
              controller: jobController,
            ),
            const SizedBox(height: 20,),
            Row(children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: ()async{
                      String name=nameController.text;
                      String job =jobController.text;
                      Post? data = await submitData(name, job);
                      setState(() {
                        _post=data;
                      });
                      },
                    child: const Text('SUBMIT'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

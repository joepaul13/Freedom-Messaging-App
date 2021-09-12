import 'package:chat/screens/chats/components/body.dart';
import 'package:chat/screens/welcome/welcome_screen.dart';
import 'package:chat/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:chat/models/repo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: WelcomeScreen(),
    );
  }
}

Future<All> fetchRepos() async {
  final response = await http.get(Uri.https('https://api.github.com/', 'users/joepaul13/repos'));

  if(response.statusCode == 200) {
    print(response.body);
    return All.fromJson(json.decode(response.body));
  }
  else {
    throw Exception('Failed to Fetch Repo!!');
  }
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<All> futureRepo;
  @override
  void initState() {
    super.initState();
    futureRepo = fetchRepos();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GitHub API"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: FutureBuilder<All>(
            future: futureRepo, 
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                // ignore: deprecated_member_use
                List<Repo> repos = List<Repo>();
                for(int i=0;i<snapshot.data!.repos.length; i++) {
                  repos.add(
                    Repo(
                      name: snapshot.data!.repos[i].name,
                      htmlUrl: snapshot.data!.repos[i].htmlUrl,
                      stargazersCount: snapshot.data!.repos[i].stargazersCount,
                      description: snapshot.data!.repos[i].description
                    )
                  );
                }
                return ListView(
                  children: [repos
                    .map(
                      (r) => Card(
                        color: Colors.blue[300],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween
                                children: [
                                  Text(
                                    r.name,
                                    style: TextStyle(fontSize: 30.0),
                                  ),
                                  Text(r.stargazersCount.toString()),
                                ],
                              )
                              
                              Text(r.htmlUrl),
                              Text(
                                r.description,
                                style: TextStyle(fontSize: 23.0),
                              ),
                              
                            ],),
                        ),
                      )
                    )
                  ],
                );
              }
              else if(snapshot.hasError) {
                Center(
                  child: Text("Error!!")
                );
              }
              else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      )
    );
  }
}


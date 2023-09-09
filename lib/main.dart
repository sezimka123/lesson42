// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:lesson42/features/random_user/bloc/random_user_bloc.dart';
import 'package:lesson42/features/random_user/bloc/random_user_repository_impl.dart';
import 'package:lesson42/features/random_user/use_cases/random_user_use_case.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TabBarExample(),
    );
  }
}

class TabBarExample extends StatefulWidget {
  const TabBarExample({super.key});

  @override
  State<TabBarExample> createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<TabBarExample>
    with TickerProviderStateMixin {
  late TabController tabController;
  Future<Map<String, dynamic>> fetchRandomUser() async {
    final response = await http.get(Uri.parse('https://randomuser.me/api/'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load random user');
    }
  }

  @override
  void initState() {
    tabController = TabController(
      length: 3,
      vsync: this,
    );

    super.initState();
  }

  final RandomUserBloc randomUserBloc = RandomUserBloc(
      RandomUserUseCase(randomUserRepository: RandomUserRepositoryImpl()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('TabBar Example'),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: fetchRandomUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final user = snapshot.data!['results'][0];
              final userImageUrl = user['picture']['large'];
              final userName = user['name']['first'];
              final lastName = user['name']['last'];

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(75),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: Image.network(
                        userImageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  TabBar(
                    controller: tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.purple.shade200,
                    labelStyle: TextStyle(fontSize: 14),
                    tabs: [
                      Tab(text: "Main info"),
                      Tab(text: "Location"),
                      Tab(text: "Email"),
                    ],
                  ),
                  Expanded(
                    flex: 2,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        MainInfoCard(customRowCard:
                          CustomRowCard(
                          title: "",
                          value: userName,
                        ),),
                        LocationCard(),
                        EmailCard(),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      randomUserBloc.add(
                        GetRandomUserInfoEvent(
                          title: "",
                          value: "",
                        ),
                      );
                    },
                    child: Text("Search"),
                  ),
                  Spacer(flex: 1),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class EmailCard extends StatelessWidget {
  const EmailCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.account_balance_wallet_outlined,
      size: 150,
    );
  }
}

class LocationCard extends StatelessWidget {
  const LocationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.ac_unit_outlined,
      size: 150,
    );
  }
}

class MainInfoCard extends StatelessWidget {
  final CustomRowCard customRowCard;
  Future<Map<String, dynamic>> fetchRandomUser() async {
    final response = await http.get(Uri.parse('https://randomuser.me/api/'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load random user');
    }
  }

  const MainInfoCard({
    Key? key,
    required this.customRowCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Map<String, dynamic>>(
        future: fetchRandomUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final user = snapshot.data!['results'][0];
            final userName = user['name']['first'];
            final lastName = user['name']['last'];

            print(snapshot.data);

            return Column(
              children: [
                Icon(
                  Icons.access_alarm_rounded,
                  size: 150,
                ),
                CustomRowCard(
                  title: "name:",
                  value: userName,
                ),
                CustomRowCard(
                  title: "surname:",
                  value: lastName,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class CustomRowCard extends StatelessWidget {
  final String title;
  final String value;

  const CustomRowCard({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

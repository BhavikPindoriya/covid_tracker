import 'package:covid_tracker/Services/state_services.dart';
import 'package:covid_tracker/view/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListState();
}

class _CountryListState extends State<CountryListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServies statesServies = StatesServies();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search with Country name',
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: statesServies.CountresListApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          children: [
                            ListTile(
                                title: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];

                      if (searchController.text.isEmpty) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    name: snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']
                                        ['flag'],
                                    active: snapshot.data![index]['active'],
                                    critical: snapshot.data![index]['critical'],
                                    test: snapshot.data![index]['tests'],
                                    todayRecovered: snapshot.data![index]
                                        ['recovered'],
                                    totalCases: snapshot.data![index]['cases'],
                                    totalDeaths: snapshot.data![index]
                                        ['deaths'],
                                    totalrecovered: snapshot.data![index]
                                        ['todayRecovered'],
                                  ),
                                ));
                          },
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag'])),
                              )
                            ],
                          ),
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                        name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]
                                            ['countryInfo']['flag'],
                                        active: snapshot.data![index]['active'],
                                        critical: snapshot.data![index]
                                            ['critical'],
                                        test: snapshot.data![index]['tests'],
                                        todayRecovered: snapshot.data![index]
                                            ['recovered'],
                                        totalCases: snapshot.data![index]
                                            ['cases'],
                                        totalDeaths: snapshot.data![index]
                                            ['deaths'],
                                        totalrecovered: snapshot.data![index]
                                            ['todayRecovered'],
                                      ),
                                    ));
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag'])),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}

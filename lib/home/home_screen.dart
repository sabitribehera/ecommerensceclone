import 'package:ecommerencetask/home/home_bloc.dart';
import 'package:ecommerencetask/model/home_response.dart';
import 'package:ecommerencetask/services/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {

    // context.read<HomeNotifier>().init();
    HomeNotifier homeNotifier = Provider.of<HomeNotifier>(context, listen: false);
    // homeNotifier.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: providerBody(),
    );
  }


  //region body
  Widget providerBody() {



   return Consumer<HomeNotifier>(
      builder: (context, data, child) {
        // return Text("Hii");

        // get current state
        HomeState value = data.currentState;
        List<HomeResponse> homeResponse = data.homeResponse;

        // failure
        if (value == HomeState.Failed) return const Center(child: Text("Something went wrong!"));

        // success
        if(value == HomeState.Success){
          return ListView.builder(
              itemBuilder: (context, index) {
                return listItem(homeResponse[index]);
              },
              itemCount: homeResponse.length);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );


  }

//endregion
// region listItem

  Widget listItem(HomeResponse homeResponse) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 5.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: Column(
                children: [
                  dataItem("Domain", homeResponse.domains!.join(".")),
                  dataItem("Alpha code", homeResponse.alphaTwoCode!),
                  dataItem("State Province", homeResponse.stateProvince!),
                  dataItem("name", homeResponse.name!),
                  dataItem("web_pages", homeResponse.webPages!.join(", ")),
                ],
              ),
            )),
      ],
    );
  }

// endregion

// region dataItem
  Widget dataItem(String key, String value) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(key, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ),
        SizedBox(width: 10),
        Text(":"),
        SizedBox(width: 10),
        Expanded(
            flex: 2,
            child: Text(
              value,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
// endregion
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nomadic_ui/views/homeDataModel.dart';
//import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  HomeDataModel data = HomeDataModel();
  List<Widget> list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    isLoading = true;
    var resp = await rootBundle.loadString("assets/json/nomadic-data.json");
    setState(() {
      data = homeDataModelFromJson(resp);
    });
    list = await getData(data.text ?? "");

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<List<Widget>> getData(String newData) async {
    // Split the data string by image placeholders
    List<String> parts = newData.split(RegExp(r'!\[\]\(image/[a-f0-9]+\)'));

    // Extract image URLs from the data string
    RegExp imageRegex = RegExp(r'!\[\]\(image/([a-f0-9]+)\)');
    List<String> imageIds =
        imageRegex.allMatches(newData).map((match) => match.group(1)!).toList();

    // Create widgets based on the text parts and image URLs
    for (int i = 0; i < parts.length; i++) {
      // Add text widget for the current part
      if (parts[i].isNotEmpty) {
        list.add(Text(parts[i]));
      }

      // Add image widget if there's a corresponding image URL
      if (i < imageIds.length) {
        String imageUrl = data.media
                ?.firstWhere((element) => element.id == imageIds[i])
                .media
                ?.small ??
            "";
        list.add(Image.network(imageUrl));
      }
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SvgPicture.asset("assets/svg/logo.svg"),
        leading: const Icon(Icons.arrow_back_ios_new),
      ),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title ?? "",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Image.network(data.media![0].media?.small ?? ""),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [...list],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

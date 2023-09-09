import 'package:flutter/material.dart';
import '../ButtonNavigation/home_screen.dart';

class ToSearchScreen extends StatefulWidget {
  const ToSearchScreen({super.key});

  @override
  State<ToSearchScreen> createState() => _ToSearchScreenState();
}

class _ToSearchScreenState extends State<ToSearchScreen> {
  final TextEditingController toSearchController = TextEditingController();

  Map<String, List<String>> allStatesAndCities = {
    'Andhra Pradesh': ['Visakhapatnam', 'Vijayawada', 'Guntur'],
    'Arunachal Pradesh': ['Itanagar', 'Naharlagun', 'Tawang'],
    'Assam': ['Guwahati', 'Silchar', 'Dibrugarh'],
    'Bihar': ['Patna', 'Gaya', 'Muzaffarpur'],
    'Chhattisgarh': ['Raipur', 'Bhilai', 'Bilaspur'],
    'Goa': ['Panaji', 'Margao', 'Vasco da Gama'],
    'Gujarat': ['Ahmedabad', 'Surat', 'Vadodara'],
    'Haryana': ['Chandigarh', 'Faridabad', 'Gurgaon'],
    'Himachal Pradesh': ['Shimla', 'Manali', 'Dharamshala'],
    'Jharkhand': ['Ranchi', 'Jamshedpur', 'Dhanbad'],
    'Karnataka': ['Bangalore', 'Mysore', 'Hubli'],
    'Kerala': ['Thiruvananthapuram', 'Kochi', 'Kozhikode'],
    'Madhya Pradesh': ['Bhopal', 'Indore', 'Gwalior'],
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur'],
    'Manipur': ['Imphal', 'Thoubal', 'Bishnupur'],
    'Meghalaya': ['Shillong', 'Tura', 'Jowai'],
    'Mizoram': ['Aizawl', 'Lunglei', 'Champhai'],
    'Nagaland': ['Kohima', 'Dimapur', 'Mokokchung'],
    'Odisha': ['Bhubaneswar', 'Cuttack', 'Rourkela'],
    'Punjab': ['Chandigarh', 'Ludhiana', 'Amritsar'],
    'Rajasthan': ['Jaipur', 'Jodhpur', 'Udaipur'],
    'Sikkim': ['Gangtok', 'Namchi', 'Gyalshing'],
    'Tamil Nadu': ['Chennai', 'Coimbatore', 'Madurai'],
    'Telangana': ['Hyderabad', 'Warangal', 'Karimnagar'],
    'Tripura': ['Agartala', 'Udaipur', 'Dharmanagar'],
    'Uttar Pradesh': ['Lucknow', 'Kanpur', 'Agra'],
    'Uttarakhand': ['Dehradun', 'Haridwar', 'Roorkee'],
    'West Bengal': ['Kolkata', 'Howrah', 'Durgapur'],
  };


  List<String> searchResults = [];

  void updateSearchResults(String query) {
    searchResults.clear();

    allStatesAndCities.forEach((state, cities) {
      if (state.toLowerCase().contains(query.toLowerCase())) {
        searchResults.add(state);
      }
      cities.forEach((city) {
        if (city.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add("$city, $state");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  updateSearchResults(query);
                });
              },
              controller: toSearchController,
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Search for a state or city',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchResults[index]),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),
                      settings: RouteSettings(name: searchResults[index] ), // Pass the data here
                    ));
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/Artist/serviceArtist.dart' as artistService;
import '../model/artist/Artist.dart';
import 'Profile.dart';
import 'contracts.dart';
import 'ArtistDetail.dart';
import '../providers/AuthenticationProvider.dart';

class Home extends StatefulWidget {
  final String username;

  Home({required this.username});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Artist>> futureArtists;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    futureArtists = artistService.ApiService().fetchArtists();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);

    Widget _getSelectedWidget() {
      switch (_selectedIndex) {
        case 1:
          return ContractsList();
        case 0:
        default:
          return FutureBuilder<List<Artist>>(
            future: futureArtists,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
                return Center(child: Text('Failed to load artists'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                print('No artists found');
                return Center(child: Text('No artists found'));
              } else {
                print('Artists loaded: ${snapshot.data}');
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Artist artist = snapshot.data![index];
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            artist.image,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name: ${artist.fullName}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Description: ${artist.description}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Group: ${artist.groupMusician}',
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                                SizedBox(height: 10),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ArtistDetail(artist: artist)),
                                    );
                                  },
                                  child: Text('View Profile'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          );
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile(username: widget.username, customerId: '',)),
                );
              },
            ),
            Text(widget.username),
            Spacer(),
            PopupMenuButton<String>(
              onSelected: (String result) {
                if (result == 'Settings') {
                  // Navigate to settings page
                } else if (result == 'SignOut') {
                  authProvider.signOut(context);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Settings',
                  child: Text('Settings'),
                ),
                const PopupMenuItem<String>(
                  value: 'SignOut',
                  child: Text('SignOut'),
                ),
              ],
            ),
          ],
        ),
      ),
      body: _getSelectedWidget(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Contracts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
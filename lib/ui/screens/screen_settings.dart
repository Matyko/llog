import 'package:flutter/material.dart';
import 'package:llog/ui/screens/screen_favourites.dart';
import 'package:llog/ui/screens/screen_unit_list.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final LocalAuthentication localAuthentication = LocalAuthentication();
  bool _hasAuth = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20.0),
              child: Text('Content', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: Icon(Icons.straighten),
              title: Text('Units'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => UnitListScreen())
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FavoritesScreen())
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20.0),
              child: Text('Security', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            FutureBuilder(
              future: localAuthentication.isDeviceSupported(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                final canSecure = snapshot.data ?? false;
                print(snapshot.data);
                return ListTile(
                  leading: Icon(Icons.lock),
                  title: Text('Authenticate on login'),
                  trailing: Switch(
                    value: _hasAuth,
                    onChanged: canSecure ? _changeAuthentication : null,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  _loadSettings() async {
    final preferences = await SharedPreferences.getInstance();
    _hasAuth = preferences.getBool('authRequired') ?? false;
  }

  _changeAuthentication(bool shouldAuth) async {
    final isAuthenticated = await localAuthentication.authenticate(
      localizedReason: 'Please complete the biometrics to proceed.',
    );
    if (isAuthenticated) {
      final preferences = await SharedPreferences.getInstance();
      setState(() {
        _hasAuth = shouldAuth;
        preferences.setBool('authRequired', shouldAuth);
      });
    }
  }
}


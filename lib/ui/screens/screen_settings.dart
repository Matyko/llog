import 'package:flutter/material.dart';
import 'package:llog/ui/screens/screen_favourites.dart';
import 'package:llog/ui/screens/screen_unit_list.dart';
import 'package:llog/util/app_settings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final LocalAuthentication localAuthentication = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppSettings>(
        future: _loadSettings(),
        builder: (context, snapshot) {
          final preferences = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('Settings'),
            ),
            body: preferences == null
                ? Container()
                : Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: ListTileTheme(
                      iconColor: Theme.of(context).iconTheme.color,
                      child: ListView(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, top: 20.0),
                            child: Text('Content',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          ListTile(
                            leading: Icon(Icons.straighten),
                            title: Text('Units'),
                            trailing: Icon(Icons.chevron_right),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => UnitListScreen()));
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.favorite),
                            title: Text('Favorites'),
                            trailing: Icon(Icons.chevron_right),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => FavoritesScreen()));
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, top: 20.0),
                            child: Text('Security',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          FutureBuilder(
                            future: localAuthentication.isDeviceSupported(),
                            builder: (BuildContext context,
                                AsyncSnapshot<bool> snapshot) {
                              final canSecure = snapshot.data ?? false;
                              return ListTile(
                                leading: Icon(Icons.lock),
                                title: Text('Authenticate on login'),
                                trailing: PreferenceBuilder<bool>(
                                  preference: preferences.authRequired,
                                  builder: (context, authRequired) {
                                    return Switch(
                                      value: authRequired,
                                      onChanged:
                                          canSecure ? _changeAuthentication : null,
                                    );
                                  }
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, top: 20.0),
                            child: Text('Look',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          ListTile(
                            leading: Icon(Icons.nightlight_round),
                            title: Text('Dark mode'),
                            trailing: PreferenceBuilder<bool>(
                              preference: preferences.hasDarkMode,
                              builder: (context, hasDarkMode) {
                                return Switch(
                                  value: hasDarkMode,
                                  onChanged: preferences.hasDarkMode.setValue,
                                );
                              }
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          );
        });
  }

  Future<AppSettings> _loadSettings() async {
    final preferences = await StreamingSharedPreferences.instance;
    return AppSettings(preferences);
  }

  _changeAuthentication(bool shouldAuth) async {
    final isAuthenticated = await localAuthentication.authenticate(
      localizedReason: 'Please complete the biometrics to proceed.',
    );
    if (isAuthenticated) {
      final preferences = await StreamingSharedPreferences.instance;
      setState(() {
        preferences.setBool('authRequired', shouldAuth);
      });
    }
  }
}

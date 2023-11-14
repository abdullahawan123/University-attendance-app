import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_interface/screens/changePasswordScreen.dart';

class settings extends StatefulWidget {
  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightBlue[50],
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              elevation: 10,
              backgroundColor: Colors.blueAccent,
              title: Text(
                "Settings",
                style: TextStyle(fontSize: 25),
              ),
              toolbarHeight: 65,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SettingsSection(
              title: Text('Account'),
              tiles: [
                SettingsTile(
                  title: Text('Email'),
                  leading: Icon(Icons.language),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: Text('Reset Password'),
                  leading: Icon(Icons.fingerprint),
                  onPressed: (BuildContext context) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen()),
                    );
                  },
                ),
                SettingsTile(
                  title: Text('Logout'),
                  leading: Icon(Icons.logout),
                  onPressed: (BuildContext context) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: Text('Are you sure you want to quit?'),
                                actions: <Widget>[
                                  ElevatedButton(
                                      child: Text('exit'),
                                      onPressed: () {
                                        saveValue("status", false);
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                '/',
                                                (Route<dynamic> route) =>
                                                    false);
                                      }),
                                  ElevatedButton(
                                      child: Text('cancel'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(false)),
                                ]));
                  },
                )
              ],
            ),
          ],
        ));
  }
}

saveValue(String key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("set $key as $value");
  prefs.setBool(key, value);
}

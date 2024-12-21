import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'English';
  final List<String> _languages = ['English', 'Spanish', 'French', 'Hindi'];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Edit Profile"),
              onTap: _editProfile,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.brightness_4),
              title: const Text("Dark Mode"),
              trailing: Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.notifications_active),
              title: const Text("Notifications"),
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
            ),
            const Divider(),
             ListTile(
               leading: const Icon(Icons.language),
              title: const Text("Language"),
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                },
                items: _languages
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text("Privacy Policy"),
              onTap: _launchPrivacyPolicy,
            ),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.cleaning_services),
                title: const Text("Clear Cache"),
              onTap: _clearCache,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Logout"),
              onTap: () {
                _logout(context);
              },
            )
          ],
        )
    );
  }

   void _editProfile() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditProfileScreen()));
   }
  
    void _launchPrivacyPolicy() async {
    const url = 'https://www.example.com/privacy'; // Replace with your privacy policy URL
    final uri = Uri.parse(url);
   
    
  }

  void _clearCache() {
     showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Clear Cache"),
          content: const Text("Are you sure you want to clear the app cache?"),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Cancel")),
             TextButton(onPressed: () {
              Navigator.of(context).pop();
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cache cleared Successfully!")));
             }, child: const Text("Clear"))
          ],
        )
    );
  }

  void _logout(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Cancel")),
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Yes"))
          ],
        )
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: const Padding(padding: EdgeInsets.all(16.0), child: Text("Edit Profile here!"),),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:goal_diggers/src/feature/home/presentation/support_page.dart';
import 'package:goal_diggers/src/feature/home/presentation/terms_and_condition.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          
          _buildSectionHeader('Account Settings'),
          _buildListTile(
            icon: Icons.email,
            title: 'Change Email',
            onTap: () {
             
            },
          ),
          _buildListTile(
            icon: Icons.lock,
            title: 'Change Password',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          _buildListTile(
            icon: Icons.account_circle,
            title: 'Manage Social Accounts',
            onTap: () {
              
            },
          ),

          // App Preferences Section
          _buildSectionHeader('App Preferences'),
          _buildSwitchListTile(
            icon: Icons.notifications,
            title: 'Enable Notifications',
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          _buildListTile(
            icon: Icons.language,
            title: 'Language: $_language',
            onTap: () {
              // Navigate to language selection page
            },
          ),
          _buildSwitchListTile(
            icon: Icons.brightness_4,
            title: 'Dark Mode',
            value: _darkMode,
            onChanged: (bool value) {
              setState(() {
                _darkMode = value;
              });
              // Implement dark mode logic here
            },
          ),

          // Security Settings Section
          _buildSectionHeader('Security Settings'),
          _buildListTile(
            icon: Icons.security,
            title: 'Enable Two-Factor Authentication',
            onTap: () {
              // Navigate to two-factor authentication page
            },
          ),
          _buildListTile(
            icon: Icons.privacy_tip,
            title: 'Privacy Settings',
            onTap: () {
              // Navigate to privacy settings page
            },
          ),

          // Help & Support Section
          _buildSectionHeader('Help & Support'),
          _buildListTile(
            icon: Icons.help_outline,
            title: 'FAQs',
            onTap: () {
              // Navigate to FAQs page
            },
          ),
          _buildListTile(
            icon: Icons.support,
            title: 'Contact Support',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SupportPage()),
              );
            },
          ),
          _buildListTile(
            icon: Icons.description,
            title: 'Terms & Conditions',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TermsAndCondition()),
              );
            },
          ),

          // General Section
          _buildSectionHeader('General'),
          _buildListTile(
            icon: Icons.star,
            title: 'Rate the App',
            onTap: () {
              // Navigate to app rating page
            },
          ),
          _buildListTile(
            icon: Icons.share,
            title: 'Share the App',
            onTap: () {
              // Share app functionality
            },
          ),
          _buildListTile(
            icon: Icons.info,
            title: 'About',
            onTap: () {
              // Navigate to app info page
            },
          ),
        ],
      ),
    );
  }

  // Helper method for section headers with accent color and rounded corners
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  // Helper method for list tiles with rounded corners and icon color customization
  Widget _buildListTile(
      {required IconData icon,
      required String title,
      required void Function() onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  // Helper method for switch list tiles with rounded corners and accent color
  Widget _buildSwitchListTile(
      {required IconData icon,
      required String title,
      required bool value,
      required void Function(bool) onChanged}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: SwitchListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        secondary: Icon(icon, color: Colors.blueAccent),
        title: Text(title),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blueAccent,
      ),
    );
  }
}

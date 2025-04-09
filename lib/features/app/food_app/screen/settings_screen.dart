import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itc_food/features/authentication/auth_bloc/auth_bloc.dart';
import 'package:itc_food/features/authentication/auth_bloc/auth_event.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });
    // TODO: Implement notification settings persistence
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      _darkModeEnabled = value;
    });
    // TODO: Implement dark mode settings persistence
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            _buildSection([
              _buildTile(
                icon: Icons.person_outline,
                title: 'Account',
                trailing: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                onTap: () {},
              ),
              _buildTile(
                icon: Icons.language,
                title: 'Language',
                trailing: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 15),
            _buildSection([
              _buildTile(
                icon: Icons.notifications_none,
                title: 'Notifications',
                trailing: Switch(
                  value: _notificationsEnabled,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: _toggleNotifications,
                ),
              ),
              _buildTile(
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
                trailing: Switch(
                  value: _darkModeEnabled,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: _toggleDarkMode,
                ),
              ),
            ]),
            const SizedBox(height: 15),
            _buildSection([
              _buildTile(
                icon: Icons.logout,
                title: 'Logout',
                iconColor: Colors.red,
                textColor: Colors.red,
                onTap: () => _showLogoutDialog(context),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    Color iconColor = Colors.black54,
    Color textColor = Colors.black87,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(icon, color: iconColor, size: 24),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }

  void _logout(BuildContext context) {
    context.read<AuthBloc>().add(LogoutEvent());
  }
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          TextButton(
            onPressed: () => _logout(context),
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

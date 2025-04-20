import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildProfileDetails(),
            const SizedBox(height: 24),
            _buildSettingsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF2D7BF0),
                width: 2,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                size: 50,
                color: Color(0xFF2D7BF0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'John Doe',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Premium Member',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF2D7BF0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            icon: Icons.email_outlined,
            title: 'Email',
            value: 'johndoe@example.com',
          ),
          const Divider(color: Color(0xFF333333)),
          _buildDetailRow(
            icon: Icons.phone_outlined,
            title: 'Phone',
            value: '+1 234 567 890',
          ),
          const Divider(color: Color(0xFF333333)),
          _buildDetailRow(
            icon: Icons.location_on_outlined,
            title: 'Address',
            value: '123 Main St, City, Country',
          ),
          const Divider(color: Color(0xFF333333)),
          _buildDetailRow(
            icon: Icons.calendar_today_outlined,
            title: 'Date of Birth',
            value: 'January 1, 1990',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF121212),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF2D7BF0),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.edit,
            color: Color(0xFF2D7BF0),
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    final List<Map<String, dynamic>> settings = [
      {
        'icon': Icons.security_outlined,
        'title': 'Security',
        'onTap': () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Security settings coming soon')),
          );
        },
      },
      {
        'icon': Icons.notifications_outlined,
        'title': 'Notifications',
        'onTap': () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Notification settings coming soon')),
          );
        },
      },
      {
        'icon': Icons.language_outlined,
        'title': 'Language',
        'onTap': () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Language settings coming soon')),
          );
        },
      },
      {
        'icon': Icons.help_outline,
        'title': 'Help & Support',
        'onTap': () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Help & Support coming soon')),
          );
        },
      },
      {
        'icon': Icons.logout,
        'title': 'Logout',
        'onTap': () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logout functionality coming soon')),
          );
        },
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          ...settings.map((setting) {
            return Column(
              children: [
                InkWell(
                  onTap: setting['onTap'],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF121212),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            setting['icon'],
                            color: setting['title'] == 'Logout'
                                ? Colors.red
                                : const Color(0xFF2D7BF0),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            setting['title'],
                            style: TextStyle(
                              fontSize: 16,
                              color: setting['title'] == 'Logout'
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF9E9E9E),
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                if (setting != settings.last)
                  const Divider(color: Color(0xFF333333)),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
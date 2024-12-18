import 'package:animate_do/animate_do.dart';
import 'package:appl_f/screen/pin/change_pin_screen.dart';
import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../utils/session_helper.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Minakshi Bisen';
  String image = '';
  String email = 'minakshi@gamil.com';
  String mobile = '7694930451';
  String branch = 'Vijay Nagar, Indore';
  String designation = '';
  String empCode = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final List<Map<String, dynamic>> listItems = [

      {
        "title": "Change Password",
        "icon": Icons.password_rounded,
        "onTap": () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
          // );
        },
      },
      {
        "title": "Change Pin",
        "icon": Icons.pin,
        "onTap": () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ChangePinScreen()),
          );
        },
      },
      {
        "title": "Logout",
        "icon": Icons.logout,
        "onTap": () {
          _showLogoutDialog(context);
        },
      },
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 1,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          // Profile Section
          Stack(
            children: [
              _buildUserDetailCard(),
              // Profile Stats Card
              Column(
                children: [
                  SizedBox(height: size.height * 0.26),

                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: listItems.length,
              itemBuilder: (context, index) {
                final item = listItems[index];
                return FadeInLeft(
                  duration: const Duration(milliseconds: 500),
                  delay: Duration(milliseconds: index * 200), // Staggered delay
                  child: Column(
                    children: [
                      _buildListTile(
                        title: item['title']!,
                        leadingIcon: item['icon']!,
                        onTap: item['onTap']!,
                      ),
                      if (index != listItems.length - 1)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 15),
                          child: Container(
                            width: double.infinity,
                            color: Colors.grey,
                            height: 0.3,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserDetailCard() {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      color: AppColors.primaryColor,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: FadeIn(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/ic_image.png'),
            ),
            Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.mail, color: Colors.white, size: 16),
                    const SizedBox(width: 5),
                    Text(
                      email,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.phone, color: Colors.white, size: 16),
                    const SizedBox(width: 5),
                    Text(
                      mobile,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildListTile(
      {required String title,
        required IconData leadingIcon,
        required VoidCallback onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(leadingIcon, color: AppColors.iconColor),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColors.titleColor,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppColors.textColor,
      ),
      onTap: onTap,
    );
  }
}


void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await SessionHelper.clearAllSessionData();
              if (!context.mounted) return;
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      );
    },
  );
}

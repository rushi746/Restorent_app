// lib/common/ui/app_drawer.dart
import 'package:flutter/material.dart';
import 'package:recipieapp/pages/home.dart';
import 'package:recipieapp/pages/login_screen.dart';
import 'package:recipieapp/pages/order_history_screen.dart';
import 'package:recipieapp/pages/profile_screen.dart';
import 'package:recipieapp/pages/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 48, 24, 24),
          child: Column(
            children: [
               _buildHeader(context),
               const Divider(
                  height: 20.0,
                  thickness: 0.5,
                  color: Colors.grey,
                ),
              _buildDrawerItem(
                  icon: Icons.home,
                  text: 'Home',
                   onTap: () {
                     Navigator.pop(context);
                     Navigator.pushReplacement(
                       context,
                       MaterialPageRoute(builder: (context) => const Home()),
                     );
                   },
                  context: context
              ),
              _buildDrawerItem(
                icon: Icons.person,
                text: 'Profile',
                onTap: (){
                   Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ProfileScreen()));
                },
                context: context,
              ),
              _buildDrawerItem(
                icon: Icons.shopping_bag,
                text: 'Order History',
                onTap: (){
                  Navigator.pop(context);
                   Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => OrderHistoryScreen()));
                },
                context: context
              ),
              _buildDrawerItem(
                icon: Icons.settings,
                text: 'Settings',
                onTap: (){
                   Navigator.pop(context);
                   Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SettingsScreen()));
                },
                context: context,
              ),
             const Spacer(),
             _buildLoginLogoutButton(context),
            ],
          ),
        ),
      ),
    );
  }
   Widget _buildLoginLogoutButton(BuildContext context) {
    // Here you should add the logic to check whether user is logged in or not
    // If user is logged in, then display logout button, else login button.
       return   Container(
           padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
           decoration: BoxDecoration(
             color: Colors.blue,
             borderRadius: BorderRadius.circular(20.0),
           ),
           child: InkWell(
             onTap: (){
               Navigator.pop(context);
               Navigator.of(context).push(
                   MaterialPageRoute(builder: (context) => const LoginScreen()));
             },
             child: const Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Icon(
                   Icons.login,
                   color: Colors.white,
                   size: 20,
                 ),
                 SizedBox(width: 5,),
                 Text(
                   "Login",
                   style: TextStyle(
                     color: Colors.white,
                     fontWeight: FontWeight.w600,
                     fontSize: 16,
                   ),
                 )
               ],
             ),
           )
       );
  }


  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
         ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.asset(
            "images/boy.png",
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Guest",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required BuildContext context
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
            children: [
              Icon(
                icon,
                size: 25.0,
                color: Colors.black
              ),
              const SizedBox(width: 10.0,),
              Text(text,
                  style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600
                  ))
            ]
        ),
      ),
    );
  }
}
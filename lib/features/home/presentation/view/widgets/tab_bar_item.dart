import 'package:flutter/material.dart';

class TabBarItem extends StatelessWidget {
  const TabBarItem({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          SizedBox(width: 5),
          Text(title),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

//*Listview widget for profile
class ProfileMenuWidget extends StatefulWidget {
  const ProfileMenuWidget({
    super.key,
    required this.titleText,
    required this.icon,
    required this.color,
    required this.endIcon,
    this.onTap,
  });

  final String titleText;
  final IconData icon;
  final Color color;
  final bool endIcon;
  final VoidCallback? onTap;

  @override
  State<ProfileMenuWidget> createState() => _ProfileMenuWidgetState();
}

class _ProfileMenuWidgetState extends State<ProfileMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ListTile(
        //*the circle padding for icon
        leading: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Theme.of(context).primaryColor),
            child: Icon(widget.icon, color: Colors.black)),
        //*the name of the profile items
        title: Text(
          widget.titleText,
          style: TextStyle(
            color: widget.color,
          ),
        ),
        trailing: widget.endIcon
            ? Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: const Icon(LineAwesomeIcons.angle_right,
                    size: 18, color: Colors.grey),
              )
            : null,
      ),
    );
  }
}


import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class DashboardLocationBar extends StatefulWidget {
  const DashboardLocationBar({Key? key}) : super(key: key);

  @override
  _DashboardLocationBarState createState() => _DashboardLocationBarState();
}

class _DashboardLocationBarState extends State<DashboardLocationBar> {
  String _currentLocation = "Fetching location...";
  bool locAvail = false;
  int _nearbyCollections = 0;
  double lat = 0;
  double lang = 0;




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _currentLocation,
                    style: const TextStyle(
                      color: AppColors.titleColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Text(
                        "Nearby Collections: ",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        "$_nearbyCollections",
                        style: const TextStyle(
                          color: AppColors.titleColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {

              },
              child: Container(
                width: 40.0,
                height: 40.0,
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

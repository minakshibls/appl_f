import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:appl_f/common/default_app_bar.dart';
import 'package:appl_f/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../utils/loading_widget.dart';

class LivenessScreen extends StatefulWidget {
  const LivenessScreen({super.key});

  @override
  State<LivenessScreen> createState() => LivenessScreenState();
}

class LivenessScreenState extends State<LivenessScreen> {
  var isLoading = false;
  List<String> livenessItems = [
    'Pramod Kumar Matho',
    'Minakshi Bisen',
  ];


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: DefaultAppBar(title: 'Liveness', size: size),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Proposal No : ",
                    style: TextStyle(
                      color: AppColors.titleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
            isLoading
                ? const SizedBox(height: 200, child: LoadingWidget(size: 40))
                : Expanded(
              child: /*livenessItems.isEmpty
                  ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/ic_empty.png',
                        width: 50, height: 50),
                    const Text(
                      "No PTP found",
                      style: TextStyle(
                          color: AppColors.titleLightColor),
                    ),
                  ],
                ),
              )*/
                   ListView.builder(
                itemCount: livenessItems.length,
                itemBuilder: (context, index) {
                  var item = livenessItems[index];
                  return FadeInLeft(
                    delay: Duration(
                        milliseconds: min(index * 180, 1000)),
                    child: LivenessItemCard(
                      name: livenessItems[index] ?? 'Unknown',
                      status: 'Active',
                      mobile: '09876544231',
                      onTap: () {
                        // Handle item tap if needed
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}

class LivenessItemCard extends StatefulWidget {
  final String name;
  final String status;
  final String mobile;
  final VoidCallback onTap;

  const LivenessItemCard({
    super.key,
    required this.name,
    required this.status,
    required this.mobile,
    required this.onTap,
  });

  @override
  State<LivenessItemCard> createState() => _LivenessItemCardState();
}

class _LivenessItemCardState extends State<LivenessItemCard> {
  var isOpen = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Colors.white,
        elevation: 2,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // color: AppColors.lightGrey,
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Customer Name: ",
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.titleColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.titleColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text(
                        "Status: ",
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.titleColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.status,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.titleColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text(
                        "Mobile Number: ",
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.titleColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.mobile,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.titleColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  // border: Border(top: BorderSide(color: AppColors.lightGrey)),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(12),
                      bottomStart: Radius.circular(12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    color: AppColors.textColor,
                    width: .5,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                  ),
                  _buildActionButton(
                      Icons.phone, 'Start Video', Colors.orange, () {
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 15,color: Colors.white,),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
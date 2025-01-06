import 'package:animate_do/animate_do.dart';
import 'package:appl_f/screen/dashboard/liveness_screen.dart';
import 'package:appl_f/screen/dashboard/ptp_screen.dart';
import 'package:appl_f/screen/upload_aadar_screen.dart';
import 'package:appl_f/screen/upload_pan_screen.dart';
import 'package:appl_f/screen/webview_screen.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/loading_widget.dart';
import '../../utils/session_helper.dart';
import 'dashboard_location_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var userName = '';

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    const animationDuration = 1000;
    return Scaffold(
      backgroundColor: AppColors.textOnPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 1,
        title: const Text(
          "Dashboard",
          style: TextStyle(color: AppColors.textOnPrimary),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none,
                color: AppColors.textOnPrimary),
            onPressed: () {
              // Navigate to notification screen
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dashboardGreeting(),
            const SizedBox(height: 10),
            // FadeInLeft(
            //     duration: const Duration(milliseconds: animationDuration),
            //     child: const DashboardLocationBar()),
            const SizedBox(height: 10),
            sectionHeader("Today's Snapshot"),
            const SizedBox(height: 20),
            FadeInLeft(
                duration: const Duration(milliseconds: animationDuration),
                child: const DashboardGrid()),
            const SizedBox(height: 30),
            sectionHeader("What's on your mind?"),
            const SizedBox(height: 10),
            const DashboardCard(),
          ],
        ),
      ),
    );
  }

  Widget dashboardGreeting() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello, ${userName.isNotEmpty ? userName : 'User'}",
            style: const TextStyle(
              color: AppColors.titleColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Welcome back!",
            style: TextStyle(color: AppColors.textColor, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.titleColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void getUser() async {
    var name = await SessionHelper.getSessionData(SessionKeys.username);
    setState(() {
      userName = name.toString();
    });
  }
}

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        rowItem("0", "Number Of Receipt"),
        const SizedBox(height: 10),
        rowItem("₹ 0", "Cash In Hand"),
      ],
    );
  }

  Widget rowItem(String value, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildBox(value, title),
        buildBox(value, title),
      ],
    );
  }

  Widget buildBox(String value, String title) {
    return Container(
      width: 150,
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.titleColor.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textOnPrimary,
            ),
          ),
          const SizedBox(height: 5),
          Flexible(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textOnPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardCard extends StatefulWidget {
  const DashboardCard({super.key});

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  bool isAttendanceLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3.5,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildActionButton(
              Icons.groups, 'Proposal', 'Add a new proposal ', () {
            const WebViewScreen(url: "https://erp.amarpadma.com/ajax/route.php?uid=1001&referer=cGlkPTE1MiZhY3Rpb249Y3JlYXRlX3Byb3Bvc2Fs", heading: "Proposal");

          }),
          _buildActionButton(
              Icons.group, 'Customer Boarding', 'Add a new Promise', () {
            const WebViewScreen(url: "https://erp.amarpadma.com/ajax/route.php?uid=1001&referer=cGlkPTMwMSZhY3Rpb249Y3VzdG9tZXJfYm9hcmRpbmc=", heading: "Customer Boarding");

          }),
          _buildActionButton(
              Icons.live_tv, 'Liveness', 'Check for unapproved collections',
              () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LivenessScreen()),
            );
          }),
          _buildActionButton(
              Icons.collections, 'Collection', 'Add a new collection', () {
            const WebViewScreen(url: "https://erp.amarpadma.com/ajax/route.php?uid=1001&referer=cGlkPTE2MyZhY3Rpb249ZGlyZWN0X2NvbGxlY3Rpb24=", heading: "Collection");

          }),
          _buildActionButton(
              Icons.handshake, 'Promise to pay', 'Add a new Promise', () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const PTPScreen()),
            );
          }),
          _buildActionButton(
              Icons.handshake, 'Reconciliation', 'Add a new Promise', () {
            const WebViewScreen(url: "https://erp.amarpadma.com/ajax/route.php?uid=1001&referer=cGlkPTMxOCZhY3Rpb249Y29sbGVjdGlvbl9yZWNvbmNpbGlhdGlvbg==", heading: "Reconciliation");

          }),
          _buildActionButton(
              Icons.sensor_occupied, 'OCR', 'Add a new Promise', () {
            searchBottomSheet(context);
          }),
          _buildActionButton(
              Icons.calculate, 'EMI Calculator', 'Add a new Promise', () {
            const WebViewScreen(url: "https://erp.amarpadma.com/ajax/route.php?uid=1001&referer=cGlkPTEwMCZhY3Rpb249bG9hZF9jYWxj", heading: "EMI Calculator");

          }),
        ],
      ),
    );
  }
  void searchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: ListTile(
                  leading: const Icon(Icons.credit_card,color: AppColors.primaryColor,),
                  title: const Text('Upload Aadhar Card'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>const UploadAadarScreen() ),
                    );
                  },
                ),
              ),
              Center(
                child: ListTile(
                  leading: const Icon(Icons.account_balance_wallet,color: AppColors.primaryColor,),
                  title: const Text('Upload Pan Card'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const UploadPanScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red,fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Widget _buildActionButton(
      IconData icon, String label, String subTitle, VoidCallback onTap,
      {Color color = AppColors.primaryColor, bool loading = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.lightGrey,
            border: Border.all(color: Colors.grey.shade200)),
        child: loading
            ? const LoadingWidget()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        subTitle,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  const SizedBox(width: 4),
                  Icon(icon, color: color, size: 30),
                ],
              ),
      ),
    );
  }

  void _setLoading(bool bool) {
    setState(() {
      isAttendanceLoading = bool;
    });
  }
}

import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/shared/widgets/custom_header_notification.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [

            hBox(20),

            CustomHeaderWithNotification(title: 'My Profile',),

            hBox(20),

            // User Info Section
            Opacity(
              opacity: .1,
              child: Container(
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/profile_picture.png'), // Replace with user's image
                    ),
                    SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jone Deo',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'yourname@gmail.com',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Profile Options
            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Edit Profile'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to edit profile
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag_outlined),
              title: Text('Orders'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to orders
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on_outlined),
              title: Text('Delivery Address'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to delivery address
              },
            ),
            ListTile(
              leading: Icon(Icons.credit_card_outlined),
              title: Text('Payment Method'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to payment method
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet_outlined),
              title: Text('My Wallet'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to wallet
              },
            ),
            ListTile(
              leading: Icon(Icons.local_offer_outlined),
              title: Text('Promotion Code'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to promotion code
              },
            ),
            ListTile(
              leading: Icon(Icons.person_add_outlined),
              title: Text('Invite Friends'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to invite friends
              },
            ),
            ListTile(
              leading: Icon(Icons.settings_outlined),
              title: Text('Settings'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to settings
              },
            ),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text('Help'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to help
              },
            ),
            // Logout Option
            ListTile(
              leading: Icon(Icons.logout, color: Colors.green),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                // Handle logout
              },
            ),

          ],
        ),
      ),
    );
  }
}

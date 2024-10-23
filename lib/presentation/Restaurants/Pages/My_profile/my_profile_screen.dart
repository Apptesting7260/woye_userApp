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
            Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(.1),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/profile-image.png'), // Replace with user's image
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
            // Profile Options
            ListTile(
              leading: Image.asset("assets/images/user.png",scale: 4,),
              title: Text('Edit Profile'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to edit profile
              },
            ),
            ListTile(
              leading: Image.asset("assets/images/bag.png",scale: 4,),
              title: Text('Orders'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to orders
              },
            ),
            ListTile(
              leading: Image.asset("assets/images/location.png",scale: 4,),
              title: Text('Delivery Address'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to delivery address
              },
            ),
            ListTile(
              leading: Image.asset("assets/images/payment.png",scale: 4,),
              title: Text('Payment Method'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to payment method
              },
            ),
            ListTile(
              leading: Image.asset("assets/images/wallet.png",scale: 4,),
              title: Text('My Wallet'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to wallet
              },
            ),
            ListTile(
              leading: Image.asset("assets/images/premonition.png",scale: 4,),
              title: Text('Premonition Code'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to promotion code
              },
            ),
            ListTile(
              leading: Image.asset("assets/images/user.png",scale: 4,),
              title: Text('Invite Friends'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to invite friends
              },
            ),
            ListTile(
              leading: Image.asset("assets/images/setting.png",scale: 4,),
              title: Text('Settings'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to settings
              },
            ),
            ListTile(
              leading: Image.asset("assets/images/help.png",scale: 4,),
              title: Text('Help'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to help
              },
            ),
            // Logout Option
            ListTile(
              leading: Image.asset("assets/images/logout.png",scale: 4,),
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

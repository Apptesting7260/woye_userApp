import 'package:flutter/material.dart';
import 'package:woye_user/shared/theme/colors.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(height: 20),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                    ),
                    child: Center(
                      child: Image.asset("assets/images/back.png", scale: 4),
                    ),
                  ),
                ),
                Text(
                  "Pizza",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 44), // Empty space to balance the layout
              ],
            ),

            SizedBox(height: 20),

            // Search bar and Filter Icon
            Row(
              children: [
                Expanded(
                  child: Opacity(
                    opacity: .3,
                    child: Container(
                      height: 60,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(width: 1,color: AppColors.hintText)
                          ),
                          filled: true,
                          fillColor: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Opacity(
                  opacity: .3,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1,color: AppColors.hintText)
                    ),
                    child: Center(
                      child: Image.asset("assets/images/filter.png", scale: 4),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Pizza listing
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 6, // Dummy item count
                itemBuilder: (context, index) {
                  return PizzaItem();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PizzaItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/images/6cee589c2f553320ee93e5afced09766 1.png",
                  fit: BoxFit.cover, // Ensure image scales properly
                  height: 120, // Adjust based on your design
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.favorite_border, size: 16),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("\$18.00", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 5),
                    Text(
                      "\$20.00",
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text("McMushroom Pizza"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

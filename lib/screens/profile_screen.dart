import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.amber),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Trang cá nhân",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),

            // Ảnh đại diện và tên người dùng
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("assets/images/Avatar.png"), // Thay bằng hình đại diện thực tế
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Nguyễn Đình Trọng",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  
                  // Thông tin bài viết, theo dõi
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildInfoColumn("Bài viết", "100"),
                      _buildInfoColumn("Người theo dõi", "100"),
                      _buildInfoColumn("Theo dõi", "100"),
                    ],
                  ),

                  SizedBox(height: 10),

                  // Nút Follow và Message
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton("Follow", Colors.amber, Colors.white),
                      SizedBox(width: 10),
                      _buildButton("Message", Colors.grey[300]!, Colors.black),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Danh mục yêu thích
            _buildCategoryList(),

            SizedBox(height: 20),

            // Danh sách yêu thích
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Danh sách yêu thích",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            
            SizedBox(height: 10),
            _buildFavoriteGrid(),
          ],
        ),
      ),
    );
  }

  // Widget hiển thị cột thông tin bài viết, theo dõi
  Widget _buildInfoColumn(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }

  // Widget hiển thị nút Follow & Message
  Widget _buildButton(String text, Color bgColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(color: textColor, fontSize: 14)),
    );
  }

  // Danh sách danh mục yêu thích
  Widget _buildCategoryList() {
    final List<Map<String, String>> categories = [
      {"image": "assets/images/Ellipse 1.png", "name": "Salad"},
      {"image": "assets/images/Ellipse 3.png", "name": "Thịt"},
      {"image": "assets/images/Ellipse 2.png", "name": "Nước"},
      {"image": "assets/images/Ellipse 4.png", "name": "Món nóng"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: categories.map((category) {
          return Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(category["image"]!),
              ),
              SizedBox(height: 5),
              Text(category["name"]!, style: TextStyle(fontSize: 14)),
            ],
          );
        }).toList(),
      ),
    );
  }

  // Danh sách yêu thích (dạng lưới)
  Widget _buildFavoriteGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 9, // Số lượng món yêu thích
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 cột
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              "assets/images/Rectangle 7.png", // Thay bằng ảnh thực tế
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hi/components/Done.dart';

// Sample images - In Flutter you would use asset paths
// You'll need to add these images to your pubspec.yaml assets section
const String volcanoImage = 'assets/images/volcano.webp';
const String allstoneImage = 'assets/images/student.png';
const String riverImage = 'assets/river.png';

class Poth extends StatefulWidget {
  const Poth({Key? key}) : super(key: key);

  @override
  State<Poth> createState() => _PothState();
}

class _PothState extends State<Poth> {
  // User level (equivalent to the React Native code's user object)
  final int userLevel = 6;

  // Layer data (equivalent to the 'layer' array in the original code)
  final List<Map<String, dynamic>> layer = [
    {
      'num': 0,
      'image': false,
      'first': {
        'Heading': 'Unit 1 | Topic 1',
        'sub_heading': "Medium Level",
        'backgroundColor': const Color(0xFFFFB22C),
        'logo': 'flag',
      }
    },
    {
      'num': 2,
      'first': {
        'name': "is/am/are",
        'logo': 'numeric',
        'counting': 1
      },
      'second': {
        'name': "was/ware",
        'logo': 'microchip',
        'counting': 2
      }
    },
    {
      'num': 1,
      'image': false,
      'first': {
        'name': "has/have",
        'logo': 'lock',
        'counting': 3
      }
    },
    {
      'num': 1,
      'image': true,
      'image_name': allstoneImage,
      'image_direction': "left",
      'first': {
        'name': "has/have",
        'logo': 'hand-wave',
        'counting': 4
      }
    },
    {
      'num': 1,
      'image': false,
      'first': {
        'name': "or/with",
        'logo': 'lock',
        'counting': 5
      }
    },
    {
      'num': 0,
      'image': false,
      'first': {
        'Heading': 'Unit 2 | Topic 2',
        'sub_heading': "Medium Level",
        'backgroundColor': const Color(0xFFFE7743),
        'logo': 'flag',
      }
    },
    {
      'num': 1,
      'image': true,
      'image_name': volcanoImage,
      'image_direction': "right",
      'first': {
        'name': "has/have",
        'logo': 'flag',
        'counting': 6
      }
    },
    {
      'num': 1,
      'image': false,
      'first': {
        'name': "has/have",
        'logo': 'flag',
        'counting': 7
      }
    },
    {
      'num': 1,
      'image': true,
      'image_name': allstoneImage,
      'image_direction': "left",
      'first': {
        'name': "has/have",
        'logo': 'flag',
        'counting': 8
      }
    },
    {
      'num': 1,
      'image': false,
      'first': {
        'name': "or/with",
        'logo': 'flag',
        'counting': 9,
      }
    },
  ];

  void checkOnPress(int levelNumber) {
    print('Level pressed: $levelNumber');
    // Navigate to test loop - Flutter navigation
    // Navigator.of(context).push(
    //     MaterialPageRoute(builder: (context) =>Match()));
  }

  // Get icon based on logo string
  Widget getIcon(String logo, {double size = 26, Color color = Colors.purple}) {
    switch (logo) {
      case 'flag':
        return Icon(Icons.flag, size: size, color: const Color(0xFF5C6BC0));
      case 'numeric':
        return Icon(Icons.filter_1, size: size, color: const Color(0xFF7E57C2)); // Using filter_1 as numeric substitute
      case 'microchip':
        return Icon(Icons.memory, size: size, color: Colors.black); // Using memory as microchip substitute
      case 'lock':
        return Icon(Icons.lock, size: size, color: Colors.black);
      case 'hand-wave':
        return Icon(Icons.waving_hand, size: size, color: const Color(0xFF7E57C2)); // Using waving_hand substitute
      default:
        return Icon(Icons.circle, size: size, color: Colors.purple);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF222831),
      body: SafeArea(
        child: Column(
          children: [
            // Header section
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.015,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Refer button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) =>  Pro() ));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.008,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Refer a friend',
                            style: TextStyle(
                              color: const Color(0xFFFF5252),
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Coin container
                  Row(
                    children: [
                      Container(
                        width: screenWidth * 0.06,
                        height: screenWidth * 0.06,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF9C4),
                          borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        ),
                        child: Center(
                          child: Text(
                            '🔥',
                            style: TextStyle(fontSize: screenWidth * 0.03),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Text(
                        '100',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                          color: const Color(0xFFFFFDF6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: screenWidth,
                    child: Column(
                      children: List.generate(layer.length, (index) {
                        final item = layer[index];

                        // Unit Banner (num: 0)
                        if (item['num'] == 0) {
                          return Container(
                            width: screenWidth * 0.9,
                            height: 80,
                            margin: const EdgeInsets.only(top: 20, bottom: 30),
                            decoration: BoxDecoration(
                              color: item['first']['backgroundColor'],
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 16,
                                  child: SizedBox(
                                    width: 69,
                                    height: 49,
                                    child: getIcon(item['first']['logo'], size: 46),
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item['first']['Heading'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        item['first']['sub_heading'],
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        // Two modules in a row (num: 2)
                        if (item['num'] == 2) {
                          return Container(
                            width: screenWidth,
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // First module
                                buildModuleItem(item['first'], screenWidth),
                                // Second module
                                buildModuleItem(item['second'], screenWidth),
                              ],
                            ),
                          );
                        }

                        // Single module (num: 1, no image)
                        if (item['num'] == 1 && item['image'] == false) {
                          return Center(
                            child: buildModuleItem(item['first'], screenWidth),
                          );
                        }

                        // Single module with image (num: 1, with right image)
                        if (item['num'] == 1 && item['image'] == true && item['image_direction'] == "right") {
                          return Container(
                            width: screenWidth * 0.9,
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                buildModuleItem(item['first'], screenWidth),
                                SizedBox(width: 80),
                                Image.asset(
                                  item['image_name'],
                                  width: 90,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          );
                        }

                        // Single module with image (num: 1, with left image)
                        if (item['num'] == 1 && item['image'] == true && item['image_direction'] == "left") {
                          return Container(
                            width: screenWidth * 0.9,
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  item['image_name'],
                                  width: 90,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 80),
                                buildModuleItem(item['first'], screenWidth),
                              ],
                            ),
                          );
                        }

                        // Fallback empty container if none of the conditions match
                        return Container();
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Module Circle Widget (equivalent to ModuleCircle component in React Native)
  Widget buildModuleCircle(Map<String, dynamic> moduleData) {
    final int counting = moduleData['counting'];
    final bool isEnabled = userLevel >= counting;

    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: isEnabled ? const Color(0xFFEDE7F6) : const Color(0xFF948979),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: const Color(0xFF9575CD), width: 2),
        boxShadow: isEnabled
            ? [
          BoxShadow(
            color: const Color(0xFFF5C45E).withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 6,
          )
        ]
            : null,
      ),
      child: Center(
        child: getIcon(moduleData['logo']),
      ),
    );
  }

  // Module Item Widget (module icon + text + badge)
  Widget buildModuleItem(Map<String, dynamic> moduleData, double screenWidth) {
    return GestureDetector(
      onTap: () => checkOnPress(moduleData['counting']),
      child: Container(
        width: screenWidth * 0.45,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildModuleCircle(moduleData),
                const SizedBox(height: 8),
                Text(
                  moduleData['name'] ?? 'Speak(mic)',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Positioned(
              right: 40,
              top: 0,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: const Color(0xFF7E57C2),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Center(
                  child: Text(
                    moduleData['counting'].toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
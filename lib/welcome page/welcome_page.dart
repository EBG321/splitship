import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  List<Widget> _buildPages() {
    return [
      OnboardingPage(
        image: 'assets/logo.png', // Replace with your app's logo image
        title: '',
        description: '',
        isLoading: true,
      ),
      OnboardingPage(
        image: 'assets/containers.jpg', // Image of shipping containers
        title: 'Welcome to SplitShip',
        description: 'The best app for shipping & delivery in this century.',
        isLoading: false,
      ),
      OnboardingPage(
        image: 'assets/ship.jpg', // Image of a ship
        title: 'Shipping made easy',
        description: 'You are our priority, shipping fast, easy and safe.',
        isLoading: false,
      ),
      OnboardingPage(
        image: 'assets/delivery.jpg', // Image of a delivery package
        title: 'Welcome to SplitShip',
        description: 'Enjoy our service, safe and reliable delivery.',
        isLoading: false,
        buttonText: 'Get Started',
      ),
    ];
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _buildPages(),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: _currentPage == index ? 20 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.blueAccent : Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final bool isLoading;
  final String? buttonText;

  const OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
    this.isLoading = false,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover, // Make image cover the full screen
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), // Darken the image slightly
                BlendMode.darken,
              ),
            ),
          ),
        ),

        // Gradient Overlay at the Bottom
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 300, // Adjust the height of the gradient as needed
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent, // No color at the top
                    Colors.black.withOpacity(0.7), // Dark at the bottom
                  ],
                ),
              ),
            ),
          ),
        ),

        // Text and Button Overlay
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (isLoading)
                CircularProgressIndicator(color: Colors.green)
              else
                SizedBox(
                  height: 200, // Leave space for the text at the bottom
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Make text white for contrast
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.9), // Slight opacity for description text
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (buttonText != null) SizedBox(height: 30),
                        if (buttonText != null)
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to next screen or perform an action
                            },
                            child: Text(buttonText!),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 15,
                              ), backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

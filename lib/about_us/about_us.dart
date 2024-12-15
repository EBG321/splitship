import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'contact_us.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add a subtle background color or pattern if desired
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background decoration (optional)
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Image.asset(
                'assets/background_pattern.png', // Subtle background pattern image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo centered at the top
                const SizedBox(height: 60),
                Image.asset(
                  'assets/logo.png', // Ensure this is a logo without background
                  height: 100,
                ),
                const SizedBox(height: 20),
                // Title
                const Text(
                  'Welcome to Ship Splits',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                // Subtitle
                const Text(
                  'Revolutionizing the way you ship goods.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // Interactive Buttons Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildActionButton(
                      icon: Icons.search,
                      label: 'Track Shipment',
                      onPressed: () {
                        // Navigate to track shipment page
                      },
                    ),
                    _buildActionButton(
                      icon: Icons.local_shipping,
                      label: 'Make an Order',
                      onPressed: () {
                        // Navigate to make order page
                      },
                    ),
                    _buildActionButton(
                      icon: Icons.person_add,
                      label: 'Invite Friends',
                      onPressed: () {
                        // Navigate to invite friends page
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Introduction Card
                _buildInfoCard(
                  title: 'Who We Are',
                  content:
                      'Ship Splits is a revolutionary platform designed to help individuals and companies save on shipping costs. By enabling users to share container space, we ensure that no one has to pay for empty space they don’t need.',
                ),
                const SizedBox(height: 20),
                // Mission Card
                _buildInfoCard(
                  title: 'Our Mission',
                  content:
                      'We believe in making shipping more efficient, affordable, and eco-friendly. Our platform connects people who have extra container space with those who need it, reducing costs and minimizing environmental impact.',
                ),
                const SizedBox(height: 20),
                // Features Card using icons
                _buildFeaturesCard(),
                const SizedBox(height: 20),
                // Testimonials Card
                _buildInfoCard(
                  title: 'What Our Users Say',
                  content:
                      '“Ship Splits has drastically reduced our shipping expenses. Highly recommended!”\n— Jane Doe, CEO of XYZ Corp\n\n“An innovative platform that makes shipping hassle-free and affordable.”\n— John Smith, Small Business Owner',
                ),
                const SizedBox(height: 20),
                // Call to Action Card
                _buildCallToActionCard(),
                const SizedBox(height: 30),
                // Contact Us Button
                ElevatedButton.icon(
                  icon: const Icon(Icons.contact_mail, color: Colors.teal),
                  label:
                      const Text('Contact Us', style: TextStyle(color: Colors.teal)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    Get.to(ContactUsPage());
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          // AppBar with transparent background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build action buttons
  Widget _buildActionButton(
      {required IconData icon,
      required String label,
      required VoidCallback onPressed}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[900]?.withOpacity(0.7),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.teal, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build information cards with titles and content
  Widget _buildInfoCard({required String title, required String content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900]?.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: const TextStyle(
                color: Colors.teal, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          // Content
          Text(
            content,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Helper method to build features card using icons
  Widget _buildFeaturesCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900]?.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Why Use Ship Splits?',
            style: TextStyle(
                color: Colors.teal, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          // Features List using icons
          Column(
            children: [
              _buildFeatureItem(
                icon: Icons.attach_money,
                title: 'Save Money',
                description:
                    'Share the cost of shipping by using only the space you need.',
              ),
              const SizedBox(height: 16),
              _buildFeatureItem(
                icon: Icons.eco,
                title: 'Eco-Friendly',
                description:
                    'Reduce your carbon footprint by making full use of available container space.',
              ),
              const SizedBox(height: 16),
              _buildFeatureItem(
                icon: Icons.network_check,
                title: 'Easy and Convenient',
                description:
                    'Our platform makes it simple to find available container space or fill your own.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to build individual feature items using icons
  Widget _buildFeatureItem(
      {required IconData icon,
      required String title,
      required String description}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.teal, size: 32),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper method for Call to Action Card
  Widget _buildCallToActionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'Get Started Today',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            'Join Ship Splits and start saving on your shipping costs while contributing to a greener planet.',
            style: TextStyle(color: Colors.white70, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to sign-up or relevant page
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text(
              'Sign Up Now',
              style: TextStyle(color: Colors.teal, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('About Us'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Our Music World!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'About Us',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'At [Music Bag], we are passionate about bringing the joy of music to your fingertips. Our mission is to create a seamless and enjoyable music experience for every user, from casual listeners to avid music enthusiasts.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'What Sets Us Apart',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '• Curated Playlists: Discover handpicked playlists crafted by our music experts to suit every mood and occasion.',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '• Personalized Recommendations: Enjoy a personalized music experience with recommendations based on your preferences and listening history.',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '• High-Quality Audio: Immerse yourself in crystal-clear, high-quality audio that enhances your listening pleasure.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Join us on this musical journey and let the rhythm guide your soul!',
                style: TextStyle(
                  fontSize: 16.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

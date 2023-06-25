import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
            color: Colors.black,
          ),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to MeloVibe - Your Ultimate Offline Music Experience',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'At MeloVibe, we are dedicated to providing music enthusiasts with a unique and immersive offline music player experience. Our app, built using Flutter, combines cutting-edge technology with a passion for music to deliver a seamless and personalized music journey. With MeloVibe, you can explore and enjoy your favorite songs, discover new tracks, and enhance your music experience in ways you never thought possible.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Our mission is to revolutionize the way you interact with music. We understand that music is more than just a background soundtrack; it\'s an integral part of our lives. MeloVibe empowers you to dive deep into the world of music, discover new artists, and effortlessly connect with the songs that resonate with your soul. With our advanced features and intuitive interface, we strive to make MeloVibe your go-to destination for offline music playback.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Key Features',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '1. MeloFinder: Discover songs effortlessly with our MeloFinder feature. Inspired by the renowned Shazam app, MeloFinder enables you to find a song simply by listening to any part of it. Just tap the MeloFinder button, let the app listen to the song, and voila! The app identifies the song and provides you with all the information you need.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '2. Adjustable Playback Speed: Customize your listening experience with the adjustable playback speed feature. Whether you want to slow down a fast-paced track or speed up a slow ballad, MeloVibe lets you control the tempo to match your preferences.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '3. Lyrics Integration: Connect deeply with the music and sing along to your favorite songs with our integrated lyrics feature. MeloVibe fetches lyrics in real-time, displaying them on your screen as the song plays. Say goodbye to the frustration of misheard lyrics and enjoy an immersive karaoke-like experience.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '4. Offline Playback: Embrace the freedom of offline music with MeloVibe. Download your favorite songs, albums, or playlists to your device and enjoy them anytime, anywhere, even without an internet connection. Whether you\'re on a long flight, commuting underground, or in an area with limited network coverage, your music is always accessible.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '5. Cross-Platform Sync: Seamlessly synchronize your music library and preferences across multiple devices. Whether you\'re using MeloVibe on your smartphone, tablet, or computer, your music collection and personalized settings stay in perfect harmony, giving you a consistent and seamless experience.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '6. Personalized Recommendations: Discover new music tailored to your taste with our personalized recommendations. MeloVibe analyzes your listening habits, genre preferences, and song history to suggest artists, albums, and tracks that align with your musical interests, helping you expand your music horizons.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '7. Customization Options: Make MeloVibe reflect your unique style and preferences. Customize the app\'s appearance, themes, and player interface to suit your mood and enhance your overall music experience.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'We are committed to continuously improving MeloVibe and providing you with the best offline music player on the market. Our team of dedicated developers and music enthusiasts work tirelessly to enhance our features, integrate new technologies, and bring you regular updates that elevate your music journey.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Join the MeloVibe community today and immerse yourself in a world of music like never before. Let the rhythms, melodies, and lyrics resonate deep within your soul as you explore the vast universe of offline music with MeloVibe.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Happy Vibing!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'The MeloVibe Team',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

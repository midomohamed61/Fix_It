import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool isMuted = false;
  bool isSpeakerOn = false;
  bool isVideoOn = false;

  // Handle call buttons
  void _toggleMute() {
    setState(() {
      isMuted = !isMuted;
    });
  }

  void _toggleSpeaker() {
    setState(() {
      isSpeakerOn = !isSpeakerOn;
    });
  }

  void _toggleVideo() {
    setState(() {
      isVideoOn = !isVideoOn;
    });
  }

  void _endCall() {
    Navigator.popAndPushNamed(context, '/ProviderProfileScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Worker Info
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/worker_image.png'), // Replace with actual image
            ),
            const SizedBox(height: 16),
            const Text(
              'Emily Jani',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              '02:28 minutes',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // Call controls (Mute, Speaker, Video)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    isMuted ? Icons.mic_off : Icons.mic,
                    color: Colors.blue,
                    size: 36,
                  ),
                  onPressed: _toggleMute,
                ),
                IconButton(
                  icon: Icon(
                    isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                    color: Colors.blue,
                    size: 36,
                  ),
                  onPressed: _toggleSpeaker,
                ),
                IconButton(
                  icon: Icon(
                    isVideoOn ? Icons.videocam : Icons.videocam_off,
                    color: Colors.blue,
                    size: 36,
                  ),
                  onPressed: _toggleVideo,
                ),
              ],
            ),
            const SizedBox(height: 40),

            // End Call button
            ElevatedButton(
              onPressed: _endCall,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
              ),
              child: const Icon(Icons.call_end, color: Colors.white, size: 36),
            ),
          ],
        ),
      ),
    );
  }
}

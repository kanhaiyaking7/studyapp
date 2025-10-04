

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Providers/Aichat_provider/RolePlayinfo.dart';
import 'package:hi/Role_ai/startpage.dart';
import 'package:hi/pages/home.dart';

class RolePlayCompletionScreen extends ConsumerStatefulWidget {
final   resultinfo;
RolePlayCompletionScreen({required this.resultinfo});
  @override
  ConsumerState<RolePlayCompletionScreen> createState() => _RolePlayCompletionScreenState();
}

class _RolePlayCompletionScreenState extends ConsumerState<RolePlayCompletionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark theme background
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(widget.resultinfo.title),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(

          children: [

            // Top congratulation message with icon
            Row(
              children: const [
                Icon(Icons.celebration, color: Colors.amber, size: 30),
                SizedBox(width: 10),
                Text(
                  'Great Job!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Image placeholder
            Container(
              width: double.infinity,
              height: 200,

              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
              ),
              child:Image.network("https://vwpuplztcmyhtzlzbylf.supabase.co/storage/v1/object/public/Avator/5860081.jpg",
                fit:BoxFit.cover,),

              
              // const Center(
              //   child: Icon(Icons.image, color: Colors.white30, size: 60),
              // ),
            ),
            const SizedBox(height: 20),

            // Reward earned
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.green[800],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.monetization_on, color: Colors.amber, size: 28),
                  SizedBox(width: 10),
                  Text(
                    '10 Coins Earned!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Chapter summary
            Consumer(
              builder: (context, ref, child) {
                final completed = ref.read(RoleplayProvider.notifier).get_data(widget.resultinfo.id);

                return Text(
                  'You’ve completed ${widget.resultinfo.title} Chapter ${completed.toString()} of the Role Play Scenarios. Keep practicing to improve your English speaking skills!',

                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
            // const Text(
            //   'You’ve completed Chapter 1 of the Role Play Scenarios. Keep practicing to improve your English speaking skills!',
            //   style: TextStyle(
            //     color: Colors.white70,
            //     fontSize: 16,
            //   ),
            //   textAlign: TextAlign.center,
            // ),

            const Spacer(),

            // Continue button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ref.read(RoleplayProvider.notifier).update_level(widget.resultinfo.id);

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_)=>
                          StatePage()));
                  // TODO: Add navigation logic here
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Continue'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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

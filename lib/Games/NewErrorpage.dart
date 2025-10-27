

import 'package:flutter/material.dart';
import 'package:hi/Games/HomeErrorhunt.dart';

class Newerrorpage extends StatefulWidget {
  const Newerrorpage({super.key});

  @override
  State<Newerrorpage> createState() => _NewerrorpageState();
}

class _NewerrorpageState extends State<Newerrorpage> {

  final List<String> levels = ['Beginner', 'Intermediate', 'Advanced'];

 var currentLevel = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D2D2D),
        title: const Text(
          'Grammar Error Hunt',
          style: TextStyle(color: Colors.white),
        ),
        leading:  IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
      Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.quiz,
            size: 80,
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          const Text(
            '🧩 Grammar Error Hunt',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Find and fix grammar mistakes!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          // buildLevelSelector(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: levels.asMap().entries.map((entry) {
                final index = entry.key;
                final level = entry.value;
                final isSelected = currentLevel == index;

                return GestureDetector(
                  onTap: () => setState(() => currentLevel = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[800],
                      borderRadius: BorderRadius.circular(20),
                      border: isSelected ? Border.all(color: Colors.blue, width: 2) : null,
                    ),
                    child: Text(
                      level,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[400],
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // buildGameModeSelector(),
          Column(
            children: [
              SwitchListTile(
                title: const Text('Timed Mode (60s)', style: TextStyle(color: Colors.white)),
                subtitle: const Text('Race against time!', style: TextStyle(color: Colors.grey)),
                value: true,
                onChanged: (value) => setState(() =>  true),
                activeColor: Colors.blue,
              ),
              SwitchListTile(
                title: const Text('Streak Mode', style: TextStyle(color: Colors.white)),
                subtitle: const Text('Keep your streak alive!', style: TextStyle(color: Colors.grey)),
                value: true,
                onChanged: (value) => setState(() => true),
                activeColor: Colors.purple,
              ),
            ],
          ),

          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: (){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>Homeerrorhunt()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'Start Game',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    )
        ],
      ),

    );
  }
}

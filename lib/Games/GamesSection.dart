
import 'package:flutter/material.dart';
import 'package:hi/Games/Dragpoint.dart';
import 'package:hi/Games/ErrorHunt.dart';
import 'package:hi/Games/wordmeaning.dart';

class GamesSection extends StatefulWidget {
  const GamesSection({Key? key}) : super(key: key);

  @override
  State<GamesSection> createState() => _GamesSectionState();
}

class _GamesSectionState extends State<GamesSection>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  int selectedGameIndex = -1;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  final List<GameData> games = [
    GameData(
      // title: 'Translation Match',
      title: 'Error Hunt',
      subtitle: 'find wrong grammer',
      description: 'Translate Hindi sentences to English and improve pronunciation',
      icon: Icons.translate,
      gradientColors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
      level: 'Beginner',
      duration: '5-10 min',
      points: '50-100 pts',
      isNew: true,
      progress: 0.7,
    ),
    GameData(
      // title: 'Word Builder',
      title: 'Translation Match',
      subtitle: 'Build vocabulary step by step',
      description: 'Learn new words through interactive spelling and pronunciation',
      icon: Icons.abc,
      gradientColors: [Color(0xFFEF4444), Color(0xFFEC4899)],
      level: 'Intermediate',
      duration: '3-7 min',
      points: '30-80 pts',
      isNew: false,
      progress: 0.4,
    ),
    GameData(
      title: 'Grammar Quest',
      subtitle: 'Master English grammar',
      description: 'Fix sentences, learn grammar rules, and speak correctly',
      icon: Icons.rule,
      gradientColors: [Color(0xFF10B981), Color(0xFF059669)],
      level: 'Advanced',
      duration: '8-12 min',
      points: '70-120 pts',
      isNew: false,
      progress: 0.2,
    ),
    // GameData(
    //   title: 'Conversation Challenge',
    //   subtitle: 'Real-world conversations',
    //   description: 'Practice dialogues and natural English conversations',
    //   icon: Icons.forum,
    //   gradientColors: [Color(0xFFFF6B6B), Color(0xFFFFD93D)],
    //   level: 'Expert',
    //   duration: '10-15 min',
    //   points: '100-200 pts',
    //   isNew: true,
    //   progress: 0.0,
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              _buildHeader(),
              _buildStatsSection(),
              Expanded(
                child: _buildGamesGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Games',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF4A4A4A)),
                ),
                child: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Practice English through fun interactive games',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
        // padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2D2D2D), Color(0xFF3A3A3A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF4A4A4A)),
        ),
      child:     Image.network('https://vwpuplztcmyhtzlzbylf.supabase.co/storage/v1/object/public/BookCover/Games/30095.webp',
        width: double.infinity,
        height: 190,
        fit: BoxFit.fill,
      ),

    );

    //   Container(
    //   margin: const EdgeInsets.symmetric(horizontal: 20),
    //   padding: const EdgeInsets.all(20),
    //   decoration: BoxDecoration(
    //     gradient: const LinearGradient(
    //       colors: [Color(0xFF2D2D2D), Color(0xFF3A3A3A)],
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //     ),
    //     borderRadius: BorderRadius.circular(16),
    //     border: Border.all(color: const Color(0xFF4A4A4A)),
    //   ),
    //   child: Row(
    //     children: [
    //       Expanded(
    //         child: _buildStatItem(
    //           icon: Icons.emoji_events,
    //           title: 'Total Score',
    //           value: '2,450',
    //           color: const Color(0xFFFFD700),
    //         ),
    //       ),
    //       Container(
    //         width: 1,
    //         height: 40,
    //         color: const Color(0xFF4A4A4A),
    //       ),
    //       Expanded(
    //         child: _buildStatItem(
    //           icon: Icons.local_fire_department,
    //           title: 'Streak',
    //           value: '7 days',
    //           color: const Color(0xFFFF6B6B),
    //         ),
    //       ),
    //       Container(
    //         width: 1,
    //         height: 40,
    //         color: const Color(0xFF4A4A4A),
    //       ),
    //       Expanded(
    //         child: _buildStatItem(
    //           icon: Icons.stars,
    //           title: 'Level',
    //           value: '12',
    //           color: const Color(0xFF6366F1),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildGamesGrid() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                'Choose Your Game',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.grid_view,
                      color: Colors.grey[400],
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '4 Games',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: games.length,
              itemBuilder: (context, index) {
                return _buildGameCard(games[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard(GameData game, int index) {
    bool isSelected = selectedGameIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGameIndex = isSelected ? -1 : index;
        });

        // Navigate to specific game after a short delay
        Future.delayed(const Duration(milliseconds: 300), () {
          _navigateToGame(game);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..scale(isSelected ? 0.95 : 1.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: game.gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: game.gradientColors.first.withOpacity(0.3),
              blurRadius: isSelected ? 20 : 10,
              spreadRadius: isSelected ? 2 : 0,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned(
              top: -20,
              right: -20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          game.icon,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const Spacer(),
                      if (game.isNew)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD700),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'NEW',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Title and subtitle
                  Text(
                    game.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    game.subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),



                  // Game info

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToGame(GameData game) {
    // Show game selection feedback
    if(game.title == 'Error Hunt'){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>ErrorHunt()));
    }else if(game.title == 'Translation Match'){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>TranslationMatchGame()));
    }else if(game.title == 'Grammar Quest'){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>FindWordMeaningGame()));
    }


    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Starting ${game.title}...'),
    //     backgroundColor: game.gradientColors.first,
    //     duration: const Duration(seconds: 2),
    //     behavior: SnackBarBehavior.floating,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //   ),
    // );

    // Here you would navigate to the specific game screen
    // For example:
    // if (game.title == 'Translation Match') {
    //   Navigator.push(context, MaterialPageRoute(builder: (_) => TranslationMatchGame()));
    // }
  }
}

class GameData {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final List<Color> gradientColors;
  final String level;
  final String duration;
  final String points;
  final bool isNew;
  final double progress;

  GameData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.gradientColors,
    required this.level,
    required this.duration,
    required this.points,
    required this.isNew,
    required this.progress,
  });
}

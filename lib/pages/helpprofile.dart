

import 'package:flutter/cupertino.dart';

class WeeklyProgressChart extends StatelessWidget {
  const WeeklyProgressChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weekly Progress',
            style: TextStyle(
              color: CupertinoColors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 32),

          // Chart Container
          SizedBox(
            height: 200,
            child: Row(
              children: [
                // Y-axis labels
                SizedBox(
                  width: 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildYAxisLabel('8'),
                      _buildYAxisLabel('6'),
                      _buildYAxisLabel('4'),
                      _buildYAxisLabel('2'),
                      _buildYAxisLabel('0'),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                // Bar Chart
                Expanded(
                  child: Column(
                    children: [
                      // Chart bars area
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildBar('Mo', 3.5, 160), // Height for max 8 = 160px
                            _buildBar('Tu', 4.5, 160),
                            _buildBar('We', 2.5, 160),
                            _buildBar('Th', 5.5, 160),
                            _buildBar('Fr', 3.8, 160),
                            _buildBar('Sa', 4.8, 160),
                            _buildBar('Su', 4.2, 160),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // X-axis day labels
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildXAxisLabel('Mo'),
                          _buildXAxisLabel('Tu'),
                          _buildXAxisLabel('We'),
                          _buildXAxisLabel('Th'),
                          _buildXAxisLabel('Fr'),
                          _buildXAxisLabel('Sa'),
                          _buildXAxisLabel('Su'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYAxisLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: Color(0xFF8E8E93),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildXAxisLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: Color(0xFF8E8E93),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildBar(String day, double value, double maxHeight) {
    // Calculate bar height based on value (max value is 8)
    double barHeight = (value / 8.0) * maxHeight;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 28,
          height: barHeight,
          decoration: BoxDecoration(
            color: const Color(0xFF8B5CF6), // Purple color matching the image
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ],
    );
  }
}


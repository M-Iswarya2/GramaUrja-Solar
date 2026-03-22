import 'package:flutter/material.dart';
import 'outage_report_screen.dart';
import 'education_hub_screen.dart';
import 'solar_recommend_screen.dart';
import 'forum_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Custom color palette for eco-friendly theme
  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color lightGreen = Color(0xFF4CAF50);
  static const Color accentGreen = Color(0xFF81C784);
  static const Color darkGreen = Color(0xFF1B5E20);
  static const Color backgroundGreen = Color(0xFFF1F8E9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGreen,
      appBar: AppBar(
        title: const Text(
          "Grama Urja",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryGreen, lightGreen],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(context),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: _getChildAspectRatio(context),
              ),
              delegate: SliverChildListDelegate([
                _buildEnhancedCard(
                  context,
                  "Report Outage",
                  Icons.report_problem,
                  const LinearGradient(
                    colors: [Color(0xFFFF6B6B), Color(0xFFFF8E8E)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OutageReportScreen(),
                      ),
                    );
                  },
                ),
                _buildEnhancedCard(
                  context,
                  "Energy Education",
                  Icons.school,
                  const LinearGradient(
                    colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EnergyEducationScreen(),
                      ),
                    );
                  },
                ),
                _buildEnhancedCard(
                  context,
                  "Solar Suggestion",
                  Icons.wb_sunny,
                  const LinearGradient(
                    colors: [Color(0xFFFFB347), Color(0xFFFFCC02)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SolarRecommendScreen(),
                      ),
                    );
                  },
                ),
                _buildEnhancedCard(
                  context,
                  "User Forum",
                  Icons.forum,
                  const LinearGradient(
                    colors: [primaryGreen, accentGreen],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ForumScreen(),
                      ),
                    );
                  },
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // Responsive cross axis count based on screen width
  int _getCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 900) {
      return 4; // Desktop - all cards in one row
    } else if (screenWidth > 600) {
      return 3; // Tablet
    } else {
      return 2; // Mobile - always 2 columns to ensure all cards are visible
    }
  }

  // Responsive aspect ratio for cards
  double _getChildAspectRatio(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 900) {
      return 1.0; // Desktop
    } else if (screenWidth > 600) {
      return 1.1; // Tablet
    } else {
      return 0.9; // Mobile - taller cards to prevent text overflow
    }
  }

  // Responsive text size
  double _getTextSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return 16.0; // Tablet/Desktop
    } else {
      return 14.0; // Mobile - smaller text to fit better
    }
  }

  Widget _buildEnhancedCard(
      BuildContext context,
      String title,
      IconData icon,
      Gradient gradient,
      VoidCallback onTap,
      ) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 200),
      tween: Tween(begin: 1.0, end: 1.0),
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: GestureDetector(
            onTapDown: (_) {
              // Trigger scale animation on tap
            },
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, -2),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(20),
                  splashColor: Colors.white.withOpacity(0.3),
                  highlightColor: Colors.white.withOpacity(0.1),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            icon,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: _getTextSize(context),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2, // Line height for better spacing
                            shadows: const [
                              Shadow(
                                color: Colors.black26,
                                offset: Offset(1, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Alternative version with AnimatedScale for tap animation
class AnimatedFeatureCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Gradient gradient;
  final VoidCallback onTap;

  const AnimatedFeatureCard({
    super.key,
    required this.title,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  @override
  State<AnimatedFeatureCard> createState() => _AnimatedFeatureCardState();
}

class _AnimatedFeatureCardState extends State<AnimatedFeatureCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _animationController.forward();
      },
      onTapUp: (_) {
        _animationController.reverse();
        widget.onTap();
      },
      onTapCancel: () {
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                gradient: widget.gradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onTap,
                  borderRadius: BorderRadius.circular(20),
                  splashColor: Colors.white.withOpacity(0.3),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            widget.icon,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                offset: Offset(1, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
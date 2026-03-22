import 'package:flutter/material.dart';

void main() {
  runApp(const GramaUrjaApp());
}

class GramaUrjaApp extends StatelessWidget {
  const GramaUrjaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grama Urja',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFEF8C00),
        fontFamily: 'Roboto',
      ),
      home: const EnergyEducationScreen(),
    );
  }
}

// ─── Data Model ────────────────────────────────────────────────────────────────

class EnergyTopic {
  final String emoji;
  final String title;
  final String description;
  final String tag;
  final Color accentColor;
  final List<String> keyPoints;

  const EnergyTopic({
    required this.emoji,
    required this.title,
    required this.description,
    required this.tag,
    required this.accentColor,
    required this.keyPoints,
  });
}

// ─── Screen ────────────────────────────────────────────────────────────────────

class EnergyEducationScreen extends StatefulWidget {
  const EnergyEducationScreen({super.key});

  @override
  State<EnergyEducationScreen> createState() => _EnergyEducationScreenState();
}

class _EnergyEducationScreenState extends State<EnergyEducationScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late List<AnimationController> _cardControllers;
  late List<Animation<double>> _cardAnimations;

  static const List<EnergyTopic> _allTopics = [
    EnergyTopic(
      emoji: '🌞',
      title: 'Benefits of Solar Power',
      description:
      'Solar panels convert sunlight directly into electricity using photovoltaic cells. They are ideal for rural villages, rooftop installations, and irrigation systems — cutting costs and carbon footprint simultaneously.',
      tag: 'Solar',
      accentColor: Color(0xFFEF8C00),
      keyPoints: [
        'Zero fuel cost after installation',
        'Low maintenance requirements',
        'Powers homes, farms & street lights',
        'Excess power can be sold to the grid',
      ],
    ),
    EnergyTopic(
      emoji: '🔆',
      title: 'How Solar Panels Work',
      description:
      'Photovoltaic (PV) cells are made of semiconductor materials like silicon. When sunlight hits them, electrons are knocked loose and flow as direct current (DC) electricity, which an inverter converts to AC for home use.',
      tag: 'Solar',
      accentColor: Color(0xFFF59E0B),
      keyPoints: [
        'Sunlight excites electrons in silicon cells',
        'DC power converted to AC via inverter',
        'Works even on cloudy days (reduced output)',
        'Panels last 25–30 years on average',
      ],
    ),
    EnergyTopic(
      emoji: '🏡',
      title: 'Rooftop Solar for Homes',
      description:
      'Rooftop solar systems let households generate their own electricity, reduce bills, and feed surplus power back into the grid under net-metering policies. Even a small 1 kW system can cover basic lighting and fans.',
      tag: 'Solar',
      accentColor: Color(0xFFEF8C00),
      keyPoints: [
        '1 kW covers basic lighting & fans',
        'Net-metering earns credit for surplus power',
        'Government subsidies available in India',
        'Reduces monthly electricity bill significantly',
      ],
    ),
    EnergyTopic(
      emoji: '🚜',
      title: 'Solar for Agriculture',
      description:
      'Solar-powered water pumps and drip irrigation systems help farmers reduce diesel costs and irrigate fields reliably. The PM-KUSUM scheme supports farmers in adopting solar pumps across rural India.',
      tag: 'Solar',
      accentColor: Color(0xFFF59E0B),
      keyPoints: [
        'Replaces costly diesel irrigation pumps',
        'PM-KUSUM scheme offers 90% subsidy',
        'Powers cold storage for perishable crops',
        'Reduces carbon emissions from farming',
      ],
    ),
    EnergyTopic(
      emoji: '🔋',
      title: 'Solar + Battery Storage',
      description:
      'Pairing solar panels with battery storage ensures power availability even after sunset or during cloudy days. Lithium-ion and lead-acid batteries store excess solar energy for use at night or during outages.',
      tag: 'Solar',
      accentColor: Color(0xFFEF8C00),
      keyPoints: [
        'Stores surplus daytime solar energy',
        'Provides power during nights & outages',
        'Lithium-ion batteries last 10+ years',
        'Critical for off-grid rural electrification',
      ],
    ),
    EnergyTopic(
      emoji: '🏫',
      title: 'Solar for Schools & Community',
      description:
      'Installing solar panels on school and community building rooftops provides clean, uninterrupted power for education and public services. Solar-lit classrooms and health centres have transformed thousands of villages.',
      tag: 'Solar',
      accentColor: Color(0xFFF59E0B),
      keyPoints: [
        'Powers fans, lights & computers in schools',
        'Funds saved on bills go back to community',
        'Solar street lights improve village safety',
        'Inspires next generation of green thinkers',
      ],
    ),
  ];

  List<EnergyTopic> get _filteredTopics {
    if (_searchQuery.isEmpty) return _allTopics;
    final q = _searchQuery.toLowerCase();
    return _allTopics.where((t) {
      return t.title.toLowerCase().contains(q) ||
          t.description.toLowerCase().contains(q) ||
          t.tag.toLowerCase().contains(q);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _cardControllers = List.generate(
      _allTopics.length,
          (i) => AnimationController(
        duration: const Duration(milliseconds: 320),
        vsync: this,
      ),
    );
    _cardAnimations = _cardControllers
        .map((c) => CurvedAnimation(parent: c, curve: Curves.easeInOut))
        .toList();
  }

  @override
  void dispose() {
    for (final c in _cardControllers) {
      c.dispose();
    }
    _searchController.dispose();
    super.dispose();
  }

  void _toggle(int index) {
    final controller = _cardControllers[index];
    if (controller.isCompleted) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF0),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(child: _buildSearchBar()),
          SliverToBoxAdapter(child: _buildStatsRow()),
          _buildTopicList(),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  // ─── Sliver AppBar ────────────────────────────────────────────────────────

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      stretch: true,
      backgroundColor: const Color(0xFFB45309),
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB45309), Color(0xFFF59E0B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              // Decorative circles
              Positioned(
                right: -40,
                top: -40,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.06),
                  ),
                ),
              ),
              Positioned(
                left: -20,
                bottom: 20,
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
              ),
              // Content
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Text(
                              '🌞',
                              style: TextStyle(fontSize: 26),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Grama Urja',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Text(
                                'Solar Energy',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.2), width: 1),
                        ),
                        child: const Text(
                          '☀️  Harnessing the power of sunlight for every village',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.5,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      title: const Text(
        'Solar Energy',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
      ),
    );
  }

  // ─── Search Bar ───────────────────────────────────────────────────────────

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: TextField(
        controller: _searchController,
        onChanged: (v) => setState(() => _searchQuery = v),
        decoration: InputDecoration(
          hintText: 'Search solar topics — panels, storage, farming…',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          prefixIcon:
          const Icon(Icons.search_rounded, color: Color(0xFFEF8C00)),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear_rounded, size: 20),
            onPressed: () {
              _searchController.clear();
              setState(() => _searchQuery = '');
            },
          )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
            BorderSide(color: const Color(0xFFEF8C00).withOpacity(0.25)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
            const BorderSide(color: Color(0xFFEF8C00), width: 1.5),
          ),
        ),
      ),
    );
  }

  // ─── Stats Row ────────────────────────────────────────────────────────────

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(
        children: [
          _statChip('📚', '${_allTopics.length} Topics'),
          const SizedBox(width: 10),
          _statChip('☀️', 'Solar Only'),
          const SizedBox(width: 10),
          _statChip('🌿', 'Free to Learn'),
        ],
      ),
    );
  }

  Widget _statChip(String emoji, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEF8C00).withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 13)),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFFB45309),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Topic List ───────────────────────────────────────────────────────────

  Widget _buildTopicList() {
    final topics = _filteredTopics;

    if (topics.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: 64),
          child: Column(
            children: [
              const Text('🔍', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              Text(
                'No topics found for "$_searchQuery"',
                style: TextStyle(color: Colors.grey[500], fontSize: 15),
              ),
            ],
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, i) {
          final topic = topics[i];
          final globalIndex = _allTopics.indexOf(topic);
          return _TopicCard(
            topic: topic,
            animation: _cardAnimations[globalIndex],
            onTap: () => _toggle(globalIndex),
          );
        },
        childCount: topics.length,
      ),
    );
  }
}

// ─── Topic Card Widget ─────────────────────────────────────────────────────────

class _TopicCard extends StatelessWidget {
  final EnergyTopic topic;
  final Animation<double> animation;
  final VoidCallback onTap;

  const _TopicCard({
    required this.topic,
    required this.animation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            elevation: 3,
            shadowColor: topic.accentColor.withOpacity(0.25),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(20),
              splashColor: topic.accentColor.withOpacity(0.08),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: animation.value > 0
                        ? topic.accentColor.withOpacity(0.4)
                        : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    _buildHeader(),
                    _buildExpandedContent(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Emoji icon container
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  topic.accentColor.withOpacity(0.15),
                  topic.accentColor.withOpacity(0.28),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(topic.emoji, style: const TextStyle(fontSize: 26)),
            ),
          ),
          const SizedBox(width: 14),
          // Title + tag
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xFF1A1A1A),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                  decoration: BoxDecoration(
                    color: topic.accentColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    topic.tag,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: topic.accentColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Expand icon
          AnimatedRotation(
            turns: animation.value * 0.5,
            duration: const Duration(milliseconds: 320),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: topic.accentColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: topic.accentColor,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedContent() {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBF0),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            border: Border(
              top: BorderSide(
                color: topic.accentColor.withOpacity(0.15),
                width: 1,
              ),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Description
              Text(
                topic.description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF444444),
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 16),
              // Divider
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 16,
                    decoration: BoxDecoration(
                      color: topic.accentColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Key Points',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: Color(0xFF222222),
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Key points
              ...topic.keyPoints.map(
                    (point) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: topic.accentColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          point,
                          style: const TextStyle(
                            fontSize: 13.5,
                            color: Color(0xFF555555),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              // Learn more chip
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        topic.accentColor.withOpacity(0.8),
                        topic.accentColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Learn More',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_rounded,
                          color: Colors.white, size: 14),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
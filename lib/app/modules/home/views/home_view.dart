import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../widgets/app_main_header.dart';
import '../../../widgets/app_streak_chip.dart';
import '../controllers/home_controller.dart';
import '../data/home_topics.dart';
import '../widgets/learning_path_node.dart';
import '../widgets/unit_banner.dart';

class _ChapterSection {
  final String unitText;
  final String titleText;
  final Color topColor;
  final Color bottomColor;
  final Color borderHighlightColor;
  final int topicIndex;
  final List<PathNodeData> nodes;

  const _ChapterSection({
    required this.unitText,
    required this.titleText,
    required this.topColor,
    required this.bottomColor,
    required this.borderHighlightColor,
    required this.topicIndex,
    required this.nodes,
  });

  double get progress {
    if (nodes.isEmpty) return 0.0;
    final doneCount = nodes.where((n) => n.done).length;
    return doneCount / nodes.length;
  }
}

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const List<_ChapterSection> _chapters = [
    _ChapterSection(
      unitText: 'BAB 1',
      titleText: 'Pengenalan Kimia',
      topColor: AppColors.blue500,
      bottomColor: AppColors.blue700,
      borderHighlightColor: AppColors.blue300,
      topicIndex: 0,
      nodes: [
        PathNodeData(
          PathNodeType.star,
          done: true,
          title: 'Partikel Penyusun Atom',
          description: 'Mengenal proton, neutron, dan elektron dalam inti atom.',
        ),
        PathNodeData(
          PathNodeType.star,
          done: true,
          title: 'Nomor Atom & Massa',
          description: 'Menghitung jumlah partikel subatom dan memahami isotop.',
        ),
        PathNodeData(
          PathNodeType.trophy,
          done: true,
          title: 'Konfigurasi Elektron',
          description: 'Mempelajari susunan elektron pada kulit dan subkulit.',
        ),
        PathNodeData(
          PathNodeType.special,
          title: 'Tabel Periodik Unsur',
          description: 'Memahami golongan, periode, dan sifat keperiodikan unsur.',
        ),
        PathNodeData(
          PathNodeType.locked,
          title: 'Jari-jari Atom',
          description: 'Mengenal tren ukuran atom dalam sistem periodik.',
        ),
        PathNodeData(
          PathNodeType.locked,
          title: 'Energi Ionisasi',
          description: 'Mempelajari energi untuk melepaskan elektron terluar.',
        ),
      ],
    ),
    _ChapterSection(
      unitText: 'BAB 2',
      titleText: 'Ikatan Kimia',
      topColor: AppColors.teal,
      bottomColor: AppColors.darkTeal,
      borderHighlightColor: AppColors.lightTeal,
      topicIndex: 1,
      nodes: [
        PathNodeData(
          PathNodeType.jump,
          title: 'Dasar Ikatan Kimia',
          description: 'Memahami kestabilan atom, aturan oktet, dan valensi.',
        ),
        PathNodeData(
          PathNodeType.locked,
          title: 'Ikatan Ion',
          description: 'Serah terima elektron antara logam dan nonlogam.',
        ),
        PathNodeData(
          PathNodeType.locked,
          title: 'Ikatan Kovalen',
          description: 'Pemakaian bersama pasangan elektron antar atom.',
        ),
        PathNodeData(
          PathNodeType.locked,
          title: 'Ikatan Logam',
          description: 'Lautan elektron bebas pada struktur logam.',
        ),
      ],
    ),
  ];

  void _openTopic([int index = 0]) {
    final list = controller.topics.isNotEmpty
        ? controller.topics
        : HomeTopics.items;
    final topic = list.isNotEmpty
        ? list[index % list.length]
        : HomeTopics.items.first;
    controller.onTopicSelected(topic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header bawaan KimiaXplore
            const AppMainHeader(
              title: 'Home',
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.md,
              ),
              actions: [AppStreakChip()],
            ),

            // Learning Path Multi-Bab dengan Banner Bab melayang di atasnya
            Expanded(
              child: _HomePathBody(
                chapters: _chapters,
                onOpenTopic: _openTopic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomePathBody extends StatefulWidget {
  final List<_ChapterSection> chapters;
  final void Function(int topicIndex) onOpenTopic;

  const _HomePathBody({
    required this.chapters,
    required this.onOpenTopic,
  });

  @override
  State<_HomePathBody> createState() => _HomePathBodyState();
}

class _HomePathBodyState extends State<_HomePathBody> {
  static const List<int> _offsetDirections = [0, 1, 0, -1];
  static const double _nodeWidth = 82.0;
  static const double _nodeHeight = 66.0;
  static const double _nodeDepth = 8.0;
  static const double _itemGap = 36.0;
  static const double _bannerHeight = 116.0;
  static const double _dividerHeight = 32.0;

  final ScrollController _scrollController = ScrollController();
  final List<double> _chapterThresholds = [];
  int _activeChapterIndex = 0;
  int? _selectedChapterIndex;
  int? _selectedNodeIndex;

  void _toggleNodeSelection(int chapterIndex, int nodeIndex) {
    setState(() {
      if (_selectedChapterIndex == chapterIndex &&
          _selectedNodeIndex == nodeIndex) {
        _selectedChapterIndex = null;
        _selectedNodeIndex = null;
      } else {
        _selectedChapterIndex = chapterIndex;
        _selectedNodeIndex = nodeIndex;
      }
    });
  }

  void _clearSelection() {
    if (_selectedChapterIndex != null || _selectedNodeIndex != null) {
      setState(() {
        _selectedChapterIndex = null;
        _selectedNodeIndex = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_chapterThresholds.isEmpty) return;
    final offset = _scrollController.offset;
    int nextIndex = 0;
    for (int i = 0; i < _chapterThresholds.length; i++) {
      if (offset >= _chapterThresholds[i]) {
        nextIndex = i;
      }
    }
    if (nextIndex != _activeChapterIndex) {
      setState(() => _activeChapterIndex = nextIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final centerX = constraints.maxWidth / 2;
        const double pathSidePadding = AppSpacing.xl;
        final double sideOffset =
            (centerX - pathSidePadding - (_nodeWidth / 2)).clamp(
              0.0,
              double.infinity,
            );

        final List<_ChapterLayout> layouts = [];
        _chapterThresholds.clear();

        double currentY = AppSpacing.sm + _bannerHeight + AppSpacing.xl;

        for (int c = 0; c < widget.chapters.length; c++) {
          final chapter = widget.chapters[c];
          double? dividerTop;

          if (c == 0) {
            _chapterThresholds.add(0.0);
          } else {
            dividerTop = currentY + AppSpacing.sm;
            final dividerCenterY = dividerTop + (_dividerHeight / 2);
            final bannerBottomY = AppSpacing.sm + _bannerHeight;
            _chapterThresholds.add(
              (dividerCenterY - bannerBottomY).clamp(0.0, double.infinity),
            );
            currentY = dividerTop + _dividerHeight + AppSpacing.xl;
          }

          final List<Offset> centers = [];
          final List<double> itemTops = [];
          final List<double> dxList = [];

          for (int i = 0; i < chapter.nodes.length; i++) {
            final n = chapter.nodes[i];
            final dx =
                _offsetDirections[i % _offsetDirections.length] * sideOffset;
            itemTops.add(currentY);
            dxList.add(dx);

            double topExtra = 0;
            if (n.type == PathNodeType.special) {
              topExtra = 38.0;
            } else if (n.type == PathNodeType.jump) {
              topExtra = 54.0;
            }

            final boxCenterY = currentY + topExtra + (_nodeHeight / 2);
            centers.add(Offset(centerX + dx, boxCenterY));

            currentY += topExtra + _nodeHeight + _nodeDepth + _itemGap;
          }

          layouts.add(
            _ChapterLayout(
              chapter: chapter,
              dividerTop: dividerTop,
              centers: centers,
              itemTops: itemTops,
              dxList: dxList,
            ),
          );
        }

        final activeChapter = widget.chapters[_activeChapterIndex];

        double? calloutTop;
        double? calloutArrowX;
        PathNodeData? selectedNode;
        int? selectedTopicIndex;
        String calloutButtonLabel = 'LANJUTKAN';

        if (_selectedChapterIndex != null && _selectedNodeIndex != null) {
          final cIdx = _selectedChapterIndex!;
          final nIdx = _selectedNodeIndex!;
          if (cIdx >= 0 &&
              cIdx < layouts.length &&
              nIdx >= 0 &&
              nIdx < layouts[cIdx].chapter.nodes.length) {
            final layout = layouts[cIdx];
            selectedNode = layout.chapter.nodes[nIdx];
            selectedTopicIndex = layout.chapter.topicIndex;
            calloutButtonLabel = selectedNode.done
                ? 'ULAS'
                : (nIdx == 0 ? 'MULAI' : 'LANJUTKAN');
            calloutTop = layout.centers[nIdx].dy + (_nodeHeight / 2) + _nodeDepth + 6;
            calloutArrowX = layout.centers[nIdx].dx - AppSpacing.xl;
          }
        }

        final totalHeight = (calloutTop != null && calloutTop + 210 > currentY)
            ? calloutTop + 220
            : currentY + AppSpacing.xxxl;

        return Stack(
          children: [
            GestureDetector(
              onTap: _clearSelection,
              behavior: HitTestBehavior.translucent,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: totalHeight,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Pola titik-titik papan pin (pegboard) di paling belakang
                      const Positioned.fill(
                        child: IgnorePointer(
                          child: CustomPaint(
                            painter: _PegboardBackgroundPainter(),
                          ),
                        ),
                      ),
                      // Semua garis konektor bab digambar di atas background & tidak menangkap sentuhan
                      for (int c = 0; c < layouts.length; c++)
                        Positioned.fill(
                          child: IgnorePointer(
                            child: CustomPaint(
                              painter: _PathConnectorPainter(
                                centers: layouts[c].centers,
                                nodes: layouts[c].chapter.nodes,
                              ),
                            ),
                          ),
                        ),
                      for (int c = 0; c < layouts.length; c++) ...[
                        // Pemisah antar bab: divider + judul bab di tengahnya
                        if (layouts[c].dividerTop != null)
                          Positioned(
                            top: layouts[c].dividerTop,
                            left: AppSpacing.xl,
                            right: AppSpacing.xl,
                            height: _dividerHeight,
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Divider(
                                    color: AppColors.border,
                                    thickness: 2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.md,
                                  ),
                                  child: Text(
                                    layouts[c].chapter.titleText,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textMedium,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: Divider(
                                    color: AppColors.border,
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        // Card kotak level di dalam bab
                        for (int i = 0; i < layouts[c].chapter.nodes.length; i++)
                          Positioned(
                            top: layouts[c].itemTops[i],
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Transform.translate(
                                offset: Offset(layouts[c].dxList[i], 0),
                                child:
                                    layouts[c].chapter.nodes[i].type ==
                                        PathNodeType.jump
                                    ? JumpNode(
                                        onTap: () {
                                          _clearSelection();
                                          widget.onOpenTopic(
                                            layouts[c].chapter.topicIndex,
                                          );
                                        },
                                      )
                                    : PathNode(
                                        type: layouts[c].chapter.nodes[i].type,
                                        done: layouts[c].chapter.nodes[i].done,
                                        width: _nodeWidth,
                                        height: _nodeHeight,
                                        depth: _nodeDepth,
                                        isSelected:
                                            _selectedChapterIndex == c &&
                                            _selectedNodeIndex == i,
                                        onTap: () =>
                                            _toggleNodeSelection(c, i),
                                      ),
                              ),
                            ),
                          ),
                      ],
                      // Kartu pop-up detail di bawah card yang diklik
                      if (selectedNode != null &&
                          calloutTop != null &&
                          calloutArrowX != null &&
                          selectedTopicIndex != null)
                        Positioned(
                          top: calloutTop,
                          left: AppSpacing.xl,
                          right: AppSpacing.xl,
                          child: NodeCalloutCard(
                            type: selectedNode.type,
                            title: selectedNode.title,
                            description: selectedNode.description,
                            buttonLabel: calloutButtonLabel,
                            arrowOffsetX: calloutArrowX,
                            onActionTap: () {
                              final targetTopic = selectedTopicIndex!;
                              _clearSelection();
                              widget.onOpenTopic(targetTopic);
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            // Floating Banner Bab yang selalu melayang di atas & otomatis berganti
            Positioned(
              top: AppSpacing.sm,
              left: AppSpacing.xl,
              right: AppSpacing.xl,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: UnitBanner(
                  key: ValueKey(activeChapter.unitText),
                  unitText: activeChapter.unitText,
                  titleText: activeChapter.titleText,
                  progress: activeChapter.progress,
                  topColor: activeChapter.topColor,
                  bottomColor: activeChapter.bottomColor,
                  borderHighlightColor: activeChapter.borderHighlightColor,
                  onTapUnit: () => widget.onOpenTopic(activeChapter.topicIndex),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ChapterLayout {
  final _ChapterSection chapter;
  final double? dividerTop;
  final List<Offset> centers;
  final List<double> itemTops;
  final List<double> dxList;

  const _ChapterLayout({
    required this.chapter,
    required this.dividerTop,
    required this.centers,
    required this.itemTops,
    required this.dxList,
  });
}

class _PathConnectorPainter extends CustomPainter {
  final List<Offset> centers;
  final List<PathNodeData> nodes;

  _PathConnectorPainter({
    required this.centers,
    required this.nodes,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (centers.length < 2) return;

    const double cornerRadius = 24.0;

    for (int i = 0; i < centers.length - 1; i++) {
      final p1 = centers[i];
      final p2 = centers[i + 1];
      final isCompleted = nodes[i].done;

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 7.0
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = isCompleted ? AppColors.blue100 : AppColors.border;

      final path = Path()..moveTo(p1.dx, p1.dy);
      final dxDiff = p2.dx - p1.dx;

      if (dxDiff.abs() < 1.0) {
        path.lineTo(p2.dx, p2.dy);
      } else if (i.isEven) {
        final sign = dxDiff > 0 ? 1.0 : -1.0;
        final r = cornerRadius.clamp(0.0, dxDiff.abs() / 2);
        path.lineTo(p2.dx - sign * r, p1.dy);
        path.quadraticBezierTo(p2.dx, p1.dy, p2.dx, p1.dy + r);
        path.lineTo(p2.dx, p2.dy);
      } else {
        final sign = dxDiff > 0 ? 1.0 : -1.0;
        final r = cornerRadius.clamp(0.0, dxDiff.abs() / 2);
        path.lineTo(p1.dx, p2.dy - r);
        path.quadraticBezierTo(p1.dx, p2.dy, p1.dx + sign * r, p2.dy);
        path.lineTo(p2.dx, p2.dy);
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _PathConnectorPainter oldDelegate) {
    return oldDelegate.centers != centers || oldDelegate.nodes != nodes;
  }
}

class _PegboardBackgroundPainter extends CustomPainter {
  const _PegboardBackgroundPainter();

  static const double _spacing = 42.0;
  static const double _radius = 3.2;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.85)
      ..style = PaintingStyle.fill;

    final startX = (size.width % _spacing) / 2;
    const startY = 20.0;

    for (double y = startY; y < size.height; y += _spacing) {
      for (double x = startX; x < size.width; x += _spacing) {
        canvas.drawCircle(Offset(x, y), _radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _PegboardBackgroundPainter oldDelegate) => false;
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Merender badge SVG versi terkunci sebagai siluet abu-abu bersih:
/// perisai luar & dalam tetap terlihat, sedangkan maskot/ikon di dalamnya
/// diratakan menjadi satu warna siluet tanpa wajah atau tekstur.
class LockedBadgeSilhouette extends StatefulWidget {
  final String assetPath;
  final double width;
  final double height;

  const LockedBadgeSilhouette({
    super.key,
    required this.assetPath,
    required this.width,
    required this.height,
  });

  @override
  State<LockedBadgeSilhouette> createState() => _LockedBadgeSilhouetteState();
}

class _LockedBadgeSilhouetteState extends State<LockedBadgeSilhouette> {
  static final Map<String, String> _cache = {};
  String? _svgData;

  @override
  void initState() {
    super.initState();
    _loadSilhouette();
  }

  @override
  void didUpdateWidget(covariant LockedBadgeSilhouette oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assetPath != widget.assetPath) {
      _loadSilhouette();
    }
  }

  Future<void> _loadSilhouette() async {
    final cached = _cache[widget.assetPath];
    if (cached != null) {
      if (mounted) setState(() => _svgData = cached);
      return;
    }

    final raw = await rootBundle.loadString(widget.assetPath);
    final transformed = _toSilhouetteSvg(raw);
    _cache[widget.assetPath] = transformed;
    if (mounted) {
      setState(() => _svgData = transformed);
    }
  }

  static String _toSilhouetteSvg(String svg) {
    var result = svg;

    // 1. Perisai luar (#paint1) dan perisai dalam (#paint2) -> abu-abu terang
    result = result.replaceAll('fill="url(#paint1)"', 'fill="#CDD7E2"');
    result = result.replaceAll('fill="url(#paint2)"', 'fill="#E4ECF4"');

    // 2. Semua fill selain none & dua warna perisai di atas -> satu warna siluet
    result = result.replaceAllMapped(
      RegExp(r'fill="(?!none"|#CDD7E2"|#E4ECF4")[^"]+"'),
      (_) => 'fill="#B2C0CE"',
    );

    // 3. Semua stroke selain none -> samakan dengan warna siluet
    result = result.replaceAllMapped(
      RegExp(r'stroke="(?!none")[^"]+"'),
      (_) => 'stroke="#B2C0CE"',
    );

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final data = _svgData;
    if (data == null) {
      return SizedBox(width: widget.width, height: widget.height);
    }

    return SvgPicture.string(
      data,
      width: widget.width,
      height: widget.height,
      fit: BoxFit.contain,
    );
  }
}

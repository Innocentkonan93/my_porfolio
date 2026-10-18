import 'package:flutter/material.dart';

/// Personal photos shared by the three portfolio designs.
class PortfolioGallery extends StatefulWidget {
  const PortfolioGallery({
    super.key,
    required this.images,
    required this.french,
  });

  final List<String> images;
  final bool french;

  @override
  State<PortfolioGallery> createState() => _PortfolioGalleryState();
}

class _PortfolioGalleryState extends State<PortfolioGallery> {
  final _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _move(int direction) {
    _scroll.animateTo(
      (_scroll.offset + direction * 320).clamp(
        0,
        _scroll.position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  void _open(int initial) {
    var selected = initial;
    showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, update) => Dialog(
          insetPadding: const EdgeInsets.all(16),
          clipBehavior: Clip.antiAlias,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100, maxHeight: 800),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${widget.french ? 'Dans les coulisses' : 'Behind the scenes'} · ${selected + 1}/${widget.images.length}',
                        ),
                      ),
                      IconButton(
                        tooltip: widget.french ? 'Fermer' : 'Close',
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: InteractiveViewer(
                    key: ValueKey(selected),
                    minScale: 1,
                    maxScale: 4,
                    child: Center(
                      child: Image.asset(
                        widget.images[selected],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        tooltip: widget.french
                            ? 'Photo précédente'
                            : 'Previous photo',
                        onPressed: selected > 0
                            ? () => update(() => selected--)
                            : null,
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 24),
                      IconButton(
                        tooltip: widget.french
                            ? 'Photo suivante'
                            : 'Next photo',
                        onPressed: selected < widget.images.length - 1
                            ? () => update(() => selected++)
                            : null,
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) return const SizedBox.shrink();
    final compact = MediaQuery.sizeOf(context).width < 600;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.french
              ? 'Rencontres, partages et moments de vie.'
              : 'People, shared experiences and everyday moments.',
          style: const TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: compact ? 250 : 320,
          child: ListView.separated(
            controller: _scroll,
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length,
            separatorBuilder: (_, _) => const SizedBox(width: 16),
            itemBuilder: (context, index) => SizedBox(
              width: compact ? 210 : 270,
              child: Material(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: () => _open(index),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        widget.images[index],
                        fit: BoxFit.cover,
                        cacheWidth: 800,
                        semanticLabel:
                            '${widget.french ? 'Agrandir la photo' : 'Enlarge photo'} ${index + 1}',
                      ),
                      const Positioned(
                        right: 12,
                        bottom: 12,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.black54,
                          child: Icon(
                            Icons.open_in_full,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Text(
                widget.french
                    ? '${widget.images.length} photos · Explorer les moments'
                    : '${widget.images.length} photos · Explore the moments',
              ),
            ),
            IconButton(
              tooltip: widget.french ? 'Précédent' : 'Previous',
              onPressed: () => _move(-1),
              icon: const Icon(Icons.arrow_back),
            ),
            IconButton(
              tooltip: widget.french ? 'Suivant' : 'Next',
              onPressed: () => _move(1),
              icon: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ],
    );
  }
}

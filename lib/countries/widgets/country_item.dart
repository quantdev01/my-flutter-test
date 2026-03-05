import 'package:flutter/material.dart';
import 'package:my_flutter_test/core/services/favorites_service.dart';
import 'package:my_flutter_test/theme/app_colors.dart';
import 'package:my_flutter_test/utils/constants.dart';

class CountryItem extends StatefulWidget {
  final String imageUrl;
  final String population;
  final String title;
  final String cca2;
  const CountryItem({
    required this.imageUrl,
    required this.title,
    required this.population,
    required this.cca2,
    super.key,
  });

  @override
  State<CountryItem> createState() => _CountryItemState();
}

class _CountryItemState extends State<CountryItem> {
  bool isFavorite = false;
  final _favoritesService =
      FavoritesService(); // Assuming FavoritesService exists

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  Future<void> _checkFavorite() async {
    final fav = await _favoritesService.isFavorite(widget.cca2);
    if (mounted) {
      setState(() {
        isFavorite = fav;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Hero(
            tag: 'flag-${widget.cca2}',
            child: SizedBox(
              height: kMediaSize(context).height * 0.07,
              width: kMediaSize(context).width * 0.25,
              child: widget.imageUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(widget.imageUrl, fit: BoxFit.cover),
                    )
                  : const Text('Image not found'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Population: ${widget.population}',
                  style: const TextStyle(
                    color: AppColors.greySearchColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: () async {
              await _favoritesService.toggleFavorite(widget.cca2);
              _checkFavorite();
            },
          ),
        ],
      ),
    );
  }
}

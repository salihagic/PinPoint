import 'package:flutter/material.dart';

class PositionInfoWidget extends StatelessWidget {
  final String latitude;
  final String longitude;
  final bool withBorder;

  const PositionInfoWidget({
    super.key,
    required this.latitude,
    required this.longitude,
    this.withBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: withBorder ? Border.all(color: Colors.black54) : null,
      ),
      padding: const EdgeInsets.all(13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Text('Latitude', style: TextStyle(fontSize: 12)),
              Text(latitude),
            ],
          ),
          Column(
            children: [
              const Text('Longitude', style: TextStyle(fontSize: 12)),
              Text(longitude),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../domain/repositories/content/model/content.dart';

class ContentCard extends StatelessWidget {
  final Content content;
  final int index;

  const ContentCard({
    super.key,
    required this.content,
    required this.index,
  });
  
  String _formatDateTime(int timestamp) {
    try {
      final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return 'Неизвестная дата';
    }
  }

  String _getAQI(int? aqi) {
    switch (aqi) {
      case 1: return '(1) Отличное качество воздуха';
      case 2: return '(2) Хорошее качество воздуха';
      case 3: return '(3) Удовлетворительное качество воздуха';
      case 4: return '(4) Плохое качество воздуха';
      case 5: return '(5) Очень плохое качество воздуха';
      default: return '(0) Качество воздуха неизвестно';
    }
  }

    Color _getAQIColor(int? aqi) {
    switch (aqi) {
      case 1: return Colors.green;
      case 2: return Colors.lightGreen;
      case 3: return Colors.yellow;
      case 4: return Colors.orange;
      case 5: return Colors.red;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageSize = 100.0;
    final pollutionData = content.list != null && index < content.list!.length 
      ? content.list![index] 
      : null;
    final aqi = pollutionData?.main?.aqi;
    return InkWell(
      //onTap: () => context.push('/content/${content.id}'),
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: imageSize,
        child: Row(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/test1.jpg',
                height: imageSize,
                width: imageSize,
                fit: BoxFit.cover,
                ),
                ),
                Expanded(
                  child: Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getAQI(aqi),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                        //color: _getAQIColor(aqi),
                        //fontWeight: FontWeight.w500,
                        ),
                        Expanded(
                          child: Text(
                            pollutionData?.dt != null 
                            ? _formatDateTime(pollutionData!.dt!)
                            : 'Дата неизвестна',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../domain/repositories/repositories.dart';

class CardOfService extends StatelessWidget {
  final Content content;
  final int index;
  const CardOfService({
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
    final pollutionData = content.list != null && index < content.list!.length 
      ? content.list![index] 
      : null;
    final aqi = pollutionData?.main?.aqi;
    final pd_co = pollutionData?.components?.co ?? 0;
    final pd_no = pollutionData?.components?.no ?? 0;
    final pd_no2 = pollutionData?.components?.no2 ?? 0;  
    final pd_o3 = pollutionData?.components?.o3 ?? 0;  
    final pd_so2 = pollutionData?.components?.so2 ?? 0;   
    final pd_pm25 = pollutionData?.components?.pm25 ?? 0; 
    final pd_pm10 = pollutionData?.components?.pm10 ?? 0;    
    final pd_nh3 = pollutionData?.components?.nh3 ?? 0;     
    final imageSizeX = 600.0;
    final imageSizeY = 250.0;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: imageSizeX,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/test1.jpg',
                height: imageSizeY,
                width: imageSizeX,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getAQI(aqi),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: _getAQIColor(aqi),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  pollutionData?.dt != null 
                    ? _formatDateTime(pollutionData!.dt!)
                    : 'Дата неизвестна',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Концентрация углекислого газа (CO): $pd_co',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Концентрация  оксида азота (NO): $pd_no',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Концентрация диоксида азота (NO2): $pd_no2',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),                
                Text(
                  'Концентрация озона (O3): $pd_o3',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Концентрация диоксида серы (SO2): $pd_so2',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Концентрация мелкодисперных частиц (PM2.5): $pd_pm25',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Концентрация крупных твердых частиц (PM10): $pd_pm10',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),                
                Text(
                  'Концентрация аммиака (NH3): $pd_nh3',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),                
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).go('/home');
                    },
                  child: Text('Вернуться на главную'),
                ),
          ),                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
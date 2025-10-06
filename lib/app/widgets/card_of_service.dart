import 'package:flutter/material.dart';

class CardOfService extends StatelessWidget {
  const CardOfService({super.key});
  @override
  Widget build(BuildContext context) {
    final imageSizeX = 600.0;
    final imageSizeY = 250.0;
    return InkWell(
      // onTap: () => context.push('/content/${content.id}'),
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: imageSizeX, // Добавляем ширину контейнера
        child: Column( // Меняем Row на Column
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
            const SizedBox(height: 8), // Добавляем отступ между картинкой и текстом
            Column( // Убираем Expanded и используем обычный Column
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Услуга №N',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4), // Отступ между заголовком и описанием
                Text(
                  'Текст Текст Текст Текст Текст Текст Текст Текст Текст Текст Текст Текст Текст Текст Текст Текст Текст',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
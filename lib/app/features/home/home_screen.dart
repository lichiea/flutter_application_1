import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/app.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _home = GetIt.I<HomeBloc>();
  void loadHome() => _home.add(HomeLoad());

  @override
  void initState() {
    loadHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Индекс качества воздуха')),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: _home,
        builder: (context, state) {
          return switch (state) {
            HomeInitial() => _buildHomeInitial(),
            HomeLoadInProgress() => _buildHomeLoadInProgress(),
            HomeLoadSuccess() => _buildHomeLoadSuccess(state),
            HomeLoadFailure() => _buildHomeLoadFailure(state),
          };
        },
      ),
    );
  }

  Widget _buildHomeInitial() => SizedBox.shrink();

  Widget _buildHomeLoadInProgress() => AppProgressIndicator();

  Widget _buildHomeLoadSuccess(HomeLoadSuccess state) {
    final content = state.content;

    // Проверяем наличие данных
    if (content.list == null || content.list!.isEmpty) {
      return Center(
        child: Text('Нет данных'),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Список индексов качества воздуха',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          // Выводим координаты если есть
          if (content.coord != null && content.coord!.lat != null && content.coord!.lon != null)
            Text(
              'Координаты: ${content.coord!.lat!.toStringAsFixed(2)}, ${content.coord!.lon!.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
                    // Выводим общее количество записей
          Text(
            'Найдено записей: ${content.list!.length}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: content.list!.length,
            itemBuilder: (_, index) => ContentCard(
              content: content,
              index: index,
            ),
            separatorBuilder: (_, __) => 16.ph,
          ),
        ],
      ),
    );
  }

  Widget _buildHomeLoadFailure(HomeLoadFailure state) {
    return AppError(
      description: state.exception.toString(),
      onTap: () => loadHome(),
    );
  }
}

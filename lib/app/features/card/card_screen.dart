import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/app.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardScreen extends StatefulWidget {
  final String contentId;
  const CardScreen({
    super.key,
    required this.contentId,
  });

  @override
  State<CardScreen> createState() => _CardScreenState();

}

class _CardScreenState extends State<CardScreen> {
  final _card = GetIt.I<CardBloc>();
  void loadCard() => _card.add(CardLoad());

  @override
  void initState() {
    loadCard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Индекс качества воздуха')),
      body: BlocBuilder<CardBloc, CardState>(
        bloc: _card,
        builder: (context, state) {
          return switch (state) {
            CardInitial() => _buildCardInitial(),
            CardLoadInProgress() => _buildCardLoadInProgress(),
            CardLoadSuccess() => _buildCardLoadSuccess(state),
            CardLoadFailure() => _buildCardLoadFailure(state),
          };
        },
      ),
    );
  }

  Widget _buildCardInitial() => SizedBox.shrink();

  Widget _buildCardLoadInProgress() => AppProgressIndicator();

  Widget _buildCardLoadSuccess(CardLoadSuccess state) {
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
            'Индекс качества воздуха #${widget.contentId}',
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
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (_, index) => CardOfService(
              content: content,
              index: int.parse(widget.contentId),
            ),
            separatorBuilder: (_, __) => 16.ph,
          ),
        ],
      ),
    );
  }

  Widget _buildCardLoadFailure(CardLoadFailure state) {
    return AppError(
      description: state.exception.toString(),
      onTap: () => loadCard(),
    );
  }
}

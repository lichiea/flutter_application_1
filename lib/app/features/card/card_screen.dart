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
  final _favoritesBloc = GetIt.I<FavoritesBloc>();
  String? _contentTitle;
  String? _contentDescription;
  bool _isFavorite = false;
  bool _isLoading = false;

  void loadCard() => _card.add(CardLoad());
  
  void _checkIfFavorite() {
    _favoritesBloc.add(FavoritesCheckIsFavorite(widget.contentId));
  }
  
  Future<void> _toggleFavorite() async {
    if (_contentTitle == null || _contentDescription == null) return;
    
    if (_isFavorite) {
      _favoritesBloc.add(FavoritesRemove(widget.contentId));
      setState(() {
        _isFavorite = false;
      });
    } else {
      _favoritesBloc.add(FavoritesAdd(
        contentId: widget.contentId,
        title: _contentTitle!,
        description: _contentDescription!,
      ));
      setState(() {
        _isFavorite = true;
      });
    }
    
    // Ждем немного и снова проверяем статус
    await Future.delayed(const Duration(milliseconds: 100));
    _checkIfFavorite();
  }

  @override
  void initState() {
    loadCard();
    _checkIfFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoritesBloc, FavoritesState>(
      bloc: _favoritesBloc,
      listener: (context, state) {
        if (state is FavoritesIsFavorite) {
          setState(() {
            _isFavorite = state.isFavorite;
            _isLoading = false;
          });
        } else if (state is FavoritesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
          setState(() {
            _isLoading = false;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Индекс качества воздуха'),
          actions: [
            // Кнопка избранного
            BlocBuilder<FavoritesBloc, FavoritesState>(
              bloc: _favoritesBloc,
              builder: (context, state) {
                return IconButton(
                  icon: _isLoading
                      ? const CircularProgressIndicator()
                      : Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: _isFavorite ? Colors.red : null,
                        ),
                  onPressed: _isLoading
                      ? null
                      : () {
                          if (_contentTitle != null && _contentDescription != null) {
                            setState(() {
                              _isLoading = true;
                            });
                            _toggleFavorite();
                          }
                        },
                );
              },
            ),
          ],
        ),
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
      ),
    );
  }

  Widget _buildCardInitial() => const SizedBox.shrink();

  Widget _buildCardLoadInProgress() => const AppProgressIndicator();

  Widget _buildCardLoadSuccess(CardLoadSuccess state) {
    final content = state.content;

    if (content.list == null || content.list!.isEmpty) {
      return const Center(
        child: Text('Нет данных'),
      );
    }
    
    final index = int.parse(widget.contentId);
    if (index < content.list!.length) {
      _contentTitle = 'Индекс качества воздуха #${(index + 1).toString()}';
      
      if (content.coord != null && content.coord!.lat != null && content.coord!.lon != null) {
        _contentDescription = 'Координаты: ${content.coord!.lat!.toStringAsFixed(2)}, ${content.coord!.lon!.toStringAsFixed(2)}';
      } else {
        _contentDescription = 'Элемент с индексом $index';
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Индекс качества воздуха #${(int.parse(widget.contentId) + 1).toString()}',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          if (content.coord != null && content.coord!.lat != null && content.coord!.lon != null)
            Text(
              'Координаты: ${content.coord!.lat!.toStringAsFixed(2)}, ${content.coord!.lon!.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _isFavorite ? Colors.red.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  _isFavorite ? 'В избранном' : 'Не в избранном',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isLoading
                  ? null
                  : () {
                      if (_contentTitle != null && _contentDescription != null) {
                        setState(() {
                          _isLoading = true;
                        });
                        _toggleFavorite();
                      }
                    },
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
              label: Text(_isFavorite ? 'Удалить из избранного' : 'Добавить в избранное'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFavorite ? Colors.red.withOpacity(0.1) : null,
                foregroundColor: _isFavorite ? Colors.red : null,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (_, index) => CardOfService(
              content: content,
              index: int.parse(widget.contentId),
            ),
            separatorBuilder: (_, __) => const SizedBox(height: 16),
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
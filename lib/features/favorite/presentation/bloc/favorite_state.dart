part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {}

class FavoriteInitial extends FavoriteState {
  @override
  List<Object?> get props => [];
}

class FavoriteStateLoading extends FavoriteState {
  @override
  List<Object?> get props => []; // Empty is fine, but can be updated if needed.
}

class FavoriteStateError extends FavoriteState {
  final String message;

  FavoriteStateError({required this.message});

  @override
  List<Object?> get props => [message];
}

class FavoriteStateLoadedAll extends FavoriteState {
  final List<Favorite> favorites;

  FavoriteStateLoadedAll({required this.favorites});

  @override
  List<Object?> get props => [favorites];
}

class FavoriteStateLoaded extends FavoriteState {
  final Favorite favorite;

  FavoriteStateLoaded({required this.favorite});

  @override
  List<Object?> get props =>
      [favorite]; // Properly referring to the variable 'favorite'
}

class FavoriteStateSuccess extends FavoriteState {
  @override
  List<Object?> get props =>
      []; // Empty is fine since it's just success indication
}

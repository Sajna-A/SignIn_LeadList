part of 'leadlist_cubit.dart';

@immutable
sealed class LeadlistState {}

final class LeadlistInitial extends LeadlistState {}

class viewData extends LeadlistState {
  final Listmodelapi data;
  viewData({required this.data});
}

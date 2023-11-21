import 'package:equatable/equatable.dart';

class City extends Equatable {
  const City({required this.adminName, required this.name});

  final String name;
  final String adminName;

  factory City.fromJson(Map<String, dynamic> json) => City(
        adminName: json['admin_name'],
        name: json['city'],
      );

  @override
  List<Object?> get props => [name, adminName];
}

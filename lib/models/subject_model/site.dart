import 'dart:convert';

import 'package:equatable/equatable.dart';

class Site extends Equatable {
	final String? site;
	final String? id;
	final int? sort;

	const Site({this.site, this.id, this.sort});

	factory Site.fromMap(Map<String, dynamic> data) => Site(
				site: data['site'] as String?,
				id: data['id'] as String?,
				sort: data['sort'] as int?,
			);

	Map<String, dynamic> toMap() => {
				'site': site,
				'id': id,
				'sort': sort,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Site].
	factory Site.fromJson(String data) {
		return Site.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Site] to a JSON string.
	String toJson() => json.encode(toMap());

	Site copyWith({
		String? site,
		String? id,
		int? sort,
	}) {
		return Site(
			site: site ?? this.site,
			id: id ?? this.id,
			sort: sort ?? this.sort,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object?> get props => [site, id, sort];
}

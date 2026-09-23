import 'package:flutter_test/flutter_test.dart';
import 'package:kimiaxplore/app/modules/home/data/home_topics.dart';

void main() {
  test('HomeTopics items should contain foundation topics', () {
    expect(HomeTopics.items, isNotEmpty);
    expect(HomeTopics.items.any((t) => t.id == 'atomic_structure'), isTrue);
    expect(HomeTopics.items.any((t) => t.id == 'periodic_table'), isTrue);
    expect(HomeTopics.items.any((t) => t.id == 'chemical_bonding'), isTrue);
  });
}


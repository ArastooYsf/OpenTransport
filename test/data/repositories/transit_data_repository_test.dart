import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/data/repositories/transit_data_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('loadCity parses the bundled Tehran data into typed models', () async {
    const repository = TransitDataRepository();

    final city = await repository.loadCity(country: 'iran', city: 'tehran');

    expect(city.meta.country, 'IR');
    expect(city.meta.city, 'tehran');

    expect(city.lines, hasLength(1));
    final line = city.lines.single;
    expect(line.id, 'tehran-line-1');
    expect(line.color, '#ED1C24');
    expect(line.name['en'], 'Tehran Metro Line 1');

    expect(city.stations, hasLength(3));
    final tajrish = city.stations.firstWhere((s) => s.id == 'tehran-tajrish');
    expect(tajrish.name['fa'], 'تجریش');
    expect(tajrish.lineIds, contains('tehran-line-1'));
  });
}


import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:myapp/core/services/movie_service.dart';

@GenerateMocks([MovieService], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
])
void main() {}

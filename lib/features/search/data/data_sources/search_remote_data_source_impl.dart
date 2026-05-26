import 'package:dio/dio.dart';
import 'package:movies_app/core/constants/app_constants.dart';
import 'package:movies_app/features/search/data/models/search_movie_model.dart';
import '../../../../core/errors/app_exception.dart';
import '../models/search_movies_model.dart';
import 'search_remote_data_source.dart';

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final Dio _dio;

  SearchRemoteDataSourceImpl(this._dio);

  @override
  Future<List<SearchMovieModel>> getMovies(String query, int page) async {
    try {
      final response = await _dio.get(
        ApiConstants.listMovies,
        queryParameters: {'limit': 20, 'query_term': query, 'page': page},
      );

      if (response.statusCode == 200) {
        final moviesModel = SearchMoviesModel.fromJson(response.data);
        return moviesModel.data?.movies ?? [];
      } else {
        throw RemoteException('Failed to fetch search results');
      }
    } on DioException catch (e) {
      throw RemoteException(e.message ?? 'An error occurred');
    } catch (e) {
      throw RemoteException(e.toString());
    }
  }
}

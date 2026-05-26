import 'package:dio/dio.dart';
import 'package:movies_app/features/explore/data/models/explore_movies_model.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/app_exception.dart';
import '../models/explore_movie_model.dart';
import 'explore_remote_data_source.dart';

class ExploreRemoteDataSourceImpl implements ExploreRemoteDataSource {
  final Dio _dio;

  ExploreRemoteDataSourceImpl(this._dio);

  @override
  Future<List<ExploreMovieModel>> getMoviesByGenre(
    String genre,
    int page,
  ) async {
    try {
      final response = await _dio.get(
        ApiConstants.listMovies,
        queryParameters: {'genre': genre, 'page': page, 'limit': 20},
      );

      if (response.statusCode == 200) {
        final moviesModel = ExploreMoviesModel.fromJson(response.data);
        return moviesModel.data?.movies ?? [];
      } else {
        throw RemoteException('Failed to load category movies');
      }
    } on DioException catch (e) {
      throw RemoteException(e.message ?? 'An error occurred');
    } catch (e) {
      throw RemoteException(e.toString());
    }
  }
}

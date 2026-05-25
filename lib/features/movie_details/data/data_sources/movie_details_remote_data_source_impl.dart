import 'package:dio/dio.dart';
import 'package:movies_app/core/constants/app_constants.dart';
import 'package:movies_app/features/movie_details/data/models/movie_model.dart';
import 'package:movies_app/features/movie_details/data/models/similar_movies_model.dart';
import '../../../../core/errors/app_exception.dart';
import 'movie_details_remote_data_source.dart';

class MovieDetailsRemoteDataSourceImpl implements MovieDetailsRemoteDataSource {
  final Dio _dio;
  MovieDetailsRemoteDataSourceImpl(this._dio);

  @override
  Future<MovieModel> getMovieDetails(int movieId) async {
    try {
      final response = await _dio.get(
        ApiConstants.movieDetails,
        queryParameters: {
          'movie_id': movieId,
          'with_images': true,
          'with_cast': true,
        },
      );

      if (response.statusCode == 200) {
        return MovieModel.fromJson(response.data['data']['movie']);
      } else {
        throw RemoteException('Failed to load movie details');
      }
    } on DioException catch (e) {
      throw RemoteException(e.message ?? 'An error occurred');
    } catch (e) {
      throw RemoteException(e.toString());
    }
  }

  @override
  Future<List<MovieModel>> getSimilarMovies(int movieId) async {
    try {
      final response = await _dio.get(
        ApiConstants.movieSuggestions,
        queryParameters: {
          'movie_id': movieId,
        },
      );

      if (response.statusCode == 200) {
        final similarMoviesModel = SimilarMoviesModel.fromJson(response.data);
        return similarMoviesModel.data?.movies ?? [];
      } else {
        throw RemoteException('Failed to load similar movies');
      }
    } on DioException catch (e) {
      throw RemoteException(e.message ?? 'An error occurred');
    } catch (e) {
      throw RemoteException(e.toString());
    }
  }
}

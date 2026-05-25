import 'package:dio/dio.dart';
import 'package:movies_app/core/constants/app_constants.dart';
import 'package:movies_app/core/errors/app_exception.dart';
import 'package:movies_app/features/home/data/models/home_movies_model.dart';
import 'package:movies_app/features/home/data/models/home_movie_model.dart';
import 'home_remote_data_source.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio _dio;

  HomeRemoteDataSourceImpl(this._dio);

  @override
  Future<List<HomeMovieModel>> getAvailableNowMovies() async {
    try {
      final response = await _dio.get(
        ApiConstants.listMovies,
        queryParameters: {
          'date_added': 'date_added',
          'minimum_rating':5.5
        },
      );

      if (response.statusCode == 200) {
        final moviesModel = HomeMoviesModel.fromJson(response.data);
        return moviesModel.data?.movies ?? [];
      } else {
        throw RemoteException('Failed to load available now movies');
      }
    } on DioException catch (e) {
      throw RemoteException(e.message ?? 'An error occurred');
    } catch (e) {
      throw RemoteException(e.toString());
    }
  }

  @override
  Future<List<HomeMovieModel>> getCategoryMovies(String genre) async{
    try {
      final response = await _dio.get(
        ApiConstants.listMovies,
        queryParameters: {
          'genre': genre,
        },
      );

      if (response.statusCode == 200) {
        final moviesModel = HomeMoviesModel.fromJson(response.data);
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

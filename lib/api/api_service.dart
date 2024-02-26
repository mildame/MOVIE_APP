import 'dart:convert';
import 'package:get/get.dart';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/review.dart';
import 'package:movies_app/models/actor.dart';

class ApiService {
  static Future<List<Movie>?> getTopRatedMovies() async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}movie/top_rated?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].skip(6).take(5).forEach(
            (m) => movies.add(
              Movie.fromMap(m),
            ),
          );
      return movies;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Movie>?> getCustomMovies(String url) async {
    List<Movie> movies = [];
    try {
      http.Response response =
          await http.get(Uri.parse('${Api.baseUrl}movie/$url'));
      var res = jsonDecode(response.body);
      res['results'].take(6).forEach(
            (m) => movies.add(
              Movie.fromMap(m),
            ),
          );
      return movies;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Movie>?> getSearchedMovies(String query) async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/search/movie?api_key=${Api.apiKey}&language=en-US&query=$query&page=1&include_adult=false'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (m) => movies.add(
          Movie.fromMap(m),
        ),
      );
      return movies;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Review>?> getMovieReviews(int movieId) async {
    List<Review> reviews = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (r) {
          reviews.add(
            Review(
                author: r['author'],
                comment: r['content'],
                rating: r['author_details']['rating']),
          );
        },
      );
      return reviews;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Actor>?> getTopPerson() async {
    List<Actor> actors = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}/person/popular?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].skip(6).take(5).forEach(
            (m) => actors.add(
              Actor.fromMap(m),
            ),
          );
      actors = await getSearchedPersonList(actors) as List<Actor>;
      return actors;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Actor>?> getSearchedPersonList(
      List<Actor> actorList) async {
    //Can search full details of single actor or list of actors
    List<Actor> actors = [];
    try {
      for (int i = 0; i < actorList.length; i++) {
        String query = actorList[i].id.toString();

        http.Response response = await http.get(Uri.parse(
            '${Api.baseUrl}/person/$query?api_key=${Api.apiKey}&language=en-US&page=1&include_adult=false'));
        var res = jsonDecode(response.body);

        actors.add(Actor.fromMap(res));
      }
      return actors;
    } catch (e) {
      return null;
    }
  }

  static Future<Actor?> getSearchedPerson(String query) async {
    //Can search full details of single actor or list of actors
    Actor actor;
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}/person/$query?api_key=${Api.apiKey}&language=en-US&page=1&include_adult=false'));
      var res = jsonDecode(response.body);
      actor = res['response'];
      return actor;
    } catch (e) {
      return null;
    }
  }
}

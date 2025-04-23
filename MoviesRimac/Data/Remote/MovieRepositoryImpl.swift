//
//  MovieRepositoryImpl.swift
//  MoviesRimac
//
//  Created by Carlos on 23/04/25.
//

import Foundation

class MovieRepositoryImpl: MovieRepository {
    private let apiService: MovieAPIService

    init(apiService: MovieAPIService = .shared) {
        self.apiService = apiService
    }

    func fetchUpcomingMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        apiService.getListUpcoming(numPage: page) { result in
            switch result {
            case .success(let dataMovies):
                let movies: [Movie] = dataMovies.compactMap { data in
                    guard let id = data.id,
                          let title = data.title ?? data.original_title,
                          let overview = data.overview,
                          let releaseDate = data.release_date,
                          let posterPath = data.poster_path else {
                        return nil
                    }

                    return Movie(
                        id: id,
                        title: title,
                        overview: overview,
                        releaseDate: releaseDate,
                        posterPath: posterPath
                    )
                }
                completion(.success(movies))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

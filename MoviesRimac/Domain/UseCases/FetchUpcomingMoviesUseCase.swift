//
//  FetchUpcomingMoviesUseCase.swift
//  MoviesRimac
//
//  Created by Carlos on 23/04/25.
//
import Foundation
import Combine

class FetchUpcomingMoviesUseCase {
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func execute(page: Int) -> AnyPublisher<[Movie], Error> {
        Future { promise in
            self.repository.fetchUpcomingMovies(page: page) { result in
                promise(result)
            }
        }
        .eraseToAnyPublisher()
    }
    
}

//
//  MovieRepository.swift
//  MoviesRimac
//
//  Created by Carlos on 23/04/25.
//
import Foundation

protocol MovieRepository {
    func fetchUpcomingMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void)
}

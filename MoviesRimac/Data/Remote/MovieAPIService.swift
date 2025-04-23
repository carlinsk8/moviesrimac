//
//  MovieAPIService.swift
//  MoviesRimac
//
//  Created by Carlos on 22/04/25.
//

import UIKit

enum APError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
    case decodingError
}
    

class MovieAPIService: NSObject {
    static let shared = MovieAPIService()
    
    
    private func buildUpcomingURL(for page: Int) -> URL? {
        var components = URLComponents(string: "\(AppConfig.shared.apiBaseURL)/movie/upcoming")
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: "\(AppConfig.shared.apiKey)"),
            URLQueryItem(name: "language", value: "es-PE"),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        return components?.url
    }

    
    private let cache = NSCache<NSString, UIImage>()
    func getListUpcoming(numPage: Int,completed: @escaping (Result<[DataMovie], APError>) -> Void) {
        guard let url = buildUpcomingURL(for: numPage) else {
            completed(.failure(.invalidURL))
            return
        }

        print("🌐 Final URL: \(url.absoluteString)")
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
           if let _ = error {
               completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let movieData = try decoder.decode(MovieDataModel.self, from: data)
                completed(.success(movieData.results))
                
            } catch {
                completed(.failure(.decodingError))
                print("Error decoding JSON: \(error.localizedDescription)")
            }

        }
        task.resume()

    }
}

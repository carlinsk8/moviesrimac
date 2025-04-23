//
//  MoviesRimacApp.swift
//  MoviesRimac
//
//  Created by Carlos on 22/04/25.
//

import SwiftUI

@main
struct MoviesRimacApp: App {
    var body: some Scene {
        WindowGroup {
            MoviesView(
                viewModel: MoviesViewModel(
                    fetchUpcoming: FetchUpcomingMoviesUseCase(
                        repository: MovieRepositoryImpl()
                    )
                )
            )
        }
    }
}


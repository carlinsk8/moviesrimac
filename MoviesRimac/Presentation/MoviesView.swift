//
//  MoviesView.swift
//  MoviesRimac
//
//  Created by Carlos on 23/04/25.
//

import SwiftUI
import Kingfisher

struct MoviesView: View {
    @StateObject var viewModel: MoviesViewModel
    let gridItemLayout = [GridItem(.flexible())]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    header
                    upcomingMoviesSectionVertical
                }
            }
            .onAppear {
                viewModel.getListOfUpcomingMovies()
            }
        }
    }

    private var header: some View {
        Text("Upcoming Movies")
            .font(.title2)
            .foregroundColor(.accentColor)
    }

    private var upcomingMoviesSection: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: gridItemLayout, spacing: 20) {
                ForEach(viewModel.upcomingMovies, id: \.id) { movie in
                    KFImage(URL(string: "\(Constants.urlImages)\(movie.posterPath)"))
                        .resizable()
                        .placeholder { progress in
                            ProgressView()
                        }
                        .scaledToFit()
                    
                        .frame(width: 150, height: 210)
                        .cornerRadius(12)
                        .task {
                            if viewModel.hasReachedEnd(of: movie) && !viewModel.isFetching {
                                await viewModel.fetchNextSetOfMovies()
                            }
                        }

                }
            }
            .padding(.horizontal)
        }
    }
    
    private var upcomingMoviesSectionVertical: some View {
        LazyVStack(spacing: 16) {
            ForEach(viewModel.upcomingMovies, id: \.id) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    KFImage(URL(string: "\(Constants.urlImages)\(movie.posterPath)"))
                        .resizable()
                        .placeholder { _ in ProgressView() }
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(12)
                }
                .buttonStyle(PlainButtonStyle())
                .task {
                    if viewModel.hasReachedEnd(of: movie) && !viewModel.isFetching {
                        await viewModel.fetchNextSetOfMovies()
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }

}



#Preview {
    MoviesView(viewModel: MoviesViewModel(
        fetchUpcoming: FetchUpcomingMoviesUseCase(repository: MovieRepositoryImpl())
        
    ))
}

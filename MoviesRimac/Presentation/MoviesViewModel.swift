//
//  MoviesViewModel.swift
//  MoviesRimac
//
//  Created by Carlos on 23/04/25.
//
import Foundation
import Combine

class MoviesViewModel: ObservableObject {
    @Published var upcomingMovies: [Movie] = []
    @Published var nowPlayingMovies: [Movie] = []
    @Published var trendingMovies: [Movie] = []
    @Published private(set) var viewState: ViewState? = nil

    private let fetchUpcomingUseCase: FetchUpcomingMoviesUseCase

    private var cancellables = Set<AnyCancellable>()
    private var page = 1
    private var totalPages: Int?
    var isLoading: Bool {
        viewState == .loading
    }

    var isFetching: Bool {
        viewState == .fetching
    }

    init(fetchUpcoming: FetchUpcomingMoviesUseCase) {
        self.fetchUpcomingUseCase = fetchUpcoming
    }

    func getListOfUpcomingMovies() {
        viewState = .loading
        defer { viewState = .finished }

        fetchUpcomingUseCase.execute(page: page)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    print("Error fetching upcoming: \(error.localizedDescription)")
                }
                self?.viewState = .finished
            } receiveValue: { [weak self] movies in
                self?.upcomingMovies = movies
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func fetchNextSetOfMovies() async {
        guard viewState != .fetching else { return }
        guard page != totalPages else { return }

        viewState = .fetching

        fetchUpcomingUseCase.execute(page: page + 1)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    print("❌ Error fetching page \(self?.page ?? -1): \(error.localizedDescription)")
                }
                self?.viewState = .finished
            } receiveValue: { [weak self] movies in
                guard let self else { return }
                self.upcomingMovies.append(contentsOf: movies)
                self.page += 1
            }
            .store(in: &cancellables)
    }
        
    func hasReachedEnd(of movie: Movie) -> Bool {
        upcomingMovies.last?.id == movie.id
    }

    enum ViewState {
        case fetching
        case loading
        case finished
    }
}

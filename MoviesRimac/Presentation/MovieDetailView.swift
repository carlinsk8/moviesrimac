//
//  MovieDetailView.swift
//  MoviesRimac
//
//  Created by Carlos on 23/04/25.
//
import SwiftUI
import Kingfisher

struct MovieDetailView: View {
    let movie: Movie
    @State private var animate = false

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                KFImage(URL(string: "\(Constants.urlImages)\(movie.posterPath)"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 270)
                    .cornerRadius(12)
                    .shadow(radius: 8)
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.95)
                    .animation(.easeOut(duration: 0.4), value: animate)

                Text(movie.title)
                    .font(.title2.bold())
                    .opacity(animate ? 1 : 0)
                    .animation(.easeOut.delay(0.1), value: animate)

                Text("Lanzamiento: \(movie.releaseDate)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .opacity(animate ? 1 : 0)
                    .animation(.easeOut.delay(0.2), value: animate)
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", movie.voteAverage))
                        .font(.subheadline)
                        .bold()
                }
                Text(movie.overview)
                    .font(.body)
                    .padding()
                    .opacity(animate ? 1 : 0)
                    .animation(.easeOut.delay(0.3), value: animate)
            }
            .padding()
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            animate = true
        }
    }
}

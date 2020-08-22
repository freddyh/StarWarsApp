//
//  FilmDetailView.swift
//  Star Wars Peeps
//
//  Created by Freddy Hernandez Jr on 8/22/20.
//

import SwiftUI
import star_wars_api

struct FilmDetailView: View {
    let film: Film
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                Text("Episode \(film.episode_id)")
                Text(film.opening_crawl)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                Text("Director: \(film.director)\nProducer: \(film.producer)\nRelease Date: \(film.release_date)")
                List {
                    Section(header: Text("Species")) {
                        ForEach(film.species, id: \.self) { species in
                            Text(species)
                        }
                    }
                    
                    Section(header: Text("Starships")) {
                        ForEach(film.starships, id: \.self) { s in
                            Text(s)
                        }
                    }
                    
                    Section(header: Text("Vehicles")) {
                        ForEach(film.vehicles, id: \.self) { v in
                            Text(v)
                        }
                    }
                    
                    Section(header: Text("Characters")) {
                        ForEach(film.characters, id: \.self) { v in
                            Text(v)
                        }
                    }
                    
                    Section(header: Text("Planets")) {
                        ForEach(film.planets, id: \.self) { v in
                            Text(v)
                        }
                    }
                }
            }
            .padding(.vertical, 100)
        }
        .navigationTitle(film.title)
    }
}

//struct FilmDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilmDetailView()
//    }
//}

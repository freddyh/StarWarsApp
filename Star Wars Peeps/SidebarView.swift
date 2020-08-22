//
//  SidebarView.swift
//  Star Wars Peeps
//
//  Created by Freddy Hernandez Jr on 8/3/20.
//

import SwiftUI
import star_wars_api

enum ContentItem: Identifiable, Hashable {
    static func == (lhs: ContentItem, rhs: ContentItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: String {
        switch self {
        case .film(let film):
            return film.id
        case .people(let person):
            return person.id
        case .planet(let planet):
            return planet.id
        case .species(let species):
            return species.id
        case .starship(let starship):
            return starship.id
        case .vehicle(let vehicle):
            return vehicle.id
        }
    }
    
    case people(Person)
    case film(Film)
    case starship(Starship)
    case vehicle(Vehicle)
    case species(Species)
    case planet(Planet)
}

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

struct ContentItemDetailView: View {
    var item: ContentItem
    
    @ViewBuilder var body: some View {
        switch item {
        case .film(let film):
            FilmDetailView(film: film)
        case .people(let person):
            VStack {
                Text(person.id)
                Text(person.birth_year)
                Text(person.eye_color)
                Text(person.gender)
            }
        case .planet(let planet):
            Text(planet.id)
        case .species(let species):
            Text(species.id)
        case .starship(let starship):
            ScrollView(.vertical) {
                VStack {
                    Text("Model: \(starship.model)")
                    Text("Class: \(starship.starship_class)")
                    Text("Manufacturer: \(starship.manufacturer)")
                    Text("Cost: \(starship.cost_in_credits)")
                    Text("Length (meters): \(starship.length)")
                    Text("Crew Members Needed: \(starship.crew)")
                    Text("Passenger Capacity: \(starship.passengers)")
                    Text("Max Speed (atmospheric): \(starship.max_atmosphering_speed)\nHyperdrive Rating: \(starship.hyperdrive_rating)\n MPH(Megalights per Hour \(starship.MGLT)\nCargo Capacity: \(starship.cargo_capacity)\nConsumables ( maximum length of time that this starship can provide consumables for crew): \(starship.consumables)")
                    
                    ForEach(starship.films, id: \.self) { v in
                        Text("Film: \(v)")
                    }
                    
                    ForEach(starship.pilots, id: \.self) { v in
                        Text("Pilot: \(v)")
                    }
                }.navigationTitle(starship.name)
            }
        case .vehicle(let vehicle):
            Text(vehicle.id)
        }
    }
}

struct ContentItemView: View {
    var item: ContentItem
    
    @ViewBuilder var body: some View {
        switch item {
        case .film(let film):
            Text(film.id)
        case .people(let person):
            Text(person.id)
        case .planet(let planet):
            Text(planet.id)
        case .species(let species):
            Text(species.id)
        case .starship(let starship):
            Text(starship.id)
        case .vehicle(let vehicle):
            Text(vehicle.id)
        }
    }
}

struct ContentItemList: View {
    let title: String
    var items: [ContentItem]
    var isLoading: Bool
    @Binding var selectedContentItem: ContentItem?
    var body: some View {
        List(selection: $selectedContentItem) {
            ForEach(items) {
                item in
                NavigationLink(
                    destination: ContentItemDetailView(item: item),
                    tag: item,
                    selection: $selectedContentItem,
                    label: {
                        ContentItemView(item: item)
                    })
            }
        }
        .overlay(
            ProgressView().opacity(isLoading ? 1 : 0)
        )
        .navigationTitle(title)
    }
}

struct SidebarView: View {
    @ObservedObject var rootLoader: RootLoader
    @Binding var selectedRootItem: String?
    @Binding var selectedContentItem: ContentItem?
    
    var body: some View {
        List(selection: $selectedRootItem) {
            ForEach(Array(rootLoader.root.keys.sorted()), id: \.self) { index in
                NavigationLink(
                    destination:
                        ContentItemList(title: index,
                                        items: rootLoader.contentItems,
                                        isLoading: rootLoader.isLoadingContentItems,
                                        selectedContentItem: $selectedContentItem)
                        .onAppear {
                            rootLoader.loadContentItems(index)
                        },
                    label: {
                        Text(index).font(.headline)
                    })
            }
        }.listStyle(SidebarListStyle())
    }
}

let testLoader = RootLoader()
struct ContentView_Previews: PreviewProvider {
    @State static var rootItem: String?
    @State static var contentItem: ContentItem?
    static var previews: some View {
        SidebarView(rootLoader: testLoader,
                    selectedRootItem: $rootItem,
                    selectedContentItem: $contentItem)
            .onAppear {
                testLoader.start()
            }
    }
}

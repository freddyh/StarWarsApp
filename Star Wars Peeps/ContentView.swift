//
//  ContentView.swift
//  Star Wars Peeps
//
//  Created by Freddy Hernandez Jr on 8/3/20.
//

import SwiftUI
import star_wars_api

enum ContentItem: Identifiable {
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

struct ContentItemDetailView: View {
    var item: ContentItem
    
    @ViewBuilder var body: some View {
        switch item {
        case .film(let film):
            Text(film.id)
        case .people(let person):
            HStack {
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
            Text(starship.id)
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
    var items: [ContentItem]
    var body: some View {
        List {
            ForEach(items) {
                item in
                NavigationLink(
                    destination: ContentItemDetailView(item: item),
                    label: {
                        ContentItemView(item: item)
                    })
            }
        }.listStyle(SidebarListStyle())
    }
}

struct ContentView: View {
    @ObservedObject var rootLoader: RootLoader
    
    var body: some View {
        List {
            ForEach(Array(rootLoader.root.keys), id: \.self) { index in
                NavigationLink(
                    destination:
                        ContentItemList(items: rootLoader.people.map { ContentItem.people($0) }).onAppear {
                            rootLoader.loadPeople()
                        },
                    label: {
                        Text(rootLoader.root[index]!)
                    })
            }
        }.listStyle(SidebarListStyle())
    }
}

let testLoader = RootLoader()
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rootLoader: testLoader)
            .onAppear {
                testLoader.loadRoot()
            }
    }
}

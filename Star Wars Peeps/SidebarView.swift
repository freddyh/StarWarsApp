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
            StarshipDetailView(starship: starship)
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

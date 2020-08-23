//
//  RootLoader.swift
//  Star Wars Peeps
//
//  Created by Freddy Hernandez Jr on 8/23/20.
//

import Foundation
import Combine
import star_wars_api

class RootLoader: ObservableObject {
    @Published var root: [String: String] = [:]
    @Published var contentItems: [ContentItem] = []
    @Published var isLoadingContentItems: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    func start(contentItemsKey: String? = nil) {
        loadRoot()
        contentItemsKey.map { loadContentItems($0) }
    }
    
    func loadRoot() {
        StarWarsAPI.rootMapPublisher()
            .receive(on: DispatchQueue.main)
            .replaceError(with: [:])
            .assign(to: \.root, on: self)
            .store(in: &cancellables)
    }
    
    func loadContentItems(_ key: String) {
        isLoadingContentItems = true
        let publisher: AnyPublisher<[ContentItem], StarWarsAPI.APIError>
        if key.contains("people") {
            publisher = StarWarsAPI.peopleListPublisher()
                .map { $0.map { ContentItem.people($0) } }
                .eraseToAnyPublisher()
        }
        else if key.contains("film") {
            publisher = StarWarsAPI.filmListPublisher()
                .map { $0.map { ContentItem.film($0) } }
                .eraseToAnyPublisher()
        }
        else if key.contains("starship") {
            publisher = StarWarsAPI.starshipListPublisher()
                .map { $0.map { ContentItem.starship($0) } }
                .eraseToAnyPublisher()
        }
        else if key.contains("vehicle") {
            publisher = StarWarsAPI.vehicleListPublisher()
                .map { $0.map { ContentItem.vehicle($0) } }
                .eraseToAnyPublisher()
        }
        else if key.contains("species") {
            publisher = StarWarsAPI.speciesListPublisher()
                .map { $0.map { ContentItem.species($0) } }
                .eraseToAnyPublisher()
        }
        else if key.contains("planet") {
            publisher = StarWarsAPI.planetListPublisher()
                .map { $0.map { ContentItem.planet($0) } }
                .eraseToAnyPublisher()
        } else {
            publisher = PassthroughSubject<[ContentItem], StarWarsAPI.APIError>()
                .eraseToAnyPublisher()
        }
        
        publisher
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveCompletion: { _ in
                self.isLoadingContentItems = false
            })
            .replaceError(with: [])
            .assign(to: \.contentItems, on: self)
            .store(in: &cancellables)
    }
}

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

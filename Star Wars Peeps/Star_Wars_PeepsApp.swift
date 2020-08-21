//
//  Star_Wars_PeepsApp.swift
//  Star Wars Peeps
//
//  Created by Freddy Hernandez Jr on 8/3/20.
//

import SwiftUI
import star_wars_api
import Combine

@main
struct Star_Wars_PeepsApp: App {
    @StateObject var rootLoader = RootLoader()
    @State var selectedRootItem: String? = "people"
    @State var selectedContentItem: ContentItem?
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SidebarView(rootLoader: rootLoader,
                            selectedRootItem: $selectedRootItem,
                            selectedContentItem: $selectedContentItem)
                
                if let rootItem = self.selectedRootItem {
                    ContentItemList(title: rootItem,
                                    items: rootLoader.contentItems,
                                    isLoading: rootLoader.isLoadingContentItems,
                                    selectedContentItem: $selectedContentItem)
                } else {
                    Text("Select a Root Item")
                }
                
                if let selectedItem = self.selectedContentItem {
                    ContentItemDetailView(item: selectedItem)
                } else {
                    Text("Select an item")
                }
                
            }
            .onAppear(perform: {
                rootLoader.start(contentItemsKey: selectedRootItem)
            })
        }
    }
}

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

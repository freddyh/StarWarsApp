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
        if key.contains("people") {
            StarWarsAPI.peopleListPublisher()
                .map({ (results) -> [ContentItem] in
                    results.map { ContentItem.people($0) }
                })
                .receive(on: DispatchQueue.main)
                .handleEvents(receiveCompletion: { (_) in
                    self.isLoadingContentItems = false
                })
                .replaceError(with: [])
                .assign(to: \.contentItems, on: self)
                .store(in: &cancellables)
        }
        else if key.contains("film") {
            StarWarsAPI.filmListPublisher()
                .map({ (results) -> [ContentItem] in
                    results.map { ContentItem.film($0) }
                })
                .receive(on: DispatchQueue.main)
                .handleEvents(receiveCompletion: { (_) in
                    self.isLoadingContentItems = false
                })

                .replaceError(with: [])
                .assign(to: \.contentItems, on: self)
                .store(in: &cancellables)
        }
        else if key.contains("starship") {
            StarWarsAPI.starshipListPublisher()
                .map({ (results) -> [ContentItem] in
                    results.map { ContentItem.starship($0) }
                })
                .receive(on: DispatchQueue.main)
                .handleEvents(receiveCompletion: { (_) in
                    self.isLoadingContentItems = false
                })

                .replaceError(with: [])
                .assign(to: \.contentItems, on: self)
                .store(in: &cancellables)
        }
        else if key.contains("vehicle") {
            StarWarsAPI.vehicleListPublisher()
                .map({ (results) -> [ContentItem] in
                    results.map { ContentItem.vehicle($0) }
                })
                .receive(on: DispatchQueue.main)
                .handleEvents(receiveCompletion: { (_) in
                    self.isLoadingContentItems = false
                })
                .replaceError(with: [])
                .assign(to: \.contentItems, on: self)
                .store(in: &cancellables)
        }
        else if key.contains("species") {
            StarWarsAPI.speciesListPublisher()
                .map({ (results) -> [ContentItem] in
                    results.map { ContentItem.species($0) }
                })
                .receive(on: DispatchQueue.main)
                .handleEvents(receiveCompletion: { (_) in
                    self.isLoadingContentItems = false
                })

                .replaceError(with: [])
                .assign(to: \.contentItems, on: self)
                .store(in: &cancellables)
        }
        else if key.contains("planet") {
            StarWarsAPI.planetListPublisher()
                .map({ (results) -> [ContentItem] in
                    results.map { ContentItem.planet($0) }
                })
                .receive(on: DispatchQueue.main)
                .handleEvents(receiveCompletion: { (_) in
                    self.isLoadingContentItems = false
                })

                .replaceError(with: [])
                .assign(to: \.contentItems, on: self)
                .store(in: &cancellables)
        }
    }
}

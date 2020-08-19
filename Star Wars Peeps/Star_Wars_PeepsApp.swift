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
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(rootLoader: rootLoader)
            }.onAppear(perform: rootLoader.loadRoot)
        }
    }
}

class RootLoader: ObservableObject {    
    @Published var root: [String: String] = [:]
    @Published var people: [Person] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    func loadRoot() {        
        StarWarsAPI.rootMapPublisher()
            .receive(on: DispatchQueue.main)
            .replaceError(with: [:])
            .assign(to: \.root, on: self)
            .store(in: &cancellables)
    }
    
    func loadPeople() {
        StarWarsAPI.peopleListPublisher()
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .assign(to: \.people, on: self)
            .store(in: &cancellables)
    }
}

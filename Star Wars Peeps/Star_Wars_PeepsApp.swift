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
            ContentView(rootLoader: rootLoader)
                .onAppear(perform: rootLoader.loadRoot)
        }
    }
}

class RootLoader: ObservableObject {
    @Published var root: StarWarsAPI.Root? = nil
    @Published var people: [StarWarsAPI.Person] = []
    
    private var cancellables: Set<AnyCancellable> = []
        
    func loadRoot() {
        StarWarsAPI.rootPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { (root) in
                self.root = root
            }.store(in: &cancellables)

    }
    
    func loadPeople() {
        StarWarsAPI.peopleListPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { (people) in
                self.people = people
            }.store(in: &cancellables)
    }
}

extension StarWarsAPI.Root {
    var titles: [String] {
        self.collections.map {
            $0.components(separatedBy: "/").dropLast().last ?? ""
        }
    }
}

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
    @ObservedObject var loader: DataLoader = DataLoader()
    var body: some Scene {
        WindowGroup {
            ContentView(people: loader.people)
        }
    }
}

class DataLoader: ObservableObject {
    @Published var people: [StarWarsAPI.Person] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        StarWarsAPI.peoplePublisher().receive(on: DispatchQueue.main).sink(receiveCompletion: { _ in }) { (people) in
            self.people = people
        }.store(in: &cancellables)
    }
}

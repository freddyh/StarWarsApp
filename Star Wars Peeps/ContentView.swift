//
//  ContentView.swift
//  Star Wars Peeps
//
//  Created by Freddy Hernandez Jr on 8/3/20.
//

import SwiftUI
import star_wars_api

struct ContentView: View {
    var people: [StarWarsAPI.Person]
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(people) { p in
                Text("hi \(p.name)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(people: [])
    }
}

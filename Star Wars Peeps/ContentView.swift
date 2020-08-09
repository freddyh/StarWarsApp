//
//  ContentView.swift
//  Star Wars Peeps
//
//  Created by Freddy Hernandez Jr on 8/3/20.
//

import SwiftUI
import star_wars_api

struct ContentView: View {
    @ObservedObject var rootLoader: RootLoader
    
    var body: some View {
        if rootLoader.root != nil {
            List {
                ForEach(rootLoader.root!.titles.indices) { index in
                    NavigationLink(
                        destination: Text(rootLoader.root!.collections[index]),
                        label: {
                            Text(rootLoader.root!.titles[index])
                        })
                }
            }
        } else {
            Text("Loading...")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rootLoader: RootLoader.init())
    }
}

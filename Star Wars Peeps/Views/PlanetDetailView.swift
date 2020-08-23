//
//  PlanetDetailView.swift
//  Star Wars Peeps
//
//  Created by Freddy Hernandez Jr on 8/23/20.
//

import SwiftUI
import star_wars_api

struct PlanetDetailView: View {
    let planet: Planet
    var body: some View {
        Text(planet.id)
    }
}

//struct PlanetDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlanetDetailView()
//    }
//}

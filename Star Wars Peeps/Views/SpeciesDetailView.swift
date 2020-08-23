//
//  SpeciesDetailView.swift
//  Star Wars Peeps
//
//  Created by Freddy Hernandez Jr on 8/23/20.
//

import SwiftUI
import star_wars_api

struct SpeciesDetailView: View {
    let species: Species
    var body: some View {
        Text(species.id)
    }
}

//struct SpeciesDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        SpeciesDetailView()
//    }
//}

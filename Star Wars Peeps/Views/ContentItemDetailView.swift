//
//  ContentItemDetailView.swift
//  Star Wars Peeps
//
//  Created by Freddy Hernandez Jr on 8/23/20.
//

import SwiftUI

struct ContentItemDetailView: View {
    var item: ContentItem
    
    @ViewBuilder var body: some View {
        switch item {
        case .film(let film):
            FilmDetailView(film: film)
        case .people(let person):
            PersonDetailView(person: person)
        case .planet(let planet):
            PlanetDetailView(planet: planet)
        case .species(let species):
            SpeciesDetailView(species: species)
        case .starship(let starship):
            StarshipDetailView(starship: starship)
        case .vehicle(let vehicle):
            VehicleDetailView(vehicle: vehicle)
        }
    }
}

//struct ContentItemDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentItemDetailView()
//    }
//}

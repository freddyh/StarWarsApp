//
//  StarshipDetailView.swift
//  Star Wars Peeps
//
//  Created by Freddy Hernandez Jr on 8/22/20.
//

import SwiftUI
import star_wars_api

struct StarshipDetailView: View {
    let starship: Starship
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20) {
                Text("Model: \(starship.model)")
                Text("Class: \(starship.starship_class)")
                Text("Manufacturer: \(starship.manufacturer)")
                Text("Cost: \(starship.cost_in_credits)")
                Text("Length (meters): \(starship.length)")
                Text("Crew Members Needed: \(starship.crew)")
                Text("Passenger Capacity: \(starship.passengers)")
                Text("Max Speed (atmospheric): \(starship.max_atmosphering_speed)\nHyperdrive Rating: \(starship.hyperdrive_rating)\n MPH(Megalights per Hour) \(starship.MGLT)\nCargo Capacity: \(starship.cargo_capacity)\nConsumables ( maximum length of time that this starship can provide consumables for crew): \(starship.consumables)")
                List {
                    Section(header: Text("Films")) {
                        ForEach(starship.films, id: \.self) { v in
                            Text(v)
                        }
                    }
                    if starship.pilots.count > 0 {
                        Section(header: Text("Pilots")) {
                            ForEach(starship.pilots, id: \.self) { v in
                                Text(v)
                            }
                        }
                    }
                }.frame(height: 300)
            }
            .navigationTitle(starship.name)
        }
    }
}

//struct StarshipDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        StarshipDetailView()
//    }
//}

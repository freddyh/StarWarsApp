//
//  VehicleDetailView.swift
//  Star Wars Peeps
//
//  Created by Freddy Hernandez Jr on 8/23/20.
//

import SwiftUI
import star_wars_api

struct VehicleDetailView: View {
    let vehicle: Vehicle
    var body: some View {
        Text(vehicle.id)
    }
}

//struct VehicleDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        VehicleDetailView()
//    }
//}

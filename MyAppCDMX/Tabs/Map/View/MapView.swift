//
//  MapView.swift
//  MyAppCDMX
//
//  Created by Fernández González Rodrigo Arturo on 07/08/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject var manager = LocationManager()
    
    var body: some View {
        
        NavigationStack {
            
            Map(coordinateRegion: $manager.region,
                annotationItems: $manager.annotationItems) {
                item in MapMarker(coordinate: item.coordinate.wrappedValue)
                //con iOS 17 podríamos agregar nombre al marcador de la siguiente manera:
                //item in MapMarker(item.name.wrappedValue, coordinate: item.coordinate.wrappedValue)
            }
        }
        .navigationTitle("Ubicación")
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

//
//  LocationManager.swift
//  MyAppCDMX
//
//  Created by Fernández González Rodrigo Arturo on 08/08/24.
//
import MapKit
import CoreLocation

struct Pin: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

final class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    //Region por default, para este ejecicio puse las cordenadas de la colonía donde vivo.
    @Published var region = MKCoordinateRegion(
        center: .init(latitude: 19.468338, longitude: -99.060549),
        span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    //
    @Published var annotationItems = [Pin(name: "Estas aquí", coordinate: CLLocationCoordinate2D(latitude: 19.468338, longitude: -99.060549))]
    
    
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.setup()
    }
    
    func setup() {
        switch locationManager.authorizationStatus {
        //Se esta autorizado, entonces solicitamos la ubicación solo una vez, para centrar el mapa.
        case .authorizedWhenInUse:
            locationManager.requestLocation()
        //Si no, solicitamos autorización.
        case .notDetermined:
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    //Se llama cuando el usuario cambia la autorización. Si se acepta, solicitaremos la ubicación para actualizar el mapa.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard .authorizedWhenInUse == manager.authorizationStatus else { return }
        locationManager.requestLocation()
    }
    
    //El segundo método es sólo para evitar crasheos. Para este ejemplo lo dejaremos vacío, pero se puede implementar cualquier manejo de errores.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Algo salió mal: \(error)")
    }
    
    //Se llama cuando tenemos una actualización de ubicación y nos proporciona una matriz de CLLocation. Según la documentación oficial, la última ubicación de la matriz es la más reciente, por lo que la usaremos para centrar el mapa en la posición del usuario.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        locations.last.map {
            //print("Latitude: \($0.coordinate.latitude)")
            //print("Longitude: \($0.coordinate.longitude)")
            region = MKCoordinateRegion(
                center: $0.coordinate,
                span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
            
            annotationItems.append(Pin(name: "Estas aquí", coordinate: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)))
        }
    }
}

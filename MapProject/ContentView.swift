//
//  ContentView.swift
//  MapProject
//
//  Created by Consultant on 8/2/23.
//

//MapKit:- Gives ability to show or use map in the app
/*
 CoreLocation
 Coordinates:- Longitude/Latitude
 
 */


import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject var locationManaager = MyLocationManager()
    @StateObject var mapViewModel = MapViewModel(networkManager: NetworkManager())
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 33.7567516044869, longitude: -84.39230537113572), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
     var yourRegion: Binding<MKCoordinateRegion>?{
        guard let location = locationManaager.yourLocation else{
            return MKCoordinateRegion.someLocation().getBindingofSomeLocation()
        }
    
        let alreadyLocation = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
         
         return alreadyLocation.getBindingofSomeLocation()
    }
    
    
    
    var body: some View {
        NavigationStack{
            VStack {
                if let yourRegion = yourRegion{
                    Map(coordinateRegion: yourRegion, annotationItems: mapViewModel.mapModel) { mod in
                        
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(mod.address.geo.lat)!, longitude: Double(mod.address.geo.lng)!)) {
                            NavigationLink {
                                SecondScreen(mod: mod)
                            } label: {
                                PlaceMarker(title: mod.name)
                            }
                            
                            
                            
                        }
                    }
                }
                
                
                
            }.ignoresSafeArea()
//                .onAppear(){
//                    mapViewModel.getProductsFromAPI()
//                }
                .task(){
                    mapViewModel.getProductsFromAPI()
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

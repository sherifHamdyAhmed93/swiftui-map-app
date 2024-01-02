//
//  LocationsViewModel.swift
//  SwiftUIMap
//
//  Created by Sherif Hamdy on 30/12/2023.
//

import Foundation
import MapKit
import SwiftUI
class LocationsViewModel:ObservableObject{
    @Published var locations:[Location]
    
    // Set current location on map
    @Published var mapLocation:Location{
        didSet{
            self.updateRegion(location: mapLocation)
        }
    }

    @Published var region = MKCoordinateRegion()
    
    @Published var showLocationList : Bool = false

    @Published var locationDetailsItem : Location? = nil


    private let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

    
    init(){
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateRegion(location: locations.first!)
    }
    
    func updateRegion(location:Location){
        withAnimation(Animation.easeInOut) {
            self.region = MKCoordinateRegion(center: location.coordinates,
                                             span: span)
        }
    }
    
    func toggleList(){
        withAnimation(Animation.easeInOut) {
            self.showLocationList.toggle()
        }
    }
    
    func setMapLocation(location:Location){
        withAnimation(Animation.easeInOut) {
            self.mapLocation = location
            self.showLocationList = false
        }
    }
    
    func nextButtonPressed(){
        let locationIndex = locations.firstIndex {
            $0 == mapLocation
        }
        
        guard let locationIndex  = locationIndex else{
            return
        }
        
        let nextLocationIndex = locationIndex + 1
        
        guard locations.indices.contains(nextLocationIndex) else{
            let firstLocation = self.locations.first!
            self.setMapLocation(location: firstLocation)
            return
        }
        
        setMapLocation(location: locations[nextLocationIndex])
        
    }
    
}

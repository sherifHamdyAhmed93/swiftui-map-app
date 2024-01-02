//
//  LocationDetailsView.swift
//  SwiftUIMap
//
//  Created by Sherif Hamdy on 30/12/2023.
//

import SwiftUI
import MapKit
struct LocationDetailsView: View {
    @EnvironmentObject private var vm:LocationsViewModel

    let location:Location
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                imageCrasoulSection
                
                VStack(alignment: .leading, spacing: 15.0){
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                    
                }
                .padding()
            }
        }
        .ignoresSafeArea()
        .overlay(alignment: .topLeading) {
            Button {
                vm.locationDetailsItem = nil
            } label: {
                Image(systemName: "xmark")
                    .font(.headline)
                    .padding(16)
                    .foregroundColor(.primary)
                    .background(.thickMaterial)
                    .cornerRadius(10)
                    .padding()
            }

        }
    }
}

struct LocationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailsView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}

extension LocationDetailsView {
    var imageCrasoulSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .tabViewStyle(.page)
        .frame(height: 500)
        .shadow(color: .black.opacity(0.3), radius: 20)
    }
}


extension LocationDetailsView{
    var titleSection: some View{
        VStack(alignment: .leading){
            Text(location.name)
                .font(.title)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    var descriptionSection: some View{
        VStack(alignment: .leading){
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
    }
    
    var mapLayer:some View{
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: location.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))), annotationItems: [location]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
            }
        }
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fill)
        .cornerRadius(15)
    }
}

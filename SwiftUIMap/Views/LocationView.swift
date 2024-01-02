//
//  LocationView.swift
//  SwiftUIMap
//
//  Created by Sherif Hamdy on 30/12/2023.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    @EnvironmentObject private var vm:LocationsViewModel
    
    private let maxWidth:CGFloat = 700
    
    var body: some View {
        ZStack{
            
            MapLayer
            .ignoresSafeArea()
            
            VStack(spacing: 0.0){
                
                header
                    .padding()
                    .frame(maxWidth: maxWidth)

                Spacer()
                                
                locationPreviewStack
                
            }
        }
        .sheet(item: $vm.locationDetailsItem) { location in
            LocationDetailsView(location: location)
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationView{
    private var header:some View{
            VStack{
                Button {
                    vm.toggleList()
                } label: {
                    Text(vm.mapLocation.name + " " + vm.mapLocation.cityName)
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .animation(.none, value: vm.mapLocation)
                        .overlay(alignment: .leading) {
                            Image(systemName: "arrow.down")
                                .foregroundColor(.primary)
                                .font(.headline)
                                .padding()
                                .rotationEffect(Angle(degrees: vm.showLocationList ? 180 : 0))
                        }
                }

                
                if vm.showLocationList{
                    LocationListView()
                }
                
            }
            .background(.thickMaterial)
            .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
            
    }
}

extension LocationView {
    var locationPreviewStack: some View {
        ZStack{
            ForEach(vm.locations) { location in
                if location == vm.mapLocation{
                    LocationPreviewView(location: location)
                        .shadow(color: .black.opacity(0.5), radius: 10)
                        .frame(maxWidth: maxWidth)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
}


extension LocationView{
    var MapLayer: some View{
        Map(coordinateRegion: $vm.region, annotationItems: vm.locations, annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(location == vm.mapLocation ? 1.0 : 0.7)
                    .shadow(color: .black.opacity(0.3), radius: 10)
                    .onTapGesture {
                        vm.setMapLocation(location: location)
                    }
            }
        })
    }
}

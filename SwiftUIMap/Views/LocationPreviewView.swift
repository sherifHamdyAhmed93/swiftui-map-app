//
//  LocationPreviewView.swift
//  SwiftUIMap
//
//  Created by Sherif Hamdy on 30/12/2023.
//

import SwiftUI

struct LocationPreviewView: View {
    @EnvironmentObject private var vm:LocationsViewModel

    var location:Location
    var body: some View {
        HStack(alignment: .bottom){
            VStack(alignment: .leading, spacing: 10.0){
                imageSection
                titleSection
            }
            
            VStack{
                learnMoreButton
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y:65)
        )
        .cornerRadius(10)
        .padding()
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.blue.ignoresSafeArea()
            LocationPreviewView(location: LocationsDataService.locations.first!)
                .environmentObject(LocationsViewModel())
        }
    }
}

extension LocationPreviewView{
    private var imageSection:some View{
        ZStack{
            if let imageName = location.imageNames.first{
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100,height: 100)
                    .cornerRadius(10)
                    .padding(10)
                    .background(.white)
                    .cornerRadius(10)
            }
        }
    }
    
    private var titleSection:some View{
        VStack(alignment: .leading){
            Text(location.name)
                .font(.title2)
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var nextButton:some View{
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .frame(width: 125,height: 25)
        }
        .buttonStyle(.bordered)
    }
    
    private var learnMoreButton:some View{
        Button {
            vm.locationDetailsItem = location
        } label: {
            Text("Learn More")
                .frame(width: 125,height: 25)
        }
        .buttonStyle(.borderedProminent)
        
    }
}

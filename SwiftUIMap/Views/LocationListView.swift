//
//  LocationListView.swift
//  SwiftUIMap
//
//  Created by Sherif Hamdy on 30/12/2023.
//

import SwiftUI

struct LocationListView: View {
    @EnvironmentObject private var vm:LocationsViewModel

    var body: some View {
        List {
            ForEach(vm.locations) { location in
                Button {
                    vm.setMapLocation(location: location)
                } label: {
                    listRowView(location: location)

                }
                .listRowBackground(Color.clear)

            }
        }
        .listStyle(.plain)

    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationListView{
    func listRowView(location:Location) -> some View{
        HStack{
            if let imageName = location.imageNames.first{
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50,height: 50)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading){
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
        }
    }
}

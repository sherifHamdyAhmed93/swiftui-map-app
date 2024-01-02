//
//  SwiftUIMapApp.swift
//  SwiftUIMap
//
//  Created by Sherif Hamdy on 30/12/2023.
//

import SwiftUI

@main
struct SwiftUIMapApp: App {
    @StateObject var vm:LocationsViewModel = LocationsViewModel()

    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(vm)
        }
    }
}

//
//  ContentView.swift
//  LittleLemon
//
//  Created by Vladislav Zheleznyakov on 28.04.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var model = RestaurantsModel()
    @State var tab = 0
    
    var body: some View {
        TabView(selection: $model.tabSelectedIndex){
            LocationView()
                .tag(0)
                .tabItem {
                    if !model.displayReservationForm {
                        Label("Locations", systemImage: "fork.knife")
                    }
                }
            
            ReservationView()
                .tag(1)
                .tabItem {
                    if !model.displayReservationForm {
                        Label("Reservation", systemImage: "square.and.pencil")
                    }
                }
        }
        .environmentObject(model)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

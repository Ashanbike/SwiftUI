//
//  RestaurantsModel.swift
//  LittleLemon
//
//  Created by Vladislav Zheleznyakov on 28.04.2023.
//

import UIKit

class RestaurantsModel: ObservableObject {
    
    @Published var reservation = ReservationModel()
    @Published var displayReservationForm = false
    @Published var tempReservation = ReservationModel()
    @Published var followNavigationLink = false
    
    @Published var displayTabBar = true
    @Published var tabBarChanged = false
    @Published var tabSelectedIndex = Int.max {
        didSet {
            tabBarChanged = true
        }
    }
    
    let restaurants = [
        RestaurantLocationModel(city: "Las Vegas",
                           neighborhood: "Downtown",
                           phoneNumber: "(702) 555-9898"),
        RestaurantLocationModel(city: "Los Angeles",
                           neighborhood: "North Hollywood",
                           phoneNumber: "(213) 555-1453"),
        RestaurantLocationModel(city: "Los Angeles",
                           neighborhood: "Venice",
                           phoneNumber: "(310) 555-1222"),
        RestaurantLocationModel(city: "Nevada",
                           neighborhood: "Venice",
                           phoneNumber: "(725) 555-5454"),
        RestaurantLocationModel(city: "San Francisco",
                           neighborhood: "North Beach",
                           phoneNumber: "(415) 555-1345"),
        RestaurantLocationModel(city: "San Francisco",
                           neighborhood: "Union Square",
                           phoneNumber: "(415) 555-9813")
    ]
}

//
//  ReservationModel.swift
//  LittleLemon
//
//  Created by Vladislav Zheleznyakov on 28.04.2023.
//

import UIKit

struct ReservationModel {
    var id = UUID()
    var restaurant: RestaurantLocationModel
    var customerName: String
    var customerEmail: String
    var customerPhoneNumber: String
    var reservationDate: Date
    var party: Int
    var specialRequests: String
    
    init(restaurant: RestaurantLocationModel = RestaurantLocationModel(city: "Los Angeles",
                                                                       neighborhood: "North Hollywood",
                                                                       phoneNumber: "(213) 555-1453"),
         customerName: String = "",
         customerEmail: String = "",
         customerPhoneNumber: String = "",
         reservationDate: Date = Date(),
         party: Int = 1,
         specialRequests: String = "") {
        self.restaurant = restaurant
        self.customerName = customerName
        self.customerEmail = customerEmail
        self.customerPhoneNumber = customerPhoneNumber
        self.reservationDate = reservationDate
        self.party = party
        self.specialRequests = specialRequests
    }
}

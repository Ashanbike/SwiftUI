//
//  RestaurantView.swift
//  LittleLemon
//
//  Created by Vladislav Zheleznyakov on 28.04.2023.
//

import SwiftUI

struct RestaurantView: View {
    
    var restaurantModel: RestaurantLocationModel
    
    var body: some View {
        VStack (alignment: .leading, spacing: 3){
            Text(restaurantModel.city)
                .font(.title2)
            
            HStack {
                Text(restaurantModel.neighborhood)
                Text("–")
                Text(restaurantModel.phoneNumber)
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
    }
}

struct RestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantView(restaurantModel: RestaurantLocationModel(city: "Los Angeles",
                                                                neighborhood: "North Hollywood",
                                                                phoneNumber: "(213) 555-1453"))
    }
}

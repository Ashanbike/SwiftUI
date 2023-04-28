//
//  LocationView.swift
//  LittleLemon
//
//  Created by Vladislav Zheleznyakov on 28.04.2023.
//

import SwiftUI

struct LocationView: View {
    
    @EnvironmentObject var model: RestaurantsModel
    
    var body: some View {
        VStack {
            Image("little-lemon-logo")
                .padding(.top, 50)
            
            Text(model.displayReservationForm ? "Reservation Details" : "Select a location")
                .padding([.leading, .trailing], 40)
                .padding([.top, .bottom], 8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
            
            NavigationView {
                List{
                    ForEach (model.restaurants, id: \.self) { item in
                        NavigationLink(destination: ReservationFormView(restaurant: item)) {
                            RestaurantView(restaurantModel: item)
                        }
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
        }
        .padding(.top, -10)
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}

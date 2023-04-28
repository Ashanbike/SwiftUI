//
//  ReservationFormView.swift
//  LittleLemon
//
//  Created by Vladislav Zheleznyakov on 28.04.2023.
//

import SwiftUI

struct ReservationFormView: View {
    
    var restaurant: RestaurantLocationModel
    @EnvironmentObject var model: RestaurantsModel
    
    @State var showAlert = false
    @State var errorMessage = ""
    @State var reservationDate = Date()
    @State var party: Int = 1
    @State var specialRequests: String = ""
    @State var customerName = ""
    @State var customerPhoneNumber = ""
    @State var customerEmail = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var tempReservation = ReservationModel()
    @State var changeReservation = false
    
    var body: some View {
        VStack {
            Form {
                RestaurantView(restaurantModel: restaurant)
                HStack {
                    VStack (alignment: .leading) {
                        Text("PARTY")
                            .font(.subheadline)
                        
                        TextField("",
                                  value: $party,
                                  formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .onChange(of: party) { value in
                            if value == 0 { party = 1}
                        }
                    }
                    
                    VStack {
                        DatePicker(selection: $reservationDate, in: Date()...,
                                   displayedComponents: [.date, .hourAndMinute]) {
                        }
                    }
                }
                .padding([.top, .bottom], 20)
                
                Group {
                    Group {
                        HStack {
                            Text("NAME: ")
                                .font(.subheadline)
                            TextField("Your name",
                                      text: $customerName)
                            
                        }
                        
                        HStack{
                            Text("PHONE: ")
                                .font(.subheadline)
                            
                            TextField("Your phone number",
                                      text: $customerPhoneNumber)
                            .textContentType(.telephoneNumber)
                            .keyboardType(.phonePad)
                        }
                        
                        HStack{
                            Text("E-MAIL: ")
                                .font(.subheadline)
                            TextField("Your e-mail",
                                      text: $customerEmail)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        }
                        
                        TextField("add any special request (optional)",
                                  text: $specialRequests,
                                  axis: .vertical)
                        .padding()
                        .overlay( RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.2)) )
                        .lineLimit(6)
                        .padding([.top, .bottom], 20)
                    }
                    
                    Button(action: {
                        validateForm()
                    }, label: {
                        Text("CONFIRM RESERVATION")
                    })
                    .padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding(.top, 10)
                }
            }
            .padding(.top, -40)
            .scrollContentBackground(.hidden)
            
            .onChange(of: changeReservation) { _ in
                model.reservation = tempReservation
            }
            .alert("Error", isPresented: $showAlert, actions: {
                Button("Ok", role: .cancel) { }
            }, message: {
                Text(self.errorMessage)
            })
            
        }
        .onAppear {
            model.displayReservationForm = true
        }
        .onDisappear {
            model.displayReservationForm = false
        }
    }
    
    private func validateForm() {
        let isNameValid = isNameValid(customerName)
        let isEmailValid = isEmailValid(customerEmail)
        
        guard isNameValid && isEmailValid
        else {
            var invalidNameMessage = ""
            if customerName.isEmpty || !isNameValid {
                invalidNameMessage = "Name can only contain letters and must have at least 3 characters\n\n"
            }
            
            var invalidPhoneMessage = ""
            if customerEmail.isEmpty {
                invalidPhoneMessage = "The phone number is invalid\n\n"
            }
            
            var invalidEmailMessage = ""
            if !customerEmail.isEmpty || !isEmailValid {
                invalidEmailMessage = "This e-mail is invalid"
            }
            
            self.errorMessage = "There are errors in the form:\n\n \(invalidNameMessage)\(invalidPhoneMessage)\(invalidEmailMessage)"
            
            showAlert.toggle()
            return
        }
        
        let reservation = ReservationModel(restaurant: restaurant,
                                               customerName: customerName,
                                               customerEmail: customerEmail,
                                               customerPhoneNumber: customerPhoneNumber,
                                               reservationDate: reservationDate,
                                               party: party,
                                               specialRequests: specialRequests)
        
        self.tempReservation = reservation
        self.changeReservation.toggle()
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func isNameValid(_ name: String) -> Bool {
        guard !name.isEmpty, name.count > 2 else { return false }
        
        for char in name {
            if (!(char >= "a" && char <= "z") && !(char >= "A" && char <= "Z") && !(char == " ") ) {
                return false
            }
        }
        return true
    }
    
    func isEmailValid(_ email: String) -> Bool {
        guard !email.isEmpty else { return false }
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: email)
    }
    
    
}

struct ReservationFormView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationFormView(restaurant: RestaurantLocationModel(city: "Los Angeles",
                                                                neighborhood: "North Hollywood",
                                                                phoneNumber: "(213) 555-1453"))
    }
}

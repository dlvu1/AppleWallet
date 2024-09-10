//
//  ContentView.swift
//  Wallet
//
//  Created by Duyen Vu on 02/06/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var cardDetails = CardDetails()
    @State private var rawNumber: String = ""
    @State private var isPickerPresented = false
    @State private var isColorPickerPresented = false
    @State private var isCardInfoPresented = false
    @State private var formatCardNumber: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Card Information")) {
                    TextField("Card Holder Name", text: $cardDetails.holderName)
                    TextField("Bank", text: $cardDetails.bank)
                    Picker("Card Type", selection: $cardDetails.type) {
                        ForEach(CardType.allCases, id: \.self) { cardType in
                            Text(cardType.rawValue)
                        }
                    }
                }
                Section(header: Text ("Details")) {
                    TextField("Card Number", text: $cardDetails.number)
                        .keyboardType(.numberPad)
                        .onChange(of: cardDetails.number) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            rawNumber = filtered
                            
                            if filtered.count > 16 {
                                rawNumber = String(filtered.prefix(16))
                            }
                            
                            cardDetails.number = CardDetails.formatCardNumber(rawNumber)
                        }
                    
                    TextField("Secure Code", text: $cardDetails.secureCode)
                        .keyboardType(.numberPad)
                        .onChange(of: cardDetails.secureCode) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                            cardDetails.secureCode = String(filtered.prefix(3))
                                }
                    
                    HStack {
                        Text("Expiration Date:")
                        Spacer()
                        Button(action: {
                            isPickerPresented.toggle()
                        }) {
                            Text(cardDetails.formattedValidity)
                        }
                        .sheet(isPresented: $isPickerPresented) {
                            VStack {
                                DatePicker("", selection: $cardDetails.validity, displayedComponents: [.date])
                                    .datePickerStyle(GraphicalDatePickerStyle())
                                    .labelsHidden()
                                
                                Button("Done") {
                                    isPickerPresented.toggle()
                                }
                                .padding()
                                .foregroundColor(.blue)
                            }
                        }
                    }
                }
                Section(header: Text("Card Color")) {
                    HStack(spacing: 30) {
                        ForEach(Colors.all, id: \.self) { color in
                            Circle()
                                .fill(color)
                                .frame(width: cardDetails.color == color ? 40 : 30, height: cardDetails.color == color ? 40 : 30)
                                .overlay(
                                    Circle()
                                        .stroke(cardDetails.color == color ? Color.gray : Color.clear, lineWidth: 4)
                                )
                                .onTapGesture {
                                    cardDetails.color = color
                                }
                        }
                    }
                }
                Section {
                    Button(action: {
                        isCardInfoPresented.toggle()
                    }) {
                        Text("Show Card Information")
                    }
                    .sheet(isPresented: $isCardInfoPresented) {
                        VStack {
                            CardView(cardDetails: cardDetails)
                            
                            Spacer()
                            
                            Button("Close") {
                                isCardInfoPresented.toggle()
                            }
                            .padding()
                            .foregroundColor(.blue)

                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Add Card")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

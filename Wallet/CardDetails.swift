//
//  CardDetails.swift
//  Wallet
//
//  Created by Duyen Vu on 02/06/2024.
//

import SwiftUI

struct Colors {
    static let black = Color(red: 38 / 255, green: 40 / 255, blue: 41 / 255)
    static let blue = Color(red: 44 / 255, green: 116 / 255, blue: 179 / 255)
    static let red = Color(red: 240 / 255, green: 84 / 255, blue: 84 / 255)
    static let green = Color(red: 47 / 255, green: 93 / 255, blue: 98 / 255)
    
    static var all: [Color] {
        [Self.blue, Self.red, Self.green, Self.black]
    }
}

enum CardType: String, CaseIterable {
    case visa = "VISA"
    case mastercard = "Mastercard"
    case amex = "Amex"
    case discover = "Discover"
}

struct CardDetails {
    static private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yy"
        return formatter
    }()

    var holderName: String = ""
    var bank: String = ""
    var type: CardType = .visa
    var number: String = ""
    var validity: Date = .now
    var secureCode: String = ""
    var color: Color = Colors.blue
    
    var formattedValidity: String {
        Self.dateFormatter.string(from: validity)
    }
    
    static func formatCardNumber(_ string: String) -> String {
            var formatted = string
            if string.count > 4 {
                formatted.insert(" ", at: formatted.index(formatted.startIndex, offsetBy: 4))
            }
            if string.count > 9 {
                formatted.insert(" ", at: formatted.index(formatted.startIndex, offsetBy: 9))
            }
            if string.count > 14 {
                formatted.insert(" ", at: formatted.index(formatted.startIndex, offsetBy: 14))
            }
            return formatted
    }
}

struct CardView: View {
    var cardDetails: CardDetails
    
    var body: some View {
        ZStack {
            // Content
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(cardDetails.bank)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                            .padding(.leading, 10)
                    }
                    
                    Spacer()
                    
                    Text(cardDetails.type.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.trailing, 10)
                        .padding(.top, 10)
                }
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(cardDetails.holderName)")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                            .padding(.bottom, 10)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Spacer()
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Valid Thru: \(cardDetails.formattedValidity)")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                            .padding(.bottom, 10)
                    }
                    VStack(alignment: .leading) {
                        Text("Secure Code: \(cardDetails.secureCode)")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                            .padding(.bottom, 10)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(cardDetails.number)")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                            .padding(.bottom, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            
            // Background
            .background(
                LinearGradient(gradient: Gradient(colors: [cardDetails.color.opacity(3), .black]), startPoint: .leading, endPoint: .trailing)
            )
            .shadow(radius: 30)
            .cornerRadius(15)
            .frame(width: 300, height: 180)
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 1)
            )
            .padding()
        }
    }
}
                 

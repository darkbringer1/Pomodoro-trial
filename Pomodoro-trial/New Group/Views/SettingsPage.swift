//
//  SettingsPage.swift
//  Pomodoro-trial
//
//  Created by DarkBringer on 6.07.2021.
//

import SwiftUI

struct SettingsPage: View {
    
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isExpanded: Bool = false
        
    @Binding var selectedPickerFlow: Int
    
    @State public var selectedPickerBreak = 4

    
    let availableMinutes = Array(1 ... 59)
    
    var body: some View {
        NavigationView {
            List {
                Text("Sessions")
                    .font(.title2)
                    .bold()
                    .padding(.top, 15)
                Section {
//                    ButtonSettingsCell(title: "Flow Duration", color: colorScheme == .dark ? .white : .black, hasIcon: true, selectedTimeInMinutesAndSeconds: "25:00")
//
//                    ButtonSettingsCell(title: "Break Duration", color: colorScheme == .dark ? .white : .black, hasIcon: true, selectedTimeInMinutesAndSeconds: "5:00")
                    DisclosureGroup(
                        content: {
                            VStack {
                                Picker(selection: $selectedPickerFlow, label: Text("")) {
                                ForEach(0 ..< availableMinutes.count) {
                                    Text("\(availableMinutes[$0]) min")
                                }
                            }
                            }
                        },
                        label: {
                            HStack {
                                Text("Flow Duration")
                                Spacer()
                                Capsule()
                                    .overlay(
                                        Text("\(String(format: "%02d", (selectedPickerFlow + 1))):00" )
                                            .foregroundColor(.white)
                                    )
                                    .frame(maxWidth: 75)
                                
                            }
                        }
                    )
                    DisclosureGroup(
                        content: {
                            VStack {
                                Picker(selection: $selectedPickerBreak, label: Text("")) {
                                    ForEach(0 ..< availableMinutes.count) {
                                        Text("\(availableMinutes[$0]) min")
                                    }
                                }
                            }
                        },
                        label: {
                            HStack {
                                Text("Break Duration")
                                Spacer()
                                Capsule()
                                    .overlay(
                                        Text("\(String(format: "%02d", (selectedPickerBreak + 1))):00" )
                                            .foregroundColor(.white)
                                    )
                                    .frame(maxWidth: 75)
                                
                            }
                        }
                    )
                        
                        
                    
                } //: SessionsSection
            }
        }
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage(selectedPickerFlow: .constant(0))
    }
}


//MARK: - Duration Buttons

struct ButtonSettingsCell: View {

    var title: String
    var color: Color
    var hasImage: Bool?
    var imageName: String?
    var hasIcon: Bool?
    var selectedTimeInMinutesAndSeconds: String 
    
    var body: some View {
        HStack {
            hasImage.map {_ in
                Image(systemName: imageName!)
                    .font(.custom("icon", size: 23))
            }
            
            Text(title)
                .font(.custom("title", size: 16))
                .padding(.leading, 10)
            
            Spacer()
            Capsule()
                .overlay(Text(selectedTimeInMinutesAndSeconds)
                            .font(.subheadline)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                )
                .frame(maxWidth: 75)
                .foregroundColor(.gray)
            
            hasIcon.map {_ in
                Image(systemName: "chevron.right")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
        } //: HStack
    }
}


//struct TimePicker: View {
//
//
//    @State public var selectedPickerIndex = 0
//
//    let availableMinutes = Array(1 ... 59)
//
//    var body: some View {
//        Picker(selection: $selectedPickerIndex, label: Text("")) {
//            ForEach(0 ..< availableMinutes.count) {
//                Text("\(availableMinutes[$0]) min")
//            }
//        }
//    }
//}


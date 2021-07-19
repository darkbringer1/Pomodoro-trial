//
//  Home.swift
//  Pomodoro-trial
//
//  Created by DarkBringer on 18.06.2021.
//

import SwiftUI

struct Home: View {

    @State private var selection = 0
    @Binding var selectedTime: Int
    let house = Image(systemName: "house")
    let houseFill = Image(systemName: "house.fill")
    let gears = Image(systemName: "gearshape")
    let gearsFill = Image(systemName: "gearshape.fill")

    var body: some View {
        TabView(selection: $selection) {
            MainPage()
                .tabItem {
                    Image(systemName: selection == 0 ? "house.fill" : "house")
                }
                .tag(0)
            SettingsPage()
                .tabItem {
                    Image(systemName: selection == 1 ? "gearshape.2.fill" : "gearshape.2")
                        .accentColor(Color.black)
                }
                .tag(1)
        }
        .accentColor(.black)
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        Home(selectedTime: .constant(0))
    }
}

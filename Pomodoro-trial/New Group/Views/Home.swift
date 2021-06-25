//
//  Home.swift
//  Pomodoro-trial
//
//  Created by DarkBringer on 18.06.2021.
//

import SwiftUI

struct Home: View {

    @ObservedObject var timerManager = TimerManager()

    @State var selectedPickerIndex = 0

    let availableMinutes = Array(1...59)
    
    var body: some View {
        NavigationView {
            VStack {
                Text(secondsToMinutesAndSeconds(seconds: timerManager.secondsLeft))
                    .font(.system(size: 80))
                    .padding(.top, 80)
                Image(systemName: timerManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180, alignment: .center)
                    .foregroundColor(.red)
                    .onTapGesture {
                        if self.timerManager.timerMode == .initial {
                            timerManager.setTimerLength(minutes: self.availableMinutes[selectedPickerIndex] * 60)
                        }
                        self.timerManager.timerMode == .running ? self.timerManager.pause() : self.timerManager.start()
                        
                    }
                if timerManager.timerMode == .paused {
                    Image(systemName: "gobackward")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50, alignment: .center)
                        .padding(.top, 40)
                        .onTapGesture {
                            self.timerManager.reset()
                        }
                }
                if timerManager.timerMode == .initial {
                    Picker(selection: $selectedPickerIndex, label: Text("")) {
                        ForEach(0..<availableMinutes.count) {
                            Text("\(availableMinutes[$0]) min")
                        }
                        
                    }
                    .labelsHidden()
                }
                Spacer()
            }
            .navigationTitle("Pomodoro")
        }
//        .environment(\.colorScheme, .dark)
    }
}
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


//
//  MainPage.swift
//  Pomodoro-trial
//
//  Created by DarkBringer on 18.06.2021.
//


import SwiftUI

struct MainPage: View {
    
    @ObservedObject var timerManager = TimerManager()
    
    @State var selectedPickerIndex = 0
    
    @State var selectedDuration = 0
    
    let availableMinutes = Array(1 ... 59)
    
    var body: some View {
        NavigationView {
            VStack {
                Text(secondsToMinutesAndSeconds(seconds: timerManager.secondsLeft))
                    .font(.system(size: 60))
                    .padding(.top, 100)
                Image(systemName: timerManager.timerMode == .running ? "pause" : "play")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(.black)
                    .onTapGesture {
                        if self.timerManager.timerMode == .initial {
                            timerManager.setTimerLength(minutes: self.availableMinutes[selectedPickerIndex] * 60)
                        }
                        self.timerManager.timerMode == .running ? self.timerManager.pause() : self.timerManager.start()
                    }
                if timerManager.timerMode == .paused {
                    Image(systemName: "chevron.backward.2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20, alignment: .center)
                        .foregroundColor(.black)
                        .padding(.top, 40)
                        .onTapGesture {
                            self.timerManager.reset()
                        }
                }
                if timerManager.timerMode == .initial {
                    Picker(selection: $selectedPickerIndex, label: Text("")) {
                        ForEach(0 ..< availableMinutes.count) {
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
        MainPage()
    }
}

struct TimerView {
    @State var timerManager = TimerManager()
    @State var pickerIndex = 0
    let availableMinutes = Array(1 ... 59)
    
    var body: some View {
        VStack {
            Text(secondsToMinutesAndSeconds(seconds: timerManager.secondsLeft))
                .font(.system(size: 80))
                .padding(.top, 80)
            Image(systemName: timerManager.timerMode == .running ? "pause" : "play")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(.black)
                .onTapGesture {
                    if self.timerManager.timerMode == .initial {
                        timerManager.setTimerLength(minutes: self.availableMinutes[pickerIndex] * 60)
                    }
                    self.timerManager.timerMode == .running ? self.timerManager.pause() : self.timerManager.start()
                }
        }
    }
}

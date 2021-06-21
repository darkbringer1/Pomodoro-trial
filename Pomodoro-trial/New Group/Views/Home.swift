//
//  Home.swift
//  Pomodoro-trial
//
//  Created by DarkBringer on 18.06.2021.
//

import SwiftUI
import UserNotifications
import UIKit

struct Home: View {
    
    
    
    @State var start = false
    @State var to: CGFloat = 0
    @State var count = 0
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var duration: Time = Time(hour: 0, minute: 40, second: 0)
    @State public var showingSheet = false
    
    var body: some View {
        
        
        ZStack {
            
            Color.black.opacity(0.06).edgesIgnoringSafeArea(.all)
            
            VStack {
                
                //MARK: - TIMER CIRCLES

                TimerCircles(to: $to, count: $count)
                
                VStack{
                    if duration.hour != 0 {
                        Text("\(duration.hour) Hours and \(duration.minute) minutes")
                            
                            .font(.title)
                            .padding(.top)
                    } else if duration.minute != 0 {
                        if duration.minute == 1 {
                            Text("\(duration.minute) minute")
                                .font(.title)
                                .padding(.top)
                        } else {
                            Text("\(duration.minute) minutes")
                                .font(.title)
                                .padding(.top)}
                    } else {
                        Text("Of \(duration.second) seconds")
                            
                            .font(.title)
                            .padding(.top)
                    }
                    
                }
                .padding(.top)
                
                //MARK: - BUTTONS HSTACK

                HStack(spacing: 20) {
                    
                    Button(action: {
                        if self.count == 15 {
                            self.count = 0
                            withAnimation(.default) {
                                self.to = 0
                            }
                        }
                        self.start.toggle()
                    }) {
                        HStack(spacing: 15) {
                            Image(systemName: self.start ? "pause.fill" : "play.fill")
                                .foregroundColor(.white)
                            Text(self.start ? "Pause" : "Play")
                                .foregroundColor(.white)
                        }
                        .padding(.vertical)
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40)
                        .background(Color.red)
                        .clipShape(Capsule())
                        .shadow(radius: 6)
                    }
                    
                    Button(action: {
                        self.start = false
                        self.count = 0
                        withAnimation(.default) {
                            self.to = 0
                        }
                    }) {
                        HStack(spacing: 15) {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.red)
                            Text("Restart")
                                .foregroundColor(.red)
                        }
                        .padding(.vertical)
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40)
                        .background(
                            Capsule().stroke(Color.red, lineWidth: 2))
                        .shadow(radius: 6)
                    }
                }
                .padding(.top, 55)
                
                Button(action: {
                    showingSheet.toggle()
                }) {
                    HStack(spacing: 15) {
                        Image(systemName: "timeline.selection")
                            .foregroundColor(.red)
                        Text("Select the timer")
                            .foregroundColor(.red)
                    }
                    .padding(.vertical)
                    .frame(width: (UIScreen.main.bounds.width) - 55)
                    .background(
                        Capsule().stroke(Color.red, lineWidth: 2))
                    .shadow(radius: 6)
                }
                
                
//                DurationPickerView(time: $duration)
                
            }
        }
        .onAppear(perform: {
            
            //MARK: - Notification Permissions

            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { _, _ in
            }
        })
        .onReceive(self.time, perform: { _ in
            let durationInSeconds = (duration.hour * 60 * 60) + (duration.minute * 60) + (duration.second)
            if self.start{
                if self.count != durationInSeconds {
                self.count += 1
                    print("hello")
                    withAnimation(.default) {
                        
                        self.to = CGFloat(self.count) / CGFloat(durationInSeconds)
                    }
                } else {
                    self.notify()
                    self.start.toggle()
                }
            }
        })
        .sheet(isPresented: $showingSheet, content: {
            VStack {
                Divider()
                Spacer()
//                Text("Please select how long you will work/study")
                
                
                DurationPickerView(time: $duration)
//                DurationPickerStyleView()
                
            }
                
        })
        
    }
    
    //MARK: - Notification Content

    func notify() {
        let content = UNMutableNotificationContent()
        content.title = "Message"
        content.body = "Timer is completed successfully in background!"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let req = UNNotificationRequest(identifier: "MSG", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//MARK: - Timer Circles Struct

struct TimerCircles: View {
    
    @Binding var to: CGFloat
    @Binding var count: Int
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 35, lineCap: .round))
                .frame(width: 280, height: 280)
            Circle()
                .trim(from: 0, to: to)
                .stroke(Color.red, style: StrokeStyle(lineWidth: 35, lineCap: .round))
                .frame(width: 280, height: 280)
                .rotationEffect(.init(degrees: -90))
            VStack{
                Text("\(count)")
                    .font(.system(size: 65))
                    .fontWeight(.bold)
            }
        }
    }
}

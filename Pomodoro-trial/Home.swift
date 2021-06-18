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
    @State var duration: Time = Time(hour: 1, minute: 0, second: 0)
    
    var body: some View {
        
        
        ZStack {
            
            Color.black.opacity(0.06).edgesIgnoringSafeArea(.all)
            
            VStack {
                
                //MARK: - TIMER CIRCLES

                ZStack {
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                    Circle()
                        .trim(from: 0, to: self.to)
                        .stroke(Color.red, style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                        .rotationEffect(.init(degrees: -90))
                    VStack{
                        Text("\(self.count)")
                            .font(.system(size: 65))
                            .fontWeight(.bold)
                        Text("Of 15")
                            .font(.title)
                            .padding(.top)
                    }
                }
                
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
                        .frame(width: (UIScreen.main.bounds.width / 2) - 55)
                        .background(Color.red)
                        .clipShape(Capsule())
                        .shadow(radius: 6)
                    }
                    
                    Button(action: {
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
                        .frame(width: (UIScreen.main.bounds.width / 2) - 55)
                        .background(
                            Capsule().stroke(Color.red, lineWidth: 2))
                        .shadow(radius: 6)
                    }
                }
                .padding(.top, 55)
                
                
                DurationPickerView(time: $duration)
                
            }
        }
        .onAppear(perform: {
            
            //MARK: - Notification Permissions

            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { _, _ in
            }
        })
        .onReceive(self.time, perform: { _ in
            if self.start{
                if self.count != 15 {
                self.count += 1
                    print("hello")
                    withAnimation(.default) {
                        
                        self.to = CGFloat(self.count) / 15
                    }
                } else {
                    self.notify()
                    self.start.toggle()
                }
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

struct DurationPickerView: UIViewRepresentable {
    @Binding var time: Time
    
    func makeCoordinator() -> DurationPickerView.Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
        datePicker.addTarget(context.coordinator, action: #selector(Coordinator.onDateChanged), for: .valueChanged)
        return datePicker
    }
    
    func updateUIView(_ datePicker: UIDatePicker, context: Context) {
        let date = Calendar.current.date(bySettingHour: time.hour, minute: time.minute, second: time.second, of: datePicker.date)!
        datePicker.setDate(date, animated: true)
    }
    
    class Coordinator: NSObject {
        var durationPicker: DurationPickerView
        
        init(_ durationPicker: DurationPickerView) {
            self.durationPicker = durationPicker
        }
        
        @objc func onDateChanged(sender: UIDatePicker) {
            print(sender.date)
            let calendar = Calendar.current
            let date = sender.date
            durationPicker.time = Time(hour: calendar.component(.hour, from: date), minute: calendar.component(.minute, from: date), second: calendar.component(.second, from: date))
        }
    }
}

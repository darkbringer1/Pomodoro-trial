//
//  DurationPickerView.swift
//  Pomodoro-trial
//
//  Created by DarkBringer on 19.06.2021.
//

import SwiftUI

struct DurationPickerView: UIViewRepresentable{
    @Binding var time: Time
    @State var duration: Time = Time(hour: 1, minute: 0, second: 0)
    
    func makeCoordinator() -> DurationPickerView.Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
        datePicker.addTarget(context.coordinator, action: #selector(Coordinator.onDateChanged), for: .valueChanged)
        datePicker.datePickerMode = .countDownTimer
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


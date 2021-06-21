//
//  DurationPickerStyleView.swift
//  Pomodoro-trial
//
//  Created by DarkBringer on 21.06.2021.
//

import SwiftUI

struct DurationPickerStyleView: View {
//    @Binding var studyMinutes: Int
//    @Binding var breakMinutes: Int
    @State var studyDuration: [String] = ["25", "30", "50"]
    @State var breakDuration: [String] = ["5", "10", "15"]
    
    var body: some View {
        VStack {
            
            Section(header: Text("Select the duration of your study:").font(.footnote)) {
                Picker("Select the duration of your study:", selection: $studyDuration,
                       content: {
                        ForEach(0..<studyDuration.count) {
                            Text("\(self.studyDuration[$0]) minutes")
                            
                        }
                       })
                    .pickerStyle(SegmentedPickerStyle())
                    
                    .padding()
            }
            
            Section(header: Text("Select the duration of your break:").font(.footnote)) {
                Picker("Select the duration of your break:", selection: $breakDuration,
                       content: {
                        ForEach(0..<breakDuration.count) {
                            Text("\(self.breakDuration[$0]) minutes")
                        }
                       })
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
            }
        }
        
    }
    
}

struct DurationPickerStyleView_Previews: PreviewProvider {
    static var previews: some View {
        DurationPickerStyleView()
    }
}

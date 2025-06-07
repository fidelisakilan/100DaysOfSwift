//
//  ContentView.swift
//  BetterRest
//
//  Created by Fidelis Akilan on 6/6/25.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeUp
    @State private var sleepAmount = 8.0
    @State private var coffeeAmt = 1
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    private static var defaultWakeUp: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    var idealSleepTime: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmt))
            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime.formatted(date:.omitted,time: .shortened)
        } catch {
        }
        let defaultSleepTime = ContentView.defaultWakeUp - (sleepAmount * 60 * 60)
        return defaultSleepTime.formatted(date:.omitted,time: .shortened)
    }
    var body: some View {
        NavigationStack{
            Form {
                Section("When do you want to wake up") {
                    DatePicker("Pick a time to sleep",selection: $wakeUp,displayedComponents: .hourAndMinute)
                }
                Section("Desired amound of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours",value: $sleepAmount,in: 4...12,step: 0.25)
                }
                Picker("Daily coffee intake",selection: $coffeeAmt) {
                    ForEach(1..<21) { num in
                        Text(num.formatted())
                    }
                }
                Section {
                    Text("Ideal bedtime is: \(idealSleepTime)").font(.callout)
                }
            }
            .navigationTitle("BetterRest")
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
}

#Preview {
    ContentView()
}

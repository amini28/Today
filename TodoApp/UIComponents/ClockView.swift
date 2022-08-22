//
//  ClockView.swift
//  TodoApp
//
//  Created by Amini on 18/08/22.
//

import SwiftUI

struct ClockView: View {
    
    @State var angle: Double = 0
    
    @State var selectedDate = Date()
    @State var showPicker = false
    
    @State var isHourChange = true
    
    @State var hour: Int = 12
    @State var minutes: Int = 0

    // angle
    @State var hourAngle: Double = 0
    @State var minutesAngle: Double = 0
    
    func onChanged(value: DragGesture.Value) {
        
        // getting angle...
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
        // circle or know size is 40
        // so radius = 20
        let radians = atan2(vector.dy - 20, vector.dx - 20)
        
        var angle = radians * 180 / .pi
        
        if angle < 0 {
            angle = 360 + angle
        }
        
        print(angle)
        
        angle = Double(angle)

        // for hours
        if isHourChange {
            let roundValue = 30 * Int(round(angle / 30))
            hourAngle = Double(roundValue)
            print(hourAngle)
        } else {
            // for minutes
            let progress = minutesAngle / 360
            minutes = Int(progress * 60)
            print(minutes)
        }
        
    }
    
    func onEnd(value: DragGesture.Value) {
        
        if isHourChange {
            // updating Hour value...
            hour = Int(angle / 30)
            print(hour)
        } else {
            withAnimation {
                
                // setting to minute value..
                minutesAngle = Double(minutes * 6)
                print(minutesAngle)
            }
        }
    }
    
    var body: some View {
        HStack (spacing : 20) {
            ZStack {
                Circle()
                    .fill(.gray.opacity(0.1))
                    .gesture(DragGesture()
                        .onChanged(onChanged(value:))
                        .onEnded(onEnd(value:)))
                
                // Seconds and Min Dots...
                
                ForEach(0..<60, id: \.self){ i in
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 2, height: (i % 5) == 0 ? 15 : 5)
                        .offset(y: 180 / 2)
                        .rotationEffect(.init(degrees: Double(i) * 6))
                }
                                                
                // Min...
                
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 4, height: 120 / 2)
                    .offset(y: 120 / 4)
//                                        .rotationEffect(.init(radians: Double(selectedTime.min) * 6))
                    .rotationEffect(.init(degrees: minutesAngle))
                    .onTapGesture {
                        isHourChange.toggle()
                    }
                            
                
                // Hour...
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 2, height: 100 / 2)
                    .offset(y: 100 / 4)
//                                        .rotationEffect(.init(radians: Double(selectedTime.min) * 30))
                    .rotationEffect(.init(degrees: hourAngle))
                    .onTapGesture {
                        isHourChange.toggle()
                    }
                
                // Center Cricle...
                Circle()
                    .fill(Color.primary)
                    .frame(width: 15, height: 15)
            }
            .frame(width: UIScreen.main.bounds.width/2,
                   height: UIScreen.main.bounds.width/2)
            
            HStack {
                Text("10")
                    .font(.callout)
                    .fontWeight(.bold)
                Text(":")
                    .font(.callout)
                    .fontWeight(.bold)
                Text("35")
                    .font(.callout)
                    .fontWeight(.bold)
                Text("AM")
                    .font(.callout)
                    .fontWeight(.bold)
            }
        }

    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}

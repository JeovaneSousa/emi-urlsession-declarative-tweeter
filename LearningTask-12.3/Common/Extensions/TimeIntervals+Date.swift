//
//  TimeIntervals+Date.swift
//  LearningTask-12.3
//
//  Created by rafael.rollo on 12/12/2022.
//

import Foundation

extension Date {
    
    typealias ComponentElement = (component: Calendar.Component, suffix: String)
    
    func getFormattedTimeInterval(since pasteDate: Date,
                                  using calendarComponents: [ComponentElement]? = nil) -> String {
        var currentComponents: [ComponentElement] = calendarComponents ?? [
            (.year, "yr"), (.month, "mo"), (.day, "d"), (.hour, "h"), (.minute, "m"), (.second, "s")
        ]
        
        if currentComponents.isEmpty {
            return "just now"
        }
    
        let componentElement = currentComponents.removeFirst()
        let value = getValue(for: componentElement.component, of: pasteDate)
    
        guard value > 0 else {
            return getFormattedTimeInterval(since: pasteDate, using: currentComponents)
        }
        
        return String(format: "%d%@", value, componentElement.suffix)
    }
    
    private func getValue(for component: Calendar.Component, of pasteDate: Date) -> Int {
        let dateComponent = Calendar.current.dateComponents([component], from: pasteDate, to: self)
        return dateComponent.value(for: component)!
    }
    
}

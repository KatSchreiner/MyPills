//
//  Date+Extension.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 15.02.2025.
//

import UIKit

extension Date {
    static func datesForWeekContaining(_ date: Date) -> [Date] {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
        return (0..<7).map { calendar.date(byAdding: .day, value: $0, to: startOfWeek)! }
    }
}

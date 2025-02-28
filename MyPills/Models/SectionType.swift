//
//  SectionType.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 21.02.2025.
//

import UIKit

enum SectionType: Int, CaseIterable {
    case title = 0
    case intakeTime
    case repeatDays
    
    var title: String {
        switch self {
        case .title: return "Добавить лекарство"
        case .intakeTime: return "Как принимать"
        case .repeatDays: return "Повторить"
        }
    }
}

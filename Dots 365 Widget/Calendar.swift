//
//  Calendar.swift
//  Dots 365
//
//  Created by Ray on 1/20/24.
//

import Foundation

func daysInMonths() -> [Int] {
    let calendar = Calendar.current
    let currentYear = calendar.component(.year, from: Date())
    var daysInMonths = [Int]()

    for month in 1...12 {
        let dateComponents = DateComponents(year: currentYear, month: month)
        let range = calendar.range(of: .day, in: .month, for: calendar.date(from: dateComponents)!)
        daysInMonths.append(range?.count ?? 0)
    }

    return daysInMonths
}

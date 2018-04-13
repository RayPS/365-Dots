//
//  Dots.swift
//  365 Dots Extension
//
//  Created by Ray on 2018/4/14.
//  Copyright © 2018 Ray. All rights reserved.
//

import UIKit

func createDotsView() -> UIStackView {

    var monthViews: [UIStackView] = []

    let monthDays = [31, isLeapYear() ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    for (indexOfMonth, numberOfDays) in monthDays.enumerated() {
        var dayViews: [UIView] = []
        for indexOfDay in 0...numberOfDays {
            let dayView = UIView()
            dayView.heightAnchor.constraint(equalToConstant: 4).isActive = true
            dayView.widthAnchor.constraint(equalToConstant: 4).isActive = true
            let alpha: CGFloat = (indexOfMonth + 1 < dateComponents(.month) || (indexOfMonth + 1 == dateComponents(.month) && indexOfDay + 1 <= dateComponents(.day))) ? 1.0 : 0.2
            dayView.backgroundColor = #colorLiteral(red: 0, green: 0.9647058824, blue: 0.9176470588, alpha: 1).withAlphaComponent(alpha)
            dayView.layer.cornerRadius = 2
            dayView.clipsToBounds = true
            dayViews.append(dayView)
        }

        let monthStackView = UIStackView(arrangedSubviews: dayViews)
        monthStackView.axis = .horizontal
        monthStackView.spacing = 4
        monthStackView.alignment = .center
        monthStackView.translatesAutoresizingMaskIntoConstraints = false

        monthViews.append(monthStackView)
    }

    let yearStackView = UIStackView(arrangedSubviews: monthViews)
    yearStackView.axis = .vertical
    yearStackView.spacing = 4
    yearStackView.alignment = .center
    yearStackView.distribution = .equalCentering
    yearStackView.translatesAutoresizingMaskIntoConstraints = false

    return yearStackView
}


func dateComponents(_ component: Calendar.Component) -> Int {
    let calendar = Calendar.current
    return calendar.component(component, from: Date())
}

func isLeapYear() -> Bool {
    let year = dateComponents(.year)
    return ((year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0))
}

func numberOfDaysInThisYear() -> Int {
    return isLeapYear() ? 366 : 365
}

func nthOfDayInThisYear() -> Int {
    let date = Date()
    let calendar = Calendar.current
    let day = calendar.ordinality(of: .day, in: .year, for: date)
    return day!
}

func percentageOfThisYear() -> String {
    let calculation = Float(nthOfDayInThisYear()) / Float(numberOfDaysInThisYear())
    let result = String(calculation * 100.0).split(separator: ".").first!
    return "\(result)%"
}

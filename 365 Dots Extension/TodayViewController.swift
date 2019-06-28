//
//  TodayViewController.swift
//  365 Dots Extension
//
//  Created by Ray on 11/04/2018.
//  Copyright © 2018 Ray. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {

    @IBOutlet weak var labelContainer: UIView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!

    var dotsView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        yearLabel.text = String(dateComponents(.year))
        yearLabel.textColor = .white
        percentageLabel.text = percentageOfThisYear()
        percentageLabel.textColor = UIColor(named: "Red")
        dayLabel.text = "\(nthOfDayInThisYear())/\(numberOfDaysInThisYear())"
        dayLabel.textColor = UIColor(named: "Green")

        dotsView = createDotsView()

        view.addSubview(dotsView)
        dotsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 9).isActive = true
        dotsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
    }

    override func viewDidLayoutSubviews() {
        labelContainer.leadingAnchor.constraint(equalTo: dotsView.trailingAnchor, constant: 8).isActive = true
    }
}






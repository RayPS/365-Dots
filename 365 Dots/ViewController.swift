//
//  ViewController.swift
//  365 Dots
//
//  Created by Ray on 11/04/2018.
//  Copyright © 2018 Ray. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dotsViewContainer: UIView!

    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tipButton: UIButton!

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        yearLabel.text = String(dateComponents(.year))
        percentageLabel.text = percentageOfThisYear()
        dayLabel.text = "\(nthOfDayInThisYear())/\(numberOfDaysInThisYear())"

        tipButton.layer.cornerRadius = 16
        tipButton.clipsToBounds = true


        let dotsView = createDotsView(withSize: 6)
        dotsViewContainer.addSubview(dotsView)

        dotsView.topAnchor.constraint(equalTo: dotsViewContainer.topAnchor).isActive = true
        dotsView.leadingAnchor.constraint(equalTo: dotsViewContainer.leadingAnchor).isActive = true
        dotsView.trailingAnchor.constraint(equalTo: dotsViewContainer.trailingAnchor).isActive = true
        dotsView.bottomAnchor.constraint(equalTo: dotsViewContainer.bottomAnchor).isActive = true
    }

    @IBAction func tipButtonTapped(_ sender: Any) {
        tipButton.isHidden = true
    }

    override func viewDidLayoutSubviews() {
        dotsViewContainer.backgroundColor = .clear
    }
}



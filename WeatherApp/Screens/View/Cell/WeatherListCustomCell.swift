//
//  WeatherListCustomCell.swift
//  WeatherApp
//

import UIKit

class WeatherListCustomCell: UITableViewCell {

    var cellViewModel: WeatherCellViewModel? {
        didSet {
            self.textLabel?.text = cellViewModel?.weather
            self.detailTextLabel?.text = "Temp: " + (cellViewModel?.temperature)!
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    func setUpView() {
        // Cell view customization
        backgroundColor = .clear

        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

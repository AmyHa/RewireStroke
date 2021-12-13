//
//  WorkoutTableViewCell.swift
//  RewireStroke
//
//  Created by Amy Ha on 07/04/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {
    @IBOutlet weak var exerciseTitleLabel: UILabel!
    
    @IBOutlet weak var exerciseImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyStyle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func applyStyle() {
        exerciseImageView.layer.cornerRadius = 5
        exerciseTitleLabel.layer.cornerRadius = 5
        exerciseTitleLabel.layer.masksToBounds = true
        exerciseTitleLabel.textColor = Colours.primaryDark
    }
}

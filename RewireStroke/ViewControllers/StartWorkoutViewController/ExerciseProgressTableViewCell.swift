//
//  ExerciseProgressTableViewCell.swift
//  RewireStroke
//
//  Created by Amy Ha on 23/04/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import UIKit

class ExerciseProgressTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var exerciseTitleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var playImage: UIImageView!
    
    var runCount = 0 {
        didSet{
            print("runcount changed")
            self.progressBar.setProgress(Float(self.runCount/5), animated: false)

        }
    }
    
    var timer: Timer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        progressBar.isHidden = false
        progressBar.progress = 0.0
        progressBar.progressTintColor = Colours.logoPink
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func startProgressBar() {
        print("START PROGRESS BAR")
        
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    
    @objc func runTimedCode() {
        runCount = 0
        self.runCount += 1

        if self.runCount == 5 {
            timer.invalidate()
        }
    }
}

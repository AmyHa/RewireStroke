//
//  ExerciseViewController.swift
//  RewireStroke
//
//  Created by Amy Ha on 28/03/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import HCVimeoVideoExtractor

class WorkoutViewController: UIViewController {

    private var workout: Workout
    
    @IBOutlet weak var workoutTableView: UITableView!
    var dataSource: WorkoutDataSource
    
    let playerViewController = AVPlayerViewController()
    
    init(workout: Workout) {
        self.workout = workout
        dataSource = WorkoutDataSource(self.workout)
        super.init(nibName: Constants.View.workoutViewController, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var equipmentLabel: UILabel!
    @IBOutlet weak var equipmentTypeLabel: UILabel!
    @IBOutlet weak var preliminaryTextLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var videoContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
//        playEmbedInVideo()
        playerViewController.entersFullScreenWhenPlaybackBegins = true
        
        workoutTableView.delegate = dataSource
        workoutTableView.dataSource = dataSource
        workoutTableView.register(UINib(nibName: "WorkoutTableViewCell", bundle: nil), forCellReuseIdentifier: "WorkoutTableViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
    }

    private func setupUI() {

        startButton.backgroundColor = Colours.primaryBlue
        startButton.titleLabel?.font = UIFont.outfitBold(size: 17)
        startButton.setTitleColor(UIColor.white, for: .normal)

        equipmentTypeLabel.font = UIFont.outfitRegular(size: 17)
        equipmentLabel.font = UIFont.outfitBold(size: 17)
        preliminaryTextLabel.font = UIFont.outfitBold(size: 17)
        
        equipmentTypeLabel.textColor = Colours.primaryDark
        equipmentLabel.textColor = Colours.primaryDark
        preliminaryTextLabel.textColor = Colours.primaryDark
    }
    
    // MARK:- Actions
    
    @IBAction func startButtonPressed(_ sender: Any) {
        // Hacky, ofc change this!
        if workout.exercises.count > 0 {
            let mainView = StartWorkoutViewController.init(workout: workout)
            mainView.modalPresentationStyle = .fullScreen
            present(mainView, animated: false)
        }
    }
}


class WorkoutDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    var data: [Exercise]

    init(_ workout: Workout) {
        self.data = workout.exercises
        super.init()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exercise = data[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutTableViewCell", for: indexPath) as! WorkoutTableViewCell
    
        cell.exerciseTitleLabel.text = exercise.name
        
        if let image = UIImage(named: exercise.image) {
            cell.exerciseImageView.image = image
            cell.exerciseImageView.backgroundColor = Colours.secondaryLight
        }
        
        return cell
    }
    
}

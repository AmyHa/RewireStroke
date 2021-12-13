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


    private func setupUI() {

        startButton.backgroundColor = Colours.secondaryLight
        startButton.titleLabel?.font = UIFont.robotoBold(size: 17)
        startButton.setTitleColor(Colours.primaryDark, for: .normal)

        equipmentTypeLabel.font = UIFont.robotoRegular(size: 17)
        equipmentLabel.font = UIFont.robotoBold(size: 17)
        preliminaryTextLabel.font = UIFont.robotoBold(size: 17)
        
        equipmentTypeLabel.textColor = Colours.primaryDark
        equipmentLabel.textColor = Colours.primaryDark
        preliminaryTextLabel.textColor = Colours.primaryDark
    }
    
    private func playEmbedInVideo() {
        
        self.addChild(playerViewController)
        videoContainerView.addSubview(playerViewController.view)
        playerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerViewController.view.centerXAnchor.constraint(equalTo: videoContainerView.centerXAnchor),
            playerViewController.view.centerYAnchor.constraint(equalTo: videoContainerView.centerYAnchor),
            playerViewController.view.widthAnchor.constraint(equalTo: videoContainerView.widthAnchor),
            playerViewController.view.heightAnchor.constraint(equalTo: videoContainerView.heightAnchor)
        ])
        playerViewController.didMove(toParent: self)

        let documentsDirectory = CacheManager.getDocumentsDirectory()
        let currentVideoPath = workout.exercises[0].videoPath
        let destinationURL = documentsDirectory.appendingPathComponent(currentVideoPath)

        // Check if it exissts before downloading
        if FileManager.default.fileExists(atPath: destinationURL.path) {
            let playerItem = AVPlayerItem(url: destinationURL)
            playerViewController.player = AVPlayer(playerItem: playerItem)
        } else {
            print("it doesn't exist!")
        }
    }
    
    // MARK:- Actions
    
    @IBAction func startButtonPressed(_ sender: Any) {
        let mainView = StartWorkoutViewController.init(workout: workout)
        mainView.modalPresentationStyle = .fullScreen
        present(mainView, animated: false)
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

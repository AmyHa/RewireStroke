//
//  WorkoutViewController.swift
//  RewireStroke
//
//  Created by Amy Ha on 07/04/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import UIKit
import Combine
import AVKit
import AVFoundation
import HCVimeoVideoExtractor

class StartWorkoutViewController: UIViewController, ExerciseSelectionDelegate {
    
    @IBAction func closeWorkoutButtonTapped(_ sender: Any) {
        subscription?.cancel()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var closeWorkoutButton: DefaultButton!
    
    private let startWorkoutViewModel = StartWorkoutViewModel()
    var progress: Float
    
    func didTapExercise(videoIndex: Int) {
        playEmbedInVideo(video: videoIndex)
    }
    
    func reloadProgress(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)

        let cell = tableView.cellForRow(at: indexPath) as! ExerciseProgressTableViewCell
        print("Start timer")
        subscription = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .scan(60, { (count, _) in
                return count - 1
            })
            .sink(receiveCompletion: { (_) in
                print("Finished")
            }, receiveValue: { (count) in
                print("Updating the label to the current value \(count)")
                cell.timeLabel.text = count.timeFormat
                print(1-(0.016*Float(count)))
                cell.progressBar.progress = 1-(0.016*Float(count))
            })
    }


    private var workout: Workout
    private var subscription: AnyCancellable?
    @IBOutlet weak var videoContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: StartWorkoutDataSource
    var progressTimer: Timer
    
    let playerViewController = AVPlayerViewController()

    
    init(workout: Workout) {
        self.workout = workout
        dataSource = StartWorkoutDataSource(self.workout)
        self.progress = 0.0
        self.progressTimer = Timer()
        super.init(nibName: Constants.View.startWorkoutViewController, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource.exerciseSelectionDelegate = self
        
        setupUI()
        playEmbedInVideo(video: 0)
//        playerViewController.entersFullScreenWhenPlaybackBegins = true
        
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.register(UINib(nibName: "ExerciseProgressTableViewCell", bundle: nil), forCellReuseIdentifier: "ExerciseProgressTableViewCell")
    }

    private func setupUI() {
        closeWorkoutButton.backgroundColor = Colours.primaryBlue
        closeWorkoutButton.titleLabel?.font = UIFont.outfitBold()
        closeWorkoutButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    func playEmbedInVideo(video: Int) {
        
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

//        let documentsDirectory = CacheManager.getDocumentsDirectory()
        let currentVideoPath = workout.exercises[video].videoPath
//        let destinationURL = documentsDirectory.appendingPathComponent(currentVideoPath)
//
//        // Check if it exissts before downloading
//        if FileManager.default.fileExists(atPath: destinationURL.path) {
//            let playerItem = AVPlayerItem(url: destinationURL)
//            playerViewController.player = AVPlayer(playerItem: playerItem)
//        } else {
//            print("it doesn't exist!")
//        }
        
        
        HCVimeoVideoExtractor.fetchVideoURLFrom(url: URL(string: currentVideoPath)!, completion: { ( video:HCVimeoVideo?, error:Error?) -> Void in
            if let err = error {
                print("Error = \(err.localizedDescription)")
                return
            }
            
            guard let vid = video else {
                print("Invalid video object")
                return
            }
            
            DispatchQueue.main.async {
                self.playerViewController.player = AVPlayer(url: vid.videoURL[.Quality720p]!)
            }
            
        })
        
    }
}


class StartWorkoutDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    var data: [Exercise]
    var exerciseSelectionDelegate: ExerciseSelectionDelegate!
    var cell: ExerciseProgressTableViewCell!
    var progress: Float
    
    init(_ workout: Workout) {
        self.data = workout.exercises
        self.progress = 0.0
        super.init()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exercise = data[indexPath.row]
        
        cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseProgressTableViewCell", for: indexPath) as? ExerciseProgressTableViewCell
        cell.progressBar.progress = Float(progress)
        cell.exerciseTitleLabel.text = exercise.name
        cell.exerciseTitleLabel.textColor = Colours.primaryDark
        cell.timeLabel.textColor = Colours.primaryDark
        if let text = cell.timeLabel.text, let count = Int(text) {
            cell.timeLabel.text = count.timeFormat
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        exerciseSelectionDelegate.didTapExercise(videoIndex: indexPath.row)
        exerciseSelectionDelegate.reloadProgress(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

}


protocol ExerciseSelectionDelegate {
    var progress: Float { get set }
    func didTapExercise(videoIndex: Int)
    func reloadProgress(at: Int)
}


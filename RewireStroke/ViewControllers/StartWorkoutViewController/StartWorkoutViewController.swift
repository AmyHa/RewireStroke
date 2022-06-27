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
    
    func updateCurrentIndex(with index: Int) {
        self.currentIndex = index
    }
    
    @IBAction func closeWorkoutButtonTapped(_ sender: Any) {
        subscription?.cancel()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var closeWorkoutButton: DefaultButton!
    @IBOutlet weak var progressView: UIProgressView!
    private let startWorkoutViewModel = StartWorkoutViewModel()
    
    var progress: Float
    private var isPlaying = false
    private var maxTime: Int = 0
    private var currentIndex: Int = 0
    private var durationTime: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                self.timerLabel.text = "\(self.durationTime.timeFormat)"
            }
        }
    }
    private var timerLabel = UILabel()
    
    var runCount: Float = 0 {
        didSet{
            print("runcount changed: \(self.progressView.progress)")

        }
    }
    private var videoBackgroundButton = UIButton()

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
        
        playEmbedInVideo(video: 0)
        
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.register(UINib(nibName: "ExerciseProgressTableViewCell", bundle: nil), forCellReuseIdentifier: "ExerciseProgressTableViewCell")
        setupUI()
    }

    private func setupUI() {
        closeWorkoutButton.backgroundColor = Colours.primaryBlue
        closeWorkoutButton.titleLabel?.font = UIFont.outfitBold()
        closeWorkoutButton.setTitleColor(UIColor.white, for: .normal)
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.topAnchor.constraint(equalTo: videoContainerView.bottomAnchor).isActive = true
        progressView.bottomAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        progressView.progressTintColor = Colours.logoPink
        progressView.progress = 0.0
        progressView.isHidden = false
        progressView.alpha = 0
        
        view.addSubview(videoBackgroundButton)
        videoBackgroundButton.translatesAutoresizingMaskIntoConstraints = false
        videoBackgroundButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        videoBackgroundButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        videoBackgroundButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        videoBackgroundButton.bottomAnchor.constraint(equalTo: videoContainerView.bottomAnchor).isActive = true
        
        videoBackgroundButton.addTarget(self, action: #selector(resumeVideo), for: .touchUpInside)
            
        view.addSubview(timerLabel)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        timerLabel.bottomAnchor.constraint(equalTo: videoContainerView.bottomAnchor).isActive = true
        timerLabel.font = UIFont.outfitBold(size: 25)
        timerLabel.textColor = Colours.logoPink

    }
    
    @objc func runTimedCode() {
        // To prevent going into negative numbers
        guard self.durationTime > 0 else { return }
        self.durationTime -= 1
        
        let indexPath = IndexPath(row: self.currentIndex, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! ExerciseProgressTableViewCell
        
        DispatchQueue.main.async {
            cell.progressBar.progress = 1 - Float(self.durationTime)/Float(self.maxTime)
        }
    }
    
    @objc func resumeVideo() {
        if isPlaying {
            playerViewController.player?.pause()
            
            progressTimer.invalidate()

        } else {
            playerViewController.player?.play()
            
            // Start the timer and update progress bar
            progressTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        }
        isPlaying = !isPlaying
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

        let currentVideoPath = workout.exercises[video].videoPath
        
        HCVimeoVideoExtractor.fetchVideoURLFrom(url: URL(string: currentVideoPath)!, completion: { ( video:HCVimeoVideo?, error:Error?) -> Void in
            if let err = error {
                print("Error = \(err.localizedDescription)")
                return
            }
            
            guard let vid = video else {
                print("Invalid video object")
                return
            }
            
            let asset = AVURLAsset(url: vid.videoURL[.Quality720p]!)
            let duration = asset.duration
            self.maxTime = Int(CMTimeGetSeconds(duration))
            self.durationTime = Int(CMTimeGetSeconds(duration))
    
            DispatchQueue.main.async {
                self.playerViewController.player = AVPlayer(url: vid.videoURL[.Quality720p]!)
                self.timerLabel.text = "\(self.durationTime.timeFormat)"

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
        cell.timeLabel.text = ""
        if let text = cell.timeLabel.text, let count = Int(text) {
            cell.timeLabel.text = count.timeFormat
        }
        cell.playImage.tintColor = Colours.logoPink
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        exerciseSelectionDelegate.didTapExercise(videoIndex: indexPath.row)
        exerciseSelectionDelegate.updateCurrentIndex(with: indexPath.row)
//        exerciseSelectionDelegate.reloadProgress(at: indexPath.row)
        
        // then update the image for the current cell
//        cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseProgressTableViewCell", for: indexPath) as? ExerciseProgressTableViewCell
//        cell.playImage.alpha = 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

}


protocol ExerciseSelectionDelegate {
    var progress: Float { get set }
    func didTapExercise(videoIndex: Int)
    func reloadProgress(at: Int)
    func updateCurrentIndex(with: Int)
}


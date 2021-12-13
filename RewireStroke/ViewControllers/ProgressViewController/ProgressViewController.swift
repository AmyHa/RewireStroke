//
//  ProgressViewController.swift
//  RewireStroke
//
//  Created by Amy Ha on 12/03/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import UIKit
import Charts
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class ProgressViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var bottomImage: UIImageView!
    
    var painResults: [Result] = []
    var painChartData: [ChartDataEntry] = []
    typealias CompletionHandler = (_ success: Bool) -> Void
    
//    var customMarkerView: CustomMarkerView
    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        return chartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Progress"
        navigationController?.navigationBar.prefersLargeTitles = true

        // Need the below code to change bar title colour when using large titles – why?
        let appearance = UINavigationBarAppearance()
//            appearance.backgroundColor = Colours.primaryLowerLimb
            appearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.robotoMedium(size: 32), NSAttributedString.Key.foregroundColor: Colours.primaryBlue]
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // Line chart things
        lineChartView.delegate = self
        containerView.addSubview(lineChartView)
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineChartView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            lineChartView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            lineChartView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            lineChartView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        
        
        getPainResults { success in
            self.setData()
            self.setChartDesign()
        }
        setImages()
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        if let epochDate = entry.data {
            let date = convertEpochTimeToTextDate(date: epochDate as! Date)
            print(epochDate)
        }
    }
    
    func setChartDesign() {
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.enabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.leftAxis.axisMinimum = 0
    
        self.lineChartView.isUserInteractionEnabled = true
    }
    
    func setData() {
    
        let painDataSet = LineChartDataSet(entries: painChartData, label: "Nov 2021")
        let redColor = NSUIColor(red: 235/255, green: 100/255, blue: 96/255, alpha: 1)
//        let yellowColor = NSUIColor(red: 204/255, green: 102/255, blue: 0, alpha: 1)
        painDataSet.setCircleColor(redColor)
        painDataSet.drawCircleHoleEnabled = false
        painDataSet.setColor(redColor)
        let data = LineChartData()
        data.addDataSet(painDataSet)
        lineChartView.data = data
    }
    
    func getPainResults(completeionHandler: @escaping CompletionHandler) {
        let db = Firestore.firestore()
        db.collection("results").whereField("type", isEqualTo: "pain")
            .addSnapshotListener{ [self] (data, error) in
                if let err = error {
                    print("Error getting documents: \(err)")
                } else {
                    guard let results = data?.documents else {
                        print("no documents")
                        return
                    }
                    self.painResults = results.map({ result in
                        let data = result.data()
                        let type = result["type"]
                        let value = result["value"]
                        let dateObject = result["date"] as? Timestamp
                        let date = dateObject!.seconds
                        
                        if let type = type as? String, let value = value as? Int, let date = date as? Int64 {
                            
                            print("type: \(type)")
                            print("value: \(value)")
                            print("date: \(date)")
                            return Result(type: type, value: value, date: date)
                        }
                        return Result(type: "pain", value: 0, date: 0)
                    })
                    
                    for (index, result) in painResults.enumerated() {
                        self.painChartData.append(ChartDataEntry(x: Double(index), y: Double(result.value), data: Date(timeIntervalSince1970: Double(result.date))))
                    }
                    completeionHandler(true)

                }
            }
        
    }
    
    func setImages() {
        topImage.image = UIImage(named: "happy-face.png")
        bottomImage.image = UIImage(named: "sad-face.png")
    }
    
    func convertEpochTimeToTextDate(date: Date) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_GB")
        df.dateFormat = "dd E"
        return df.string(from: date)
    }
    
}

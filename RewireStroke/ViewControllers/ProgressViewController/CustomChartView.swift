//
//  CustomChartView.swift
//  RewireStroke
//
//  Created by Amy Ha on 02/01/2022.
//  Copyright © 2022 Amy Ha. All rights reserved.
//

import UIKit
import Charts
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class CustomChartView: LineChartView {

    var results: [Result] = []
    var chartData: [ChartDataEntry] = []

    typealias CompletionHandler = (_ success: Bool) -> Void
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(viewModel: ChartViewModel) {
        self.init()
        self.results = viewModel.results
        self.chartData = viewModel.chartData
        self.setupUI()
        getPainResults { success in
            self.setData()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        setChartDesign()
    }

    private func setChartDesign() {
        self.xAxis.drawGridLinesEnabled = false
        self.xAxis.drawAxisLineEnabled = false
        self.xAxis.enabled = false
        self.leftAxis.drawGridLinesEnabled = false
        self.rightAxis.enabled = false
        self.leftAxis.enabled = false
        self.leftAxis.axisMinimum = 0

        self.isUserInteractionEnabled = true
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
                    self.results = results.map({ result in
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

                    for (index, result) in self.results.enumerated() {
                        self.chartData.append(ChartDataEntry(x: Double(index), y: Double(result.value), data: Date(timeIntervalSince1970: Double(result.date))))
                    }
                    completeionHandler(true)

                }
            }
    }

    private func setData() {

        let painDataSet = LineChartDataSet(entries: chartData, label: "Nov 2021")
        let redColor = NSUIColor(red: 235/255, green: 100/255, blue: 96/255, alpha: 1)
//        let yellowColor = NSUIColor(red: 204/255, green: 102/255, blue: 0, alpha: 1)
        painDataSet.setCircleColor(redColor)
        painDataSet.drawCircleHoleEnabled = false
        painDataSet.setColor(redColor)
        let data = LineChartData()
        data.addDataSet(painDataSet)
        self.data = data
    }
    
    func convertEpochTimeToTextDate(date: Date) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_GB")
        df.dateFormat = "dd E"
        return df.string(from: date)
    }
}

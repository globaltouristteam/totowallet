//
//  TickerGraphCell.swift
//  Toto
//
//  Created by Nhuan Vu on 7/28/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit
import Charts

protocol TickerGraphCellDelegate: class {
    func didSwitchTo(range: TickerGraphRange)
}

class TickerGraphCell: UITableViewCell {
    weak var delegate: TickerGraphCellDelegate?

    @IBOutlet var btnRange: [UIButton]!
    @IBOutlet var chartView: LineChartView!
    @IBOutlet var lblInfo: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        for button in btnRange {
            button.layer.cornerRadius = button.frame.height/2
        }
        
        chartView.delegate = self
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.scaleXEnabled = false
        chartView.scaleYEnabled = false
        chartView.minOffset = 0
        
        
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.xAxis.enabled = false
        chartView.drawGridBackgroundEnabled = false
        chartView.drawBordersEnabled = false

        chartView.legend.setCustom(entries: [])
    }

    @IBAction func btnRangeClicked(_ sender: UIButton) {
        guard let index = btnRange.index(of: sender) else { return }
        delegate?.didSwitchTo(range: TickerGraphRange(rawValue: index)!)
    }
    
    func config(with range: TickerGraphRange, data: [GraphItem]) {
        for (index, button) in btnRange.enumerated() {
            if index == range.rawValue {
                button.backgroundColor = Colors.blue
                button.setTitleColor(UIColor.white, for: .normal)
            } else {
                button.backgroundColor = nil
                button.setTitleColor(UIColor.darkText, for: .normal)
            }
        }
        setChartData(data)
    }
    
    func setChartData(_ data: [GraphItem]) {
        var values = [ChartDataEntry]()
        for item in data {
            values.append(ChartDataEntry(x: item.timestamp ?? 0, y: item.priceUsd ?? 0))
        }
        
        updateInfo(with: values.last)
        
        let set1 = LineChartDataSet(values: values, label: nil)
        set1.drawIconsEnabled = false
        
        set1.lineDashLengths = [1, 0]
        set1.highlightLineDashLengths = [1, 0]
        set1.setColor(ChartColorTemplates.colorFromString("#ff2e91db"))
        set1.setCircleColor(.clear)
        set1.lineWidth = 1
        set1.circleRadius = 0
        set1.drawCircleHoleEnabled = false
        set1.valueFont = .systemFont(ofSize: 9)
        set1.formLineDashLengths = [1, 0]
        set1.formLineWidth = 1
        set1.formSize = 15
        
        let gradientColors = [ChartColorTemplates.colorFromString("#002e91db").cgColor,
                              ChartColorTemplates.colorFromString("#882e91db").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set1.fillAlpha = 1
        set1.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)
        set1.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: set1)
        
        chartView.animate(xAxisDuration: 2)
        chartView.data = data
    }
}

extension TickerGraphCell: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        updateInfo(with: entry)
    }
    
    func updateInfo(with entry: ChartDataEntry?) {
        guard let entry = entry else {
            lblInfo.text = ""
            return
        }
        let date = Date(timeIntervalSince1970: entry.x/1000)
        let price = Utils.stringWithCurrencySymbol(Float(entry.y))
        let f = DateFormatter()
        f.dateFormat = "MMM dd, yyyy 'at' hh:mm a"
        let string = String(format: "%@\n%@", price, f.string(from: date))
        lblInfo.text = string
    }
}

import UIKit
import CoreMotion
import Dispatch
import SwiftCharts


class Progress: UIViewController {
    private var  Walkchart: Chart? = nil
    private var  Runchart: Chart? = nil
    private var  Bikechart: Chart? = nil
    
    override func viewDidLoad() {
        
        let chartConfig = ChartConfigXY(
            xAxisConfig: ChartAxisConfig(from: 1, to: 7, by: 1),
            yAxisConfig: ChartAxisConfig(from: 0, to: 14, by: 2)
        )

        let frame = CGRect(x: 35, y: 75, width: 310, height: 150)

        let chart = LineChart(
            frame: frame,
            chartConfig: chartConfig,
            xTitle: "Walking (daily)",
            yTitle: "Steps",
            lines: [
                (chartPoints: [(2.0, 10.6), (4.2, 5.1), (7.3, 3.0), (8.1, 5.5), (14.0, 8.0)], color: UIColor.orange)
                
            ]
        )
        
        self.view.addSubview(chart.view)
        self.Walkchart = chart
        
        let frame1 = CGRect(x: 35, y: 225, width: 310, height: 150)

        let chart1 = LineChart(
            frame: frame1,
            chartConfig: chartConfig,
            xTitle: "Running (daily)",
            yTitle: "Steps",
            lines: [
                (chartPoints: [(2.0, 1.6), (4.2, 4.1), (7.3, 3.0), (7.1, 5.5), (14.0, 4.0)], color: UIColor.orange)
                
            ]
        )
        
        self.view.addSubview(chart1.view)
        self.Runchart = chart1
        
        let frame2 = CGRect(x: 35, y: 375, width: 310, height: 150)

        let chart2 = LineChart(
            frame: frame2,
            chartConfig: chartConfig,
            xTitle: "Biking (daily)",
            yTitle: "Steps",
            lines: [
         (chartPoints: [(2.0, 9.6), (4.2, 3.1), (7.3, 10.0), (8.1, 6.5), (14.0, 8.0)], color: UIColor.orange)
                
            ]
        )
        
        self.view.addSubview(chart2.view)
        self.Bikechart = chart2
        
    }
    
}

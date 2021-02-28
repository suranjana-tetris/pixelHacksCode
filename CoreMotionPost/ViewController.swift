import UIKit
import CoreMotion
import Dispatch
import SwiftCharts


class ViewController: UIViewController ,WeightProtocol {
    func addTree() {
        print("Add Tree")
    }
    

    @IBOutlet weak var ActImage: UIImageView!
    @IBOutlet weak var StepsImg: UIImageView!
    private let activityManager = CMMotionActivityManager()
    private let pedometer = CMPedometer()
    private var shouldStartUpdating: Bool = false
    private var startDate: Date? = nil
    private var  chart: Chart? = nil
    
    

    @IBOutlet weak var TreeButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stepsCountLabel: UILabel!
    @IBOutlet weak var activityTypeLabel: UILabel!
    
    @IBAction func SwitchTree(_ sender: UIButton) {
        
             
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let startDate = startDate else { return }
        updateStepsCountLabelUsing(startDate: startDate)
    }

    @objc private func didTapStartButton() {
        shouldStartUpdating = !shouldStartUpdating
        shouldStartUpdating ? (onStart()) : (onStop())
    }
}


extension ViewController {
    private func onStart() {
        
        StepsImg.frame.origin = CGPoint(x:10,y:430)
        ActImage.frame.origin = CGPoint(x:250,y:430)
        stepsCountLabel.frame.origin = CGPoint(x:20,y:410)
        activityTypeLabel.frame.origin = CGPoint(x:240,y:410)
        stepsCountLabel.isHidden = false
        activityTypeLabel.isHidden = false
        startButton.setTitle("Stop", for: .normal)
        
        
        var delegate: WeightProtocol?
        delegate?.addTree()
        
        startDate = Date()
        checkAuthorizationStatus()
        startUpdating()
        let chartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: 8, by: 2)
        )
        
        let frame = CGRect(x: 0, y: 70, width: 300, height: 300)
                
        let chart = BarsChart(
            frame: frame,
            chartConfig: chartConfig,
            xTitle: "X axis",
            yTitle: "Y axis",
            bars: [
                ("A", 2),
                ("B", 4.5),
                ("C", 3),
                ("D", 5.4),
                ("E", 6.8),
                ("F", 0.5)
            ],
            color: UIColor.red,
            barWidth: 20
        )
        
        self.view.addSubview(chart.view)
        self.chart = chart
    }
    
    private func onStop() {
        startButton.setTitle("Start", for: .normal)
        startDate = nil
        stopUpdating()
    }

    private func startUpdating() {
        if CMMotionActivityManager.isActivityAvailable() {
            startTrackingActivityType()
        } else {
            activityTypeLabel.text = "Stationary"
        }

        if CMPedometer.isStepCountingAvailable() {
            startCountingSteps()
        } else {
            stepsCountLabel.text = "0"
        }
    }

    private func checkAuthorizationStatus() {
        switch CMMotionActivityManager.authorizationStatus() {
        case CMAuthorizationStatus.denied:
            onStop()
            activityTypeLabel.text = "Not available"
            stepsCountLabel.text = "Not available"
        default:break
        }
    }

    private func stopUpdating() {
        activityManager.stopActivityUpdates()
        pedometer.stopUpdates()
        pedometer.stopEventUpdates()
    }

    private func on(error: Error) {
        //handle error
    }

    private func updateStepsCountLabelUsing(startDate: Date) {
        pedometer.queryPedometerData(from: startDate, to: Date()) {
            [weak self] pedometerData, error in
            if let error = error {
                self?.on(error: error)
            } else if let pedometerData = pedometerData {
                DispatchQueue.main.async {
                    self?.stepsCountLabel.text = String(describing: pedometerData.numberOfSteps)
                }
            }
        }
    }

    private func startTrackingActivityType() {
        
        activityManager.startActivityUpdates(to: OperationQueue.main) {
            [weak self] (activity: CMMotionActivity?) in
            guard let activity = activity else { return }
            DispatchQueue.main.async {
                if activity.walking {
                    self?.activityTypeLabel.text = "Walking"
                } else if activity.stationary {
                    self?.activityTypeLabel.text = "Stationary"
                } else if activity.running {
                    self?.activityTypeLabel.text = "Running"
                } else if activity.automotive {
                    self?.activityTypeLabel.text = "Automotive"
                }
            }
        }
    }

    private func startCountingSteps() {
        
        
        pedometer.startUpdates(from: Date()) {
            [weak self] pedometerData, error in
            guard let pedometerData = pedometerData, error == nil else { return }

            DispatchQueue.main.async {
                self?.stepsCountLabel.text = pedometerData.numberOfSteps.stringValue
            }
        }
    }
}

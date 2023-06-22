//
//  ViewController.swift
//  START-HW12-Baqytzhanuly-Almaz
//
//  Created by allz on 6/19/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    private var isStarted: Bool = false
    private var isWorkTime: Bool = true
    private let workDuration: TimeInterval = 4
    private let breakDuration: TimeInterval = 2
    private var timeRemaining: TimeInterval = 0
    private var totalDuration: TimeInterval = 0
    private var timer: Timer = Timer()
    private var currentTimeForLabel: TimeInterval = 0
    private let circleRadius: CGFloat = 300
    private let redColor: UIColor = UIColor(red: 0.9895820022, green: 0.5559109449, blue: 0.5085786581, alpha: 1)
    private let greenColor: UIColor = UIColor(red: 0.4070520401, green: 0.7629214525, blue: 0.6445431113, alpha: 1)
    
    
    // MARK: - UI elements
    
    private lazy var circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear

        return view
    }()

    private lazy var progressBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = circleRadius / 2

        return view
    }()

    private lazy var progressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = circleRadius
        layer.strokeColor = redColor.cgColor
        layer.fillColor = UIColor.clear.cgColor

        return layer
    }()

    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:04"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 72)
        label.textColor = redColor

        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "red_play_icon"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill

        return button
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    
    // MARK: - Setups
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(circleView)
        circleView.addSubview(progressBarView)
        progressBarView.layer.addSublayer(progressLayer)
        circleView.addSubview(timerLabel)
        circleView.addSubview(startButton)
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: circleRadius / 2, y: circleRadius / 2),
                                      radius: circleRadius / 2,
                                      startAngle: -CGFloat.pi / 2,
                                      endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        progressLayer.path = circlePath.cgPath
        progressLayer.lineWidth = 4
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeEnd = 1
        progressLayer.lineCap = CAShapeLayerLineCap.round
    }
    
    private func setupConstraints() {
        circleView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(circleRadius)
        }
        
        progressBarView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(circleRadius)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(progressBarView.snp.centerY).offset(-40)
        }
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(progressBarView.snp.bottom).offset(-50)
            make.width.height.equalTo(40)
        }
    }
    
    
    // MARK: - Actions
    
    @objc private func startButtonTapped() {
        if isStarted {
            stopTimer()
            if isWorkTime {
                startButton.setImage(UIImage(named: "red_play_icon"), for: .normal)
            } else {
                startButton.setImage(UIImage(named: "green_play_icon"), for: .normal)
            }
        } else {
            startTimer()
            startButton.setImage(UIImage(named: "stop_icon"), for: .normal)
        }
    }
    
    private func startTimer() {
        if timeRemaining <= 0 {
            timeRemaining = isWorkTime ? workDuration : breakDuration
            totalDuration = isWorkTime ? workDuration : breakDuration
        }

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isStarted = true
    }
    
    private func stopTimer() {
        timer.invalidate()
        isStarted = false
    }
    
    @objc private func updateTimer() {
        currentTimeForLabel = timeRemaining
        timeRemaining -= 1
        updateTimerLabel()
        updateUI()

        if timeRemaining <= 0 {
            stopTimer()
            isWorkTime = !isWorkTime
            startTimer()
        }
    }
    
    private func updateTimerLabel() {
        let seconds = Int(currentTimeForLabel) % 60
        timerLabel.text = "00:\(String(format: "%02d", seconds))"
    }
    
    private func updateUI() {
        if isWorkTime {
            progressLayer.strokeColor = redColor.cgColor
            timerLabel.textColor = redColor
        } else {
            progressLayer.strokeColor = greenColor.cgColor
            timerLabel.textColor = greenColor
        }
    }
}

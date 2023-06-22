//
//  ViewController.swift
//  START-HW12-Baqytzhanuly-Almaz
//
//  Created by allz on 6/19/23.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
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
    }
}

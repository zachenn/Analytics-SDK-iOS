//
//  ViewController.swift
//  Test
//
//  Created by Zach Chen on 8/5/19.
//  Copyright © 2019 Zach Chen. All rights reserved.
//

import UIKit
import AnalyticsSDK

class ViewController: UIViewController {
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		print("cant swizzle me!")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let button = UIButton()
		
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Apple", for: .normal)
		button.setTitleColor(.black, for: .normal)
		
		view.addSubview(button)
		button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		button.heightAnchor.constraint(equalToConstant: 40).isActive = true
		button.widthAnchor.constraint(equalToConstant: 70).isActive = true
		
		button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
		
		let control = UISwitch()
		control.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(control)
		control.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		control.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10).isActive = true
		control.heightAnchor.constraint(equalToConstant: 40).isActive = true
		control.widthAnchor.constraint(equalToConstant: 70).isActive = true
		
		control.addTarget(self, action: #selector(controlPressed), for: .touchUpInside)
		
//		let touchGestureRecognizer = 
	}
	
	@objc private func buttonPressed() {
		print("button pressed")
	}
	
	@objc private func controlPressed() {
		HeapAnalytics.shared.log(.customEvent(named: "custom event"))
	}
}

// MARK: - Subclass UIApplication
//class UIApplicationSubclass: UIApplication {
//	
//	override func sendAction(_ action: Selector, to target: Any?, from sender: Any?, for event: UIEvent?) -> Bool {
//		
//		DispatchQueue.global(qos: .utility).async {
//			switch sender {
//			case is UIButton:
//				print("UIButton pressed!")
//			default:
//				print("Default")
//			}
//		}
//		
//		return super.sendAction(action, to: target, from: sender, for: event)
//	}
//}

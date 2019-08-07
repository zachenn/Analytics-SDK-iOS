//
//  AutomaticTracking.swift
//  AnalyticsSDK
//
//  Created by Zach Chen on 8/6/19.
//  Copyright © 2019 Zach Chen. All rights reserved.
//

import Foundation

// MARK: - Automatic tracking

// use of load() deprecated in Swift 1.2 and initialize() deprecated in Swift 3.1 meaning we have to use a different method of swizzling
// both methods are automatically invoked by the Obj C runtime for each class
// swizzling should always be done in load()
// load() is called just before the application calls its first method on that class. it is guarnteed to be loaded during class initialization
// initialize() is called when it is messaged directly by the app (not guaranteed)

// here we can create our generic swizzle closure to be used
private let swizzle: (AnyClass, Selector, Selector) -> () = { forClass, originalSelector, swizzledSelector in
	if let originalMethod = class_getInstanceMethod(forClass, originalSelector),
		let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector) {
		method_exchangeImplementations(originalMethod, swizzledMethod)
	}
}

extension UIViewController {
	static public let classInit = {
		let originalSelector = #selector(viewWillAppear(_:))
		let swizzledSelector = #selector(analyticsViewWillAppear(animated:))
		swizzle(UIViewController.self, originalSelector, swizzledSelector)
	}
	
	// MARK: - Swizzled Methods
	@objc private func analyticsViewWillAppear(animated: Bool) {
		
		// call the original viewDidAppear using the swizzledViewDidAppear signature
		analyticsViewWillAppear(animated: true)
		DispatchQueue.global(qos: .utility).async {
			HeapAnalytics.shared.log(.pageViewed)
			print("\(self) viewed")
		}
	}
}

extension UIApplication {
	
	static public let classInit = {
		let originalSendActionSelector = #selector(sendAction(_:to:from:for:))
		let swizzledSendActionSelector = #selector(analyticsSendAction(_:to:from:for:))
		swizzle(UIApplication.self, originalSendActionSelector, swizzledSendActionSelector)
		
		let originalSendEventSelector = #selector(sendEvent(_:))
		let swizzledSendEventSelector = #selector(analyticsSendEvent(_:))
		swizzle(UIApplication.self, originalSendEventSelector, swizzledSendEventSelector)
	}
	
	@objc private func analyticsSendAction(_ action: Selector, to target: Any?, from sender: Any?, for event: UIEvent?) -> Bool {
		DispatchQueue.global(qos: .utility).async {
			HeapAnalytics.shared.log(.buttonClicked)
			switch sender {
			case is UIButton:
				if let button = sender as? UIButton {
					DispatchQueue.main.async {
						print("\(String(describing: button.titleLabel?.text)) button pressed")
					}
				}
			default:
				print("\(sender.debugDescription) pressed")
			}
		}
		
		return analyticsSendAction(action, to: target, from: sender, for: event)
	}
	
	@objc private func analyticsSendEvent(_ event: UIEvent) {
		
	}
	
	
}

/* some areas to look out for:

- If the user overrides the method (ie viewWillAppear), then our swizzled method becomes invalid. in that regard, we have to make sure to call super.viewWillAppear
- we are calling our swizzed method within our swizzle function instead of the original method. not sure why, but it works, and calling the original method results in an infinite loop

*/


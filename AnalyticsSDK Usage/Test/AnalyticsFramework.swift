//
//  AnalyticsFramework.swift
//  Test
//
//  Created by Zach Chen on 8/6/19.
//  Copyright © 2019 Zach Chen. All rights reserved.
//

import UIKit

public class AnalyticsFramework {
	
	// MARK: - Initializers
	private init() {
		UIViewController.classInit()
		UIApplication.classInit()
	}
	
	// MARK: - Properties
	static let shared = AnalyticsFramework()
}

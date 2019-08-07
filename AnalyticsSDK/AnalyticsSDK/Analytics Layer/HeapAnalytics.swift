//
//  HeapAnalytics.swift
//  AnalyticsSDK
//
//  Created by Zach Chen on 8/6/19.
//  Copyright © 2019 Zach Chen. All rights reserved.
//

import Foundation

// The user of the framework will need to call HeapAnalytics.shared in the AppDelegate didFinishLaunchingWithOptions
// This is essentially the "View" b/c it is what the "users see" and interact with

public class HeapAnalytics {
	
	// MARK: - Intializers
	private init(analyticsEngine: AnalyticsEngineProtocol) {
		self.analyticsEngine = analyticsEngine
		UIViewController.classInit()
		UIApplication.classInit()
	}
	
	// MARK: - Private Properties
	private let analyticsEngine: AnalyticsEngineProtocol
	
	// MARK: - Public Properties
	static public let shared = HeapAnalytics(analyticsEngine: HeapAnalyticsEngine())
	
	// MARK: - Methods
	public func log(_ event: AnalyticsEvent) {
		analyticsEngine.sendAnalyticsEvent(named: event.name, data: event.data)
	}
}

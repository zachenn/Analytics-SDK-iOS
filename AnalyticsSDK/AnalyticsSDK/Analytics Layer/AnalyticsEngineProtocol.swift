//
//  AnalyticsEngineProtocol.swift
//  AnalyticsSDK
//
//  Created by Zach Chen on 8/6/19.
//  Copyright © 2019 Zach Chen. All rights reserved.
//

import Foundation

// Engine is responsible for sending AnalyticsEvents to the backend
// It is almost like a viewModel

protocol AnalyticsEngineProtocol {
	
	func sendAnalyticsEvent(named name: String, data: [String: Any])
}

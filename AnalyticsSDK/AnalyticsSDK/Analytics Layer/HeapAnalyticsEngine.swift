//
//  HeapAnalyticsEngine.swift
//  AnalyticsSDK
//
//  Created by Zach Chen on 8/6/19.
//  Copyright © 2019 Zach Chen. All rights reserved.
//

import Foundation

class HeapAnalyticsEngine: AnalyticsEngineProtocol {

	// MARK: - Initializer
	init(networkProtocol: NetworkProtocol = HeapBackend()) {
		self.networkProtocol = networkProtocol
	}

	// MARK: - Properties
	private let networkProtocol: NetworkProtocol
	
	// MARK: - Methods
	func sendAnalyticsEvent(named name: String, data: [String : Any]) {
		networkProtocol.sendPostRequest(withData: data)
	}
}

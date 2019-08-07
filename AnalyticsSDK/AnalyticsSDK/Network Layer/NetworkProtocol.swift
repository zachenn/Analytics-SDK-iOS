//
//  NetworkProtocol.swift
//  AnalyticsSDK
//
//  Created by Zach Chen on 8/6/19.
//  Copyright © 2019 Zach Chen. All rights reserved.
//

import Foundation

protocol NetworkProtocol {
	
	// MARK: - Properties
	
	
	// MARK: - Methods
	func sendPostRequest(withData data: [String: Any])
}

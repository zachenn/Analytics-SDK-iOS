//
//  AnalyticsEvent.swift
//  AnalyticsSDK
//
//  Created by Zach Chen on 8/6/19.
//  Copyright © 2019 Zach Chen. All rights reserved.
//

import Foundation

public enum AnalyticsEvent {
	case pageViewed
	case buttonClicked
	case customEvent(named: String)
}

extension AnalyticsEvent {
	
	var name: String {
		switch self {
		case .buttonClicked,
			 .pageViewed:
			return String(describing: self)
		case .customEvent(let named):
			return named
		}
	}
	
	var data: [String: Any] {
		switch self {
		case .buttonClicked,
			 .pageViewed,
			 .customEvent:
			return [:]
		}
	}
}

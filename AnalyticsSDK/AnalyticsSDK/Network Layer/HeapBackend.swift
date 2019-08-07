//
//  HeapBackend.swift
//  AnalyticsSDK
//
//  Created by Zach Chen on 8/6/19.
//  Copyright © 2019 Zach Chen. All rights reserved.
//

import Foundation

class HeapBackend: NetworkProtocol {
	
	private let defaultSession = URLSession(configuration: .default)
	private var dataTask: URLSessionDataTask?
	private let baseURL = "baseURL"
	
	func sendPostRequest(withData data: [String: Any]) {
		
		DispatchQueue.global(qos: .utility).async { [weak self] in
			self?.dataTask?.cancel()
			
			let urlComponents = URLComponents(string: self!.baseURL)
			guard let url = urlComponents?.url else { return }
			
			var urlRequest = URLRequest(url: url)
			urlRequest.httpMethod = "POST"
			
			do {
				let payload = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
				urlRequest.httpBody = payload
				urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
				
				self?.dataTask = self?.defaultSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
					if let error = error {
						print("A network error occured, fix me")
					}
					print("Sent to backend!")
				})
				
				self?.dataTask?.resume()
			} catch {
				print("A JSONSerialization error occurred. Fix me")
			}
		}
	}
	
}

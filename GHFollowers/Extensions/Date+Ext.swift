//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-07-03.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import Foundation

extension Date {
	
	func convertToMonthYearFormat() -> String {
		let formatter			= DateFormatter()
		formatter.dateFormat	= "MMM yyyy"
		return formatter.string(from: self)
	}
}

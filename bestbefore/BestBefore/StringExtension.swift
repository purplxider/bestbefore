//
//  StringExtension.swift
//  BestBefore
//
//  Created by 재현 on 2018. 7. 5..
//  Copyright © 2018년 0. All rights reserved.
//

import Foundation

extension String {
    var westernArabicNumeralsOnly: String {
        let pattern = UnicodeScalar("0")..."9"
        return String(unicodeScalars
            .flatMap { pattern ~= $0 ? Character($0) : nil })
    }
}

//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Kostiantyn Kaniuka on 08.11.2022.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}

//
//  Array+Extension.swift
//  SwipableCard
//
//  Created by Kusal Shrestha on 6/3/16.
//  Copyright © 2016 Kusal Shrestha. All rights reserved.
//

import Foundation

extension Array {
    /* treats the last element as 0 (reverse ordering)*/
    func nthElementFromLast(n: Int) -> Element? {
        if endIndex > n {
            return self[endIndex - n - 1]
        }
        return nil
    }
}

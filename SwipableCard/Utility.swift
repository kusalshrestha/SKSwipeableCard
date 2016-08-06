//
//  Utility.swift
//  SwipableCard
//
//  Created by Kusal Shrestha on 6/2/16.
//  Copyright © 2016 Kusal Shrestha. All rights reserved.
//

import Foundation
import UIKit

func randomColor() -> UIColor{
    let red = CGFloat(drand48())
    let green = CGFloat(drand48())
    let blue = CGFloat(drand48())
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}

func +(point1: CGPoint, point2: CGPoint) -> CGPoint {
    return CGPoint(x: point1.x + point2.x, y: point1.y + point2.y)
}

func -(point1: CGPoint, point2: CGPoint) -> CGPoint {
    return CGPoint(x: point1.x - point2.x, y: point1.y - point2.y)
}

func *(frame: CGRect, multiplier: CGFloat) -> CGRect {
    return CGRect(x: frame.origin.x * multiplier,
                  y: frame.origin.y * multiplier, width: frame.width * multiplier, height: frame.height * multiplier)
}

func +(frame1: CGRect, frame2: CGRect) -> CGRect {
    return CGRect(x: frame1.origin.x - frame2.origin.x,
                  y: frame1.origin.y - frame2.origin.y,
                  width: frame1.width + frame2.width,
                  height: frame1.height + frame2.height)
}

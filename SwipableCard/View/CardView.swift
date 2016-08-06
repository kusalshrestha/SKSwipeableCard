//
//  DraggableView.swift
//  SwipableCard
//
//  Created by Kusal Shrestha on 6/2/16.
//  Copyright © 2016 Kusal Shrestha. All rights reserved.
//

import UIKit

protocol CardSwipeGestureDelegate: class {
    
    func swipeActionHandler(offsetPercentage percent: CGFloat)
    func cardRemoved()
    
}

enum AnimateToSide {
    case Left, Right, Center
    
    var getFinalPositionToAnimate: CGPoint {
        switch self {
        case .Left:
            let toLeftPosition = -UIScreen.mainScreen().bounds.width
            return CGPoint(x: toLeftPosition, y: 0)
        case .Right:
            let toRightPosition = UIScreen.mainScreen().bounds.width
            return CGPoint(x: toRightPosition, y: 0)
        case .Center:
            return CGPoint(x: 0, y: 0)
        }
    }
}

class CardView: UIView {

    @IBOutlet var profilePictureImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var bioLabel: UILabel!
    @IBOutlet var likeImageView: UIImageView!
    @IBOutlet var dislikeImageView: UIImageView!
    
    weak var delegate: CardSwipeGestureDelegate?
    private var animateTowardsSide: AnimateToSide = .Center
    
    let leftVerticalLimit = UIScreen.mainScreen().bounds.width * 0.15
    let rightVerticalLimit = UIScreen.mainScreen().bounds.width * (1 - 0.15)
    
    override func drawRect(rect: CGRect) {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.layer.shadowRadius = -3
        self.layer.shadowColor = UIColor.redColor().CGColor
        self.layer.shadowOpacity = 0.6
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addPanGesture()
        
    }
    
    private func addPanGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(CardView.panGestureHandler(_:)))
        self.addGestureRecognizer(gesture)
    }
    
    func panGestureHandler(gesture: UIPanGestureRecognizer) {
        var cardPosition = self.center
        switch gesture.state {
        case .Changed:
            cardPosition = gesture.translationInView(gesture.view)
            self.frame.origin = cardPosition
        case .Ended:
            animateCardSwipe()
        default:
            break
        }
        
        let offsetPercent = abs(self.frame.origin.x) / (UIScreen.mainScreen().bounds.width / 2)
        delegate?.swipeActionHandler(offsetPercentage: offsetPercent)
    }
    
    private func hideShowLikeDislikeImage() {
        // like image
        
    }
    
    private func animateCardSwipe() {
        if self.center.x < leftVerticalLimit {
            animateTowardsSide = .Left
        } else if self.center.x > rightVerticalLimit {
            animateTowardsSide = .Right
        } else {
            animateTowardsSide = .Center
        }
        
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            // Animation code goes here
            self.frame.origin = self.animateTowardsSide.getFinalPositionToAnimate
            }) { (completed) in
                // Completion code goes here
                if completed {
                    if self.animateTowardsSide != .Center {
                        self.delegate?.cardRemoved()
                    }
                }
        }
    }

}

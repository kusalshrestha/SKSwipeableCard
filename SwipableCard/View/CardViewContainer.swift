//
//  DraggableViewContainer.swift
//  SwipableCard
//
//  Created by Kusal Shrestha on 6/2/16.
//  Copyright © 2016 Kusal Shrestha. All rights reserved.
//

import UIKit

class CardViewContainer: UIView {
    
    enum Cards: Int {
        case BaseCard = 1
        case BottomCard
        case MiddleCard
        case TopCard
        
        var frame: CGRect {
            switch self {
            case .BaseCard:
                return CardViewContainer.bottomCardFrame

            case .BottomCard:
                return CardViewContainer.bottomCardFrame
                
            case .MiddleCard:
                return CardViewContainer.middleCardFrame

            case .TopCard:
                return CardViewContainer.topCardFrame
            }
        }
    }

    var maxCards = 10
    private var currentCardIndex = 1
    private var cards: [CardView?] = []
    
    private static var topCardFrame = CGRectZero
    private static var middleCardFrame = CGRectZero
    private static var bottomCardFrame = CGRectZero
    
    
    convenience init(WithMaxCards number: Int, frame: CGRect) {
        self.init(frame: frame)
        
        if number < 1 {
            self.maxCards = 1
        }
        self.maxCards = number
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {}
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setCardsFrames()
    }
    
    private func setCardsFrames() {
        CardViewContainer.bottomCardFrame = CGRect(x: 8, y: 24, width: self.bounds.width - 16, height: self.bounds.height - 8)
        CardViewContainer.middleCardFrame = CGRect(x: 4, y: 12, width: self.bounds.width - 8, height: self.bounds.height - 4)
        CardViewContainer.topCardFrame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
    }
    
    func generateSwipeableCards() {
        // Gererates first four cards
        for i in currentCardIndex...4 {
            let card = NSBundle.mainBundle().loadNibNamed("Card", owner: self, options: nil).first as! CardView
            card.delegate = self
            card.frame = (Cards(rawValue: i)?.frame)!
            card.backgroundColor = randomColor()
            self.addSubview(card)
            cards.append(card)
        }
    }
    
    private func addNewCard() {
        let card = NSBundle.mainBundle().loadNibNamed("Card", owner: self, options: nil).first as! CardView
        card.delegate = self
        card.frame = Cards.BaseCard.frame
        card.backgroundColor = randomColor()
        self.insertSubview(card, belowSubview: cards[0]!)
        cards.insert(card, atIndex: 0)
    }
    
    private func updateCardFrames(changePercent: CGFloat) {
        // middle to top
        if let midCard = cards.nthElementFromLast(1) {
            midCard!.frame = CardViewContainer.middleCardFrame + (CGRect(x: 4, y: 12, width: 8, height: 4) * changePercent)
        }
        if let bottomCard = cards.nthElementFromLast(2) {
            bottomCard!.frame = CardViewContainer.bottomCardFrame + (CGRect(x: 4, y: 12, width: 8, height: 4) * changePercent)
        }
    }
    
}

extension CardViewContainer: CardSwipeGestureDelegate {
    
    func swipeActionHandler(offsetPercentage percent: CGFloat) {
        guard percent >= 0 && percent <= 1 else {
            return
        }
        updateCardFrames(percent)
    }
    
    func cardRemoved() {
        print(currentCardIndex)
        cards.removeLast()
        if currentCardIndex <= (maxCards - 4) {
            addNewCard()
        }
        currentCardIndex += 1
    }
    
}

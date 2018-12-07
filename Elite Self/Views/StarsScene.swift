//
//  StarsScene.swift
//  Elite Self
//
//  Created by Alexandra on 23/03/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import SpriteKit

class StarsScene: SKScene {
    
    var stars: SKEmitterNode!
    var bgColor = UIColor(hue: 0.62, saturation: 0.5, brightness: 0.206, alpha: 1.0)
    
    override func didMove(to view: SKView) {
        setupScene()
        addStars()
    }
    func setupScene() {
        self.scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scene?.scaleMode = .aspectFill
        self.scene?.backgroundColor = UIColor.dirtyDarkRed // bgColor
    }
    func addStars() {
        stars = SKEmitterNode(fileNamed: "StarsScene")!
        stars.setScale(1.3)
        stars.advanceSimulationTime(10)
        stars.zPosition = -1
        addChild(stars)
    }
}

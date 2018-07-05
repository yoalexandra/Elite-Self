//
//  BigGoalsScene.swift
//  Elite Self
//
//  Created by Администратор on 23/03/2018.
//  Copyright © 2018 alejandra. All rights reserved.
//

import SpriteKit

class StarsScene: SKScene {
    
    var stars: SKEmitterNode!
   
    var bgColor = UIColor(hue: 0.62, saturation: 0.5, brightness: 0.206, alpha: 1.0)
    
    override func didMove(to view: SKView) {
        self.scene?.backgroundColor = bgColor
        addStars()
    }
    func addStars() {
        stars = SKEmitterNode(fileNamed: "StarsScene")!
        stars.advanceSimulationTime(10)
        stars.zPosition = -1
        addChild(stars)
    }
}

//
//  NRMyScene.m
//  TW048
//
//  Created by Niklas Riekenbrauck on 20.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "NRGameScene.h"
#import "NRMap.h"

//http://www.raywenderlich.com/49502/procedural-level-generation-in-games-tutorial-part-1

@implementation NRGameScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        //Scene setup
        self.backgroundColor = UIColorFromRGB(0xbbada0);
        
        // Represents the background
        NRMap *map = [NRMap node];
        [map generate];
        [self addChild:map];
    
        // Represents an actual tile map
        
    }
    return self;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void)performedSwipeGestureInDirection:(Direction)direction {
    
}

@end
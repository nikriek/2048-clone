//
//  NRMyScene.m
//  TW048
//
//  Created by Niklas Riekenbrauck on 20.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "NRGameScene.h"
#import "NRBackgroundMap.h"

//http://www.raywenderlich.com/49502/procedural-level-generation-in-games-tutorial-part-1

@implementation NRGameScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        //Scene setup
        self.backgroundColor = UIColorFromRGB(0xbbada0);
        
        // Represents the background
        NRBackgroundMap *backgroundMap = [NRBackgroundMap node];
        [backgroundMap generate];
        [self addChild:backgroundMap];
    
        // Represents an actual tile map
        self.mapTiles = [NRTileMap node];
        [self addChild:self.mapTiles];
        
    }
    return self;
}

-(void)didMoveToView:(SKView *)view {
    [self.mapTiles setNewTileAtRandomFreePosition];
    [self.mapTiles setNewTileAtRandomFreePosition];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end

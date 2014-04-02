//
//  NRMyScene.m
//  TW048
//
//  Created by Niklas Riekenbrauck on 20.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck & Georg Zänker. All rights reserved.
//

#import "NRGameScene.h"
#import "NRTile.h"

//http://www.raywenderlich.com/49502/procedural-level-generation-in-games-tutorial-part-1

@implementation NRGameScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        // Represents an actual tile map
        self.mapTiles = [NRTileMap node];
        [self addChild:self.mapTiles];
        
        //Scenebackground setup
        self.backgroundColor = UIColorFromRGB(0xbbada0);
        [self generateBackground];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view {
    [self.mapTiles setUpNewGame];
//    [self.mapTiles insertTestTileWithCoordinates:CGPointMake(0, 1) andValue:1024];
//    [self.mapTiles insertTestTileWithCoordinates:CGPointMake(0, 0) andValue:1024];

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void)generateBackground {
    for (int y = 0; y < 4; y++) {
        for (int x = 0; x < 4; x++) {
            CGFloat xCoordinate = (CGFloat)x;
            CGFloat yCoordinate = (CGFloat)y;
            CGPoint coordinates = CGPointMake(xCoordinate, yCoordinate);
            NRTile *tile = [[NRTile alloc] initBackWithCoordinates:coordinates];
            [self addChild:tile];
        }
    }
}

@end

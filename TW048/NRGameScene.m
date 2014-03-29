//
//  NRMyScene.m
//  TW048
//
//  Created by Niklas Riekenbrauck on 20.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
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
        
        //Scene setup
        self.backgroundColor = UIColorFromRGB(0xbbada0);
        [self generateBackgroundMap];
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

-(void)generateBackgroundMap {
    for (int y = 0; y < 4; y++) {
        for (int x = 0; x < 4; x++) {
            CGFloat xCoordinate = (CGFloat)x;
            CGFloat yCoordinate = (CGFloat)y;
            CGPoint coordinates = CGPointMake(xCoordinate, yCoordinate);
            NRTile *tile = [[NRTile alloc] initBackWithCoordinates:coordinates];
            [self.mapTiles addChild:tile];
        }
    }
}

@end

//
//  NRMapTile.m
//  TW048
//
//  Created by Niklas Riekenbrauck on 21.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "NRTileMap.h"
#import "NRTile.h"
#import "NRTileMatrix.h"

@implementation NRTileMap {
    NRTileMatrix *tileMatrix;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        tileMatrix = [NRTileMatrix new];
    }
    return self;
}

-(void)setNewTileAtRandomPosition {
    if ([tileMatrix countOfTiles] < 16) {
        for (int x = 0; x < 4; x++) {
            for (int y = 0; y < 4; y++) {
                CGFloat xCoordinate = (CGFloat)x;
                CGFloat yCoordinate = (CGFloat)y;
                CGPoint position = [self positionForTileWithCoordinates:CGPointMake(xCoordinate, yCoordinate)];
                if ([tileMatrix tileAtCoordinates:CGPointMake(xCoordinate, yCoordinate)] == nil) {
                    NRTile *tile = [[NRTile alloc] initWithPosition:position];
                    tile.currentValue = 32;
                    [tileMatrix insertTile:tile atCoordinates:CGPointMake(xCoordinate, yCoordinate)];
                    [self addChild:tile];
                    break;
                }
            }
        }
    }
}

-(void)moveTile:(NRTile*)tile toPosition:(CGPoint)newPosition {
    CGPoint oldPosition = [tileMatrix coordinatesOfTile:tile];
    if (oldPosition.x != -1.0) {
        SKAction *moveAction;
        [tile runAction: moveAction];
    }
    
}

-(void)performedSwipeGestureInDirection:(Direction)direction {
    /*
    switch (direction) {
        case kDirectionUp:
            moveNodeUp = [SKAction moveByX:0 y:68.0 duration:0.05];
            break;
        case kDirectionDown:
            moveNodeUp = [SKAction moveByX:0 y:-68.0 duration:0.05];
            break;
        case kDirectionLeft:
            moveNodeUp = [SKAction moveByX:-68.0 y:0 duration:0.05];
            break;
        case kDirectionRight:
            moveNodeUp = [SKAction moveByX:68.0 y:0 duration:0.05];
            break;
        default:
            break;
    }*/
}

@end

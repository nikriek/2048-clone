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
            BOOL shouldBreak = NO;
            for (int y = 0; y < 4; y++) {
                CGFloat xCoordinate = (CGFloat)x;
                CGFloat yCoordinate = (CGFloat)y;
                CGPoint position = [self positionForTileWithCoordinates:CGPointMake(xCoordinate, yCoordinate)];
                if ([tileMatrix tileAtCoordinates:CGPointMake(xCoordinate, yCoordinate)] == nil) {
                    NRTile *tile = [[NRTile alloc] initFrontWithPosition:position];
                    [tile setCurrentValue:2];
                    [tileMatrix insertTile:tile atCoordinates:CGPointMake(xCoordinate, yCoordinate)];
                    [self addChild:tile];
                    shouldBreak = YES;
                    break;
                }
            }
            if (shouldBreak == YES) {
                break;
            }
        }
    }
}

-(void)moveTile:(NRTile*)tile toPosition:(CGPoint)newPosition {
    CGPoint oldPosition = [tileMatrix coordinatesOfTile:tile];
    if (oldPosition.x != -1.0) {
        SKAction *moveAction;
        CGSize delta = [self deltaForCoordinates:oldPosition andCoordinates:newPosition];
        moveAction = [SKAction moveByX:delta.width y:delta.height duration:0.1];
        [tile runAction: moveAction];
    }
    
}

-(void)performedSwipeGestureInDirection:(Direction)direction {

    /*
    switch (direction) {
        case kDirectionUp:
            for (int y = 2; y >= 0; y--) {
                for (int x = 0; x < 4; x++) {
                    NRTile *tile= [tileMatrix tileAtCoordinates:CGPointMake(x, y)];
                    if (tile != nil) {
                        for (int i = 3; i >= 0; i--) {
                            NRTile *otherTile = [tileMatrix tileAtCoordinates:CGPointMake(x, i)];
                            if (ot) {
                                <#statements#>
                            }
                        }
                    }
                }
            }
            break;
        case kDirectionDown:
            for (int y = 1; y < 4; y++) {
                for (int x = 0; x < 4; x++) {
                    
                }
            }
            break;
        case kDirectionLeft:
            for (int x = 1; x < 4; x++) {
                for (int y = 0; y < 4; y++) {
                    
                }
            }
            break;
        case kDirectionRight:
            for (int x = 2; x >= 0 ; x--) {
                for (int y = 0; y < 4; y++) {
                    
                }
            }
            break;
            
        default:
            break;
    }
    [self setNewTileAtRandomPosition];*/
}

@end

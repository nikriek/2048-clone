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
#import "SoundPlayer.h"

//@implementation NRTileMap {
//    NRTileMatrix *tileMatrix;
//}

@synthesize finishedGameBlock;

- (instancetype)init
{
    self = [super init];
    if (self) {
//        tileMatrix = [NRTileMatrix new];
    }
    return self;
}

-(void)setNewTileAtRandomPosition {
    
    srand (time(NULL));
    
    //Determine Random Coordinates
    CGFloat randXCoordinate;
    CGFloat randYCoordinate;
    do {
        randXCoordinate = 2;
        randYCoordinate = 2;
//        randXCoordinate = (CGFloat)(rand() %  4);
//        randYCoordinate = (CGFloat)(rand() %  4);
    
    } while ([tileMatrix tileAtCoordinates:CGPointMake(randXCoordinate, randYCoordinate)] != nil);
    NRTile *test = [tileMatrix tileAtCoordinates:CGPointMake(randXCoordinate, randYCoordinate)];
    
    //Determine whether "2" or "4" is created
    NSInteger randValue;
    BOOL probability = rand() % 10;
    if (probability < 9)
        randValue = 2;
    else
        randValue = 4;
    
    //Create new random Tile with random Coordinates and Value
    CGPoint position = [self positionForTileWithCoordinates:CGPointMake(randXCoordinate, randYCoordinate)];
    NRTile *tile = [[NRTile alloc] initFrontWithPosition:position];
    [tile setCurrentValue:randValue];
    [tileMatrix insertTile:tile atCoordinates:CGPointMake(randXCoordinate, randYCoordinate)];
    [self addChild:tile];
}

-(void)moveTile:(NRTile*)tile toPosition:(CGPoint)newPosition {
    CGPoint oldPosition = [self.tileMatrix coordinatesOfTile:tile];
    if (oldPosition.x != -1.0 && [NRTileMatrix coordinatesInRightRange:newPosition]) {
        [tileMatrix moveTile:tile from:oldPosition to:newPosition];
        SKAction *moveAction;
        CGSize delta = [self deltaForCoordinates:oldPosition andCoordinates:newPosition];
        moveAction = [SKAction moveByX:delta.width y:delta.height duration:0.1];
        [tile runAction: moveAction];
    }
}

-(void)performedSwipeGestureInDirection:(Direction)direction {
    [self runAction:[SKAction playSoundFileNamed:[SoundPlayer soundNameOfType:kSwipe] waitForCompletion:NO]];
    for (NRTile *tile in self.children) {
        [self moveTile:tile toPosition:CGPointMake(0.0, 3.0)];
    }
    finishedGameBlock(NO,2048);
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
     */
    [self setNewTileAtRandomPosition];
}

@end

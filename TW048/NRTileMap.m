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

@implementation NRTileMap {
    NRTileMatrix *tileMatrix;
}

@synthesize finishedGameBlock;

- (instancetype)init
{
    self = [super init];
    if (self) {
       tileMatrix = [NRTileMatrix new];
    }
    return self;
}

-(void)setNewTileAtRandomFreePosition {
    NSMutableArray *freePositions = [NSMutableArray new];
    for (int i = 0; i < tileMatrix.matrixArray.count; i++) {
        if ([tileMatrix.matrixArray objectAtIndex:i] == [NSNull null]) {
            [freePositions addObject:[NSNumber numberWithInt:i]];
        }
    }
    int randomIndex = arc4random() % freePositions.count;
    if (freePositions.count != 0) {
        NSNumber *randomIndexNumber = [freePositions objectAtIndex:randomIndex];
        CGFloat yCoordinate = (CGFloat)([randomIndexNumber integerValue] % 4);
        CGFloat xCoordinate = ((CGFloat)[randomIndexNumber integerValue] - yCoordinate) / 4.0;
        CGPoint coordinates = CGPointMake(xCoordinate, yCoordinate);
        CGPoint position = [self positionForTileWithCoordinates:coordinates];
        NRTile *tile = [[NRTile alloc] initFrontWithPosition:position];
        
        // Generate Random Value
        NSInteger currentValue;
        int randomValueProability = arc4random() % 10;
        if (randomValueProability == 0) {
            currentValue = 4;
        } else {
            currentValue = 2;
        }
        
        [tile setCurrentValue:currentValue];
        [tileMatrix insertTile:tile atCoordinates:CGPointMake(xCoordinate, yCoordinate)];
        [self addChild:tile];
    }
}

-(void)moveTile:(NRTile*)tile toPosition:(CGPoint)newPosition {
    CGPoint oldPosition = [tileMatrix coordinatesOfTile:tile];
    if (oldPosition.x != -1.0 && [NRTileMatrix coordinatesInRightRange:newPosition]) {
        [tileMatrix moveTile:tile from:oldPosition to:newPosition];
        SKAction *moveAction;
        CGSize delta = [self deltaForCoordinates:oldPosition andCoordinates:newPosition];
        moveAction = [SKAction moveByX:delta.width y:delta.height duration:0.1];
        [tile runAction: moveAction];
    }
}

-(void)performedSwipeGestureInDirection:(UISwipeGestureRecognizerDirection)direction {
    //[self runAction:[SKAction playSoundFileNamed:[SoundPlayer soundNameOfType:kSwipe] waitForCompletion:NO]];
    
    
    //finishedGameBlock(NO,2048);
    
//    switch (direction) {
//        case kDirectionUp:
//            for (int y = 2; y >= 0; y--) {
//                for (int x = 0; x < 4; x++) {
//                    NRTile *tile= [tileMatrix tileAtCoordinates:CGPointMake(x, y)];
//                    if (tile != nil) {
//                        for (int i = 3; i >= 0; i--) {
//                            NRTile *otherTile = [tileMatrix tileAtCoordinates:CGPointMake(x, i)];
//                            if (ot) {
//                                <#statements#>
//                            }
//                        }
//                    }
//                }
//            }
//            break;
//        case kDirectionDown:
//            for (int y = 1; y < 4; y++) {
//                for (int x = 0; x < 4; x++) {
//                    
//                }
//            }
//            break;
//        case kDirectionLeft:
//            for (int x = 1; x < 4; x++) {
//                for (int y = 0; y < 4; y++) {
//                    
//                }
//            }
//            break;
//        case kDirectionRight:
//            for (int x = 2; x >= 0 ; x--) {
//                for (int y = 0; y < 4; y++) {
//                    
//                }
//            }
//            break;
//            
//        default:
//            break;
//    }
    
    [self setNewTileAtRandomFreePosition];

}

@end

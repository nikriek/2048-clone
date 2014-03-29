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
    
    CGVector oneUp           ;
    CGVector oneToTheRight   ;
    CGVector oneDown         ;
    CGVector oneToTheLeft    ;
    CGVector noDirection     ;
}

@synthesize finishedGameBlock;

- (instancetype)init
{
    self = [super init];
    if (self) {
       tileMatrix = [NRTileMatrix new];
        
        oneUp           = CGVectorMake(0.0, 1.0);
        oneToTheRight   = CGVectorMake(1.0, 0.0);
        oneDown         = CGVectorMake(0.0, -1.0);
        oneToTheLeft    = CGVectorMake(-1.0, 0.0);
        noDirection     = CGVectorMake(0.0, 0.0);
    }
    return self;
}

#pragma mark Making a turn

-(void)performedSwipeGestureInDirection:(UISwipeGestureRecognizerDirection)sDirection {
    
    //Play Sound
    [self runAction:[SKAction playSoundFileNamed:[SoundPlayer soundNameOfType:kSwipe] waitForCompletion:NO]];
    
    //    finishedGameBlock(NO,2048);
    BOOL shouldSetRandomTileAtTheEndOfTurn = NO;
    [tileMatrix resetHasJustBeenCombinedTags];
    
    
    
    
    //Set up the Loop
    NRTile *currentTile;
    CGVector vDirection = [self createUnitVectorFromSwipeDirection:sDirection];
    CGVector rectangularDirection = [self clockwiseDirectionOf:vDirection];
    CGVector oppositeDirection = [self oppositeDirectionOf:vDirection];
    
    // a CGPoint pointing at the current position in the Matrix
    CGPoint runningPointer = CGPointMake(0.0, 0.0);
    // Set one ordinate (x or y) to the value the loop should start from
    runningPointer = [self resetOneOrdinateOfPoint:runningPointer forDirection:oppositeDirection];
    // Set the other ordinate (y or x).
    // Because the direction is rectangular to the previous one, the second ordinate is definetely the counterpart of the first.
    runningPointer = [self resetOneOrdinateOfPoint:runningPointer forDirection:rectangularDirection];
    
    //Start loop
    while ([self coordinatesInRightRange:runningPointer]) {
        while ([self coordinatesInRightRange:runningPointer]) {
            //Put Code in here ***************************************
            {
                currentTile = [tileMatrix tileAtCoordinates:runningPointer];
                if ([self tile:currentTile isMovableOneFieldIntoDirection:vDirection] && currentTile != nil)
                    shouldSetRandomTileAtTheEndOfTurn = YES;
                while ([self tile:currentTile isMovableOneFieldIntoDirection:vDirection] && currentTile != nil) {
                    [self moveTile:currentTile oneFieldIntoDirection:vDirection];
                }
                
            }
            // *******************************************************
            runningPointer = [self translatePoint:runningPointer intoDirection:oppositeDirection];
        }
        runningPointer = [self resetOneOrdinateOfPoint:runningPointer forDirection:oppositeDirection];
        
        runningPointer = [self translatePoint:runningPointer intoDirection:rectangularDirection];
    } //End loop
    
    if (shouldSetRandomTileAtTheEndOfTurn)
        [self setNewTileAtRandomFreePosition];
    
}

#pragma mark Game Actions

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
        
        // Generate Random Value
        NSInteger currentValue;
        int randomValueProability = arc4random() % 10;
        if (randomValueProability == 0) {
            currentValue = 4;
        } else {
            currentValue = 2;
        }
        
        NRTile *randomTile = [[NRTile alloc] initFrontWithCoordinates:coordinates];
        [randomTile setValue:currentValue];
        [tileMatrix insertTile:randomTile atCoordinates:coordinates];
        [self addChild:randomTile];
        
    }
}

-(void)moveTile:(NRTile*)tile oneFieldIntoDirection:(CGVector)vDirection {
    
    CGPoint oldCoordinates = tile.coordinates;
    CGPoint newCoordinates = [self translatePoint:oldCoordinates intoDirection:vDirection];
    
    if (    [tileMatrix tileAtCoordinates:newCoordinates] != nil
        &&  [tileMatrix tileAtCoordinates:newCoordinates].value == tile.value
        &&  [self coordinatesInRightRange:[self translatePoint:oldCoordinates intoDirection:vDirection]])
    {
        int doubledValue = tile.value * 2;
        
        [[tileMatrix tileAtCoordinates:newCoordinates] removeFromParent];
        [tileMatrix removeTileAtCoordinates:newCoordinates];
        [[tileMatrix tileAtCoordinates:oldCoordinates] removeFromParent];
        [tileMatrix removeTileAtCoordinates:oldCoordinates];
        
        NRTile *combinedTile = [[NRTile alloc] initFrontWithCoordinates:newCoordinates];
        [combinedTile setValue:doubledValue];
        [tileMatrix insertTile:combinedTile atCoordinates:newCoordinates];
        [self addChild:combinedTile];
    } else {
        [tileMatrix moveTile:tile to:vDirection];
    }
    
    
    // Run animation
    CGVector distance = [NRTile distanceForVector:vDirection];
    SKAction *moveAction = [SKAction moveByX:distance.dx y:distance.dy duration:0.1];
    [tile runAction: moveAction];
}
-(BOOL)tile:(NRTile*)tile isMovableOneFieldIntoDirection:(CGVector)direction {
    
    CGPoint newCoordinates = [self translatePoint:tile.coordinates intoDirection:direction];
    
    
    if (        [self coordinatesInRightRange:newCoordinates]
        &&      ([tileMatrix tileAtCoordinates:newCoordinates]        == nil
        ||       ([tileMatrix tileAtCoordinates:newCoordinates].value  == tile.value
        &&          [tileMatrix tileAtCoordinates:newCoordinates].hasJustBeenCombined == NO)))
    { return YES;}
    
    return NO;
}
-(CGPoint)resetOneOrdinateOfPoint:(CGPoint)point forDirection:(CGVector)direction {

    if ([self direction1:direction equalsToDirection2:oneUp])
        return CGPointMake(point.x, 0.0);
    if ([self direction1:direction equalsToDirection2:oneDown])
        return CGPointMake(point.x, 3.0);
    if ([self direction1:direction equalsToDirection2:oneToTheRight])
        return CGPointMake(0.0, point.y);
    if ([self direction1:direction equalsToDirection2:oneToTheLeft])
        return CGPointMake(3.0, point.y);
    return CGPointMake(0.0, 0.0);
    
}
- (BOOL)coordinatesInRightRange:(CGPoint)coordinates {
    return
    coordinates.x <= 3.0 &&
    coordinates.x >= 0 &&
    coordinates.y <= 3.0 &&
    coordinates.y >= 0;
}

#pragma mark Basic Vector Methods

-(CGVector)createUnitVectorFromSwipeDirection:(UISwipeGestureRecognizerDirection)sDirection {
    if (sDirection == UISwipeGestureRecognizerDirectionUp)
        return oneUp;
    if (sDirection == UISwipeGestureRecognizerDirectionRight)
        return oneToTheRight;
    if (sDirection == UISwipeGestureRecognizerDirectionDown)
        return oneDown;
    if (sDirection == UISwipeGestureRecognizerDirectionLeft)
        return oneToTheLeft;
    return noDirection;
}
-(CGVector)oppositeDirectionOf:(CGVector)vDirection {
    return CGVectorMake(-vDirection.dx, -vDirection.dy);
}
-(CGVector)clockwiseDirectionOf:(CGVector)vDirection {

    if ([self direction1:vDirection equalsToDirection2:oneUp])
        return oneToTheRight;
    if ([self direction1:vDirection equalsToDirection2:oneToTheRight])
        return oneDown;
    if ([self direction1:vDirection equalsToDirection2:oneDown])
        return oneToTheLeft;
    if ([self direction1:vDirection equalsToDirection2:oneToTheLeft])
        return oneUp;
    return noDirection;
}
-(CGPoint)translatePoint:(CGPoint)point intoDirection:(CGVector)vDirection {
    return CGPointMake(point.x + vDirection.dx, point.y + vDirection.dy);
}
-(BOOL)direction1:(CGVector)vDirection1 equalsToDirection2:(CGVector)vDirection2 {
    if (vDirection1.dx == vDirection2.dx && vDirection1.dy == vDirection2.dy)
        return TRUE;
    return FALSE;
}

@end


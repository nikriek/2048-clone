//
//  NRMapTile.m
//  TW048
//
//  Created by Niklas Riekenbrauck on 21.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck & Georg Zänker. All rights reserved.
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

#pragma mark Making a turn

-(CGVector)createUnitVectorDirectionFromSwipeDirection:(UISwipeGestureRecognizerDirection)sDirection {
    if (sDirection == UISwipeGestureRecognizerDirectionUp)
        return CGVectorMake(0, 1);
    if (sDirection == UISwipeGestureRecognizerDirectionRight)
        return CGVectorMake(1, 0);
    if (sDirection == UISwipeGestureRecognizerDirectionDown)
        return CGVectorMake(0, -1);
    if (sDirection == UISwipeGestureRecognizerDirectionLeft)
        return CGVectorMake(-1, 0);
    return CGVectorMake(0, 0);
}
-(void)performedSwipeGestureInDirection:(UISwipeGestureRecognizerDirection)sDirection {
    
    //Play Sound
    [self runAction:[SKAction playSoundFileNamed:[SoundPlayer soundNameOfType:kSwipe] waitForCompletion:NO]];
    
    //    finishedGameBlock(NO,2048);
    BOOL shouldSetRandomTileAtTheEndOfTurn = NO;
    [tileMatrix resetHasJustBeenCombinedTags];
    
    //Set up the Loop
    NRTile *currentTile;
    CGVector vDirection = [self createUnitVectorDirectionFromSwipeDirection:sDirection];
    CGVector rectangularDirection = [NRTile clockwiseDirectionOf:vDirection];
    CGVector oppositeDirection = [NRTile oppositeDirectionOf:vDirection];
    
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
            runningPointer = [NRTile translatePoint:runningPointer intoDirection:oppositeDirection];
        }
        runningPointer = [self resetOneOrdinateOfPoint:runningPointer forDirection:oppositeDirection];
        
        runningPointer = [NRTile translatePoint:runningPointer intoDirection:rectangularDirection];
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
    CGPoint newCoordinates = [NRTile translatePoint:oldCoordinates intoDirection:vDirection];
    
    //Check whether the Block is combinable
    if ([tileMatrix tileAtCoordinates:newCoordinates].value == tile.value) {
        int doubledValue = tile.value * 2;
        
        //Remove both tiles and create a new one
        [[tileMatrix tileAtCoordinates:newCoordinates] removeFromParent];
        [tileMatrix removeTileAtCoordinates:newCoordinates];
        [[tileMatrix tileAtCoordinates:oldCoordinates] removeFromParent];
        [tileMatrix removeTileAtCoordinates:oldCoordinates];
        
        NRTile *combinedTile = [[NRTile alloc] initFrontWithCoordinates:newCoordinates];
        [combinedTile setValue:doubledValue];
        [tileMatrix insertTile:combinedTile atCoordinates:newCoordinates];
        [self addChild:combinedTile];
        
    } else {
        //Else make a normal move
        [tileMatrix moveTile:tile to:vDirection];
    }
    
    // Run animation
    CGVector distance = [NRTile distanceForVector:vDirection];
    SKAction *moveAction = [SKAction moveByX:distance.dx y:distance.dy duration:0.1];
    [tile runAction: moveAction];
}
-(BOOL)tile:(NRTile*)tile isMovableOneFieldIntoDirection:(CGVector)vDirection {
    
    CGPoint newCoordinates = [NRTile translatePoint:tile.coordinates intoDirection:vDirection];
    
    if (        [self coordinatesInRightRange:newCoordinates]
        &&      ([tileMatrix tileAtCoordinates:newCoordinates]        == nil
        ||       ([tileMatrix tileAtCoordinates:newCoordinates].value  == tile.value
        &&          [tileMatrix tileAtCoordinates:newCoordinates].hasJustBeenCombined == NO)))
        return YES;
    return NO;
}
- (BOOL)coordinatesInRightRange:(CGPoint)coordinates {
    return
    coordinates.x <= 3.0 &&
    coordinates.x >= 0 &&
    coordinates.y <= 3.0 &&
    coordinates.y >= 0;
}
-(CGPoint)resetOneOrdinateOfPoint:(CGPoint)point forDirection:(CGVector)vDirection {
    if (vDirection.dy > 0)
        return CGPointMake(point.x, 0.0);
    if (vDirection.dy < 0)
        return CGPointMake(point.x, 3.0);
    if (vDirection.dx > 0)
        return CGPointMake(0.0, point.y);
    if (vDirection.dx < 0)
        return CGPointMake(3.0, point.y);
    return CGPointMake(0.0, 0.0);
}

@end


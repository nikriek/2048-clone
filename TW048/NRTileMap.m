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

-(void)createTwoTestTilesAtCoordinates:(CGPoint)coordinates1 and:(CGPoint)coordinates2 {
    
    NRTile *tile1 = [[NRTile alloc] initFrontWithCoordinates:coordinates1];
    [tile1 setValue:tile1.value];
    [tileMatrix insertTile:tile1 atCoordinates:coordinates1];
    [self addChild:tile1];

    
    
    
    NRTile *tile2 = [[NRTile alloc] initFrontWithCoordinates:coordinates2];
    [tile2 setValue:tile2.value];
    
    [tileMatrix insertTile:tile2 atCoordinates:coordinates2];
    
    [self addChild:tile2];
    NRTile *testTile = [tileMatrix tileAtCoordinates:coordinates2];
    
    
}

-(void)moveTile:(NRTile*)tile oneFieldIntoDirection:(CGVector)direction {
    
    
    
    CGPoint oldCoordinates = tile.coordinates;
    CGPoint newCoordinates = [self shiftPoint:newCoordinates oneUnitWithDirection:direction];
    
//    if ([tileMatrix tileAtCoordinates:newCoordinates] != nil && [tileMatrix tileAtCoordinates:newCoordinates].value == tile.value) {
//        int doubledValue = tile.value * 2;
//        
//        [[tileMatrix tileAtCoordinates:newCoordinates] removeFromParent];
//        [tileMatrix removeTileAtCoordinates:newCoordinates];
//        [[tileMatrix tileAtCoordinates:oldCoordinates] removeFromParent];
//        [tileMatrix removeTileAtCoordinates:oldCoordinates];
//        
//        NRTile *combinedTile = [[NRTile alloc] initFrontWithPosition:[self positionForTileWithCoordinates:newCoordinates]];
//        [combinedTile setValue:doubledValue];
//        [tileMatrix insertTile:combinedTile atCoordinates:newCoordinates];
//        [self addChild:combinedTile];
//    }
    
    
    
    
    if ([NRTileMatrix coordinatesInRightRange:[self shiftPoint:oldCoordinates oneUnitWithDirection:direction]]) {
        [tileMatrix moveTile:tile to:direction];
        SKAction *moveAction;
        
        CGVector distance = [self distanceForVector:direction];
        moveAction = [SKAction moveByX:distance.dx y:distance.dy duration:0.1];
        
        [tile runAction: moveAction];
    }
    
    
    
    
    
    
    
    
}
-(BOOL)tile:(NRTile*)tile isMovableOneFieldIntoDirection:(CGVector)direction {
    
    CGPoint newCoordinates = [self shiftPoint:tile.coordinates oneUnitWithDirection:direction];
    
    
    if (        [NRTileMatrix coordinatesInRightRange:newCoordinates]
        &&      ([tileMatrix tileAtCoordinates:newCoordinates]        == nil
        /*||       [tileMatrix tileAtCoordinates:newCoordinates].value  == tile.value*/))
    { return YES;}
    
    return NO;
}



-(void)performedSwipeGestureInDirection:(UISwipeGestureRecognizerDirection)sDirection {
   
    //Play Sound
//    [self runAction:[SKAction playSoundFileNamed:[SoundPlayer soundNameOfType:kSwipe] waitForCompletion:NO]];

//    finishedGameBlock(NO,2048);
    BOOL shouldSetRandomTileAtTheEndOfTurn = NO;


    

    
    NRTile *currentTile;
    CGVector vDirection = [self createVectorDirectionFromSwipeDirection:sDirection];
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
    while ([NRTileMatrix coordinatesInRightRange:runningPointer]) {
        while ([NRTileMatrix coordinatesInRightRange:runningPointer]) {
            //Put Code in here ***************************************
            {
                currentTile = [tileMatrix tileAtCoordinates:runningPointer];
                CGPoint testCoordinates = currentTile.coordinates;
                if ([self tile:currentTile isMovableOneFieldIntoDirection:vDirection] && currentTile != nil)
                    shouldSetRandomTileAtTheEndOfTurn = YES;
                while ([self tile:currentTile isMovableOneFieldIntoDirection:vDirection] && currentTile != nil) {
                    bool testBool = [self tile:currentTile isMovableOneFieldIntoDirection:vDirection];
                    [self moveTile:currentTile oneFieldIntoDirection:vDirection];
                }
                
            }
            // *******************************************************
            runningPointer = [self shiftPoint:runningPointer oneUnitWithDirection:oppositeDirection];
        }
        runningPointer = [self resetOneOrdinateOfPoint:runningPointer forDirection:oppositeDirection];
        
        runningPointer = [self shiftPoint:runningPointer oneUnitWithDirection:rectangularDirection];
    } //End loop
    
//    [self setNewTileAtRandomFreePosition];
    
}

-(CGVector)createVectorDirectionFromSwipeDirection:(UISwipeGestureRecognizerDirection)sDirection {
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
-(CGVector)clockwiseDirectionOf:(CGVector)direction {

    if ([self direction1:direction equalsToDirection2:oneUp])
        return oneToTheRight;
    if ([self direction1:direction equalsToDirection2:oneToTheRight])
        return oneDown;
    if ([self direction1:direction equalsToDirection2:oneDown])
        return oneToTheLeft;
    if ([self direction1:direction equalsToDirection2:oneToTheLeft])
        return oneUp;
    return noDirection;
}
-(CGVector)oppositeDirectionOf:(CGVector)direction {
    return [self clockwiseDirectionOf:[self clockwiseDirectionOf:direction]];
}
-(BOOL)direction1:(CGVector)direction1 equalsToDirection2:(CGVector)direction2 {
    if (direction1.dx == direction2.dx && direction1.dy == direction2.dy)
        return TRUE;
    return FALSE;
}
-(CGPoint)shiftPoint:(CGPoint)point oneUnitWithDirection:(CGVector)direction {
    return CGPointMake(point.x + direction.dx, point.y + direction.dy);
}


-(CGPoint)positionForCoordinates:(CGPoint)coordinates {
    CGFloat xCoordinate = 8.0 + coordinates.x * 8.0 + coordinates.x * 60.0;
    CGFloat yCoordinate = 8.0 + coordinates.y * 8.0 + coordinates.y * 60.0;;
    return CGPointMake(xCoordinate, yCoordinate);
}
-(CGVector)distanceForVector:(CGVector)vector {
    CGFloat dx = vector.dx * 8.0 + vector.dx * 60.0;
    CGFloat dy = vector.dy * 8.0 + vector.dy * 60.0;;
    return CGVectorMake(dx, dy);
}

@end

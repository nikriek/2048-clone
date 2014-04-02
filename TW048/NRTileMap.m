//
//  NRMapTile.m
//  TW048
//
//  Created by Niklas Riekenbrauck on 21.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck & Georg Zänker. All rights reserved.
//

#import "NRTileMap.h"
#import "NRTile.h"
#import "SoundPlayer.h"

@implementation NRTileMap

-(void)setUpNewGame {

    [self removeAllChildren];
    self.gameData = [[GZGameData alloc] initDefault];
    
    [self setNewTileAtRandomFreePosition];
    [self setNewTileAtRandomFreePosition];
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
//    [self runAction:[SKAction playSoundFileNamed:[SoundPlayer soundNameOfType:kSwipe] waitForCompletion:NO]];
    
    
    //Game Information Setup
    BOOL shouldSetRandomTileAtTheEndOfTurn  = NO;
    
    [self.gameData.tileMatrix resetHasJustBeenCombinedTagsOfTiles];
    
    //Loop Setup
    CGVector vDirection             = [self createUnitVectorDirectionFromSwipeDirection:sDirection];
    CGVector rectangularDirection   = [NRTile clockwiseDirectionOf:vDirection];
    CGVector oppositeDirection      = [NRTile oppositeDirectionOf:vDirection];
    
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
                NRTile *currentTile = [self.gameData.tileMatrix tileAtCoordinates:runningPointer];
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
    
    
    
    //*************Actions at the End Of Turn**************
    //Update Score
    self.newScoreBlock(self.gameData.score, 4);
    //Random Tile?
    if (shouldSetRandomTileAtTheEndOfTurn)
        [self setNewTileAtRandomFreePosition];
    //Do Gameover Checks
    if ([self noFurtherTurnPossible])
        self.gameLostBlock(self.gameData.score);
    if (self.gameData.gameWon)
        self.gameWonBlock(self.gameData.score, self.gameData.gameWonType);
}

#pragma mark Game Actions

-(void)setNewTileAtRandomFreePosition {
    
    NSMutableArray *freePositions = [NSMutableArray new];
    for (int i = 0; i < self.gameData.tileMatrix.matrixArray.count; i++) {
        if ([self.gameData.tileMatrix.matrixArray objectAtIndex:i] == [NSNull null]) {
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
        [self.gameData.tileMatrix insertTile:randomTile atCoordinates:coordinates];
        [self addChild:randomTile];
    }
}
-(void)moveTile:(NRTile*)tile oneFieldIntoDirection:(CGVector)vDirection {
    
    CGPoint oldCoordinates = tile.coordinates;
    CGPoint newCoordinates = [NRTile translatePoint:oldCoordinates intoDirection:vDirection];
    
    //Check whether the Block is combinable
    if ([self.gameData.tileMatrix tileAtCoordinates:newCoordinates].value == tile.value) {
        int doubledValue = tile.value * 2;
        
        //Remove both tiles and create a new one
        [[self.gameData.tileMatrix tileAtCoordinates:newCoordinates] removeFromParent];
        [self.gameData.tileMatrix removeTileAtCoordinates:newCoordinates];
        [[self.gameData.tileMatrix tileAtCoordinates:oldCoordinates] removeFromParent];
        [self.gameData.tileMatrix removeTileAtCoordinates:oldCoordinates];
        
        NRTile *combinedTile = [[NRTile alloc] initFrontWithCoordinates:newCoordinates];
        [combinedTile setValue:doubledValue];
        [self.gameData.tileMatrix insertTile:combinedTile atCoordinates:newCoordinates];
        [self addChild:combinedTile];
        
        //Update Score
        self.gameData.score += combinedTile.value;
        
        //Check whether the winning Tile was created
        if (combinedTile.value == self.gameData.gameWonType) {
            self.gameData.gameWon = YES;
            self.gameData.gameWonType *= 2;
        }
        
    } else {
        //Else make a normal move
        [self.gameData.tileMatrix moveTile:tile to:vDirection];
    }
    
    // Run animation
    CGVector distance = [NRTile distanceForVector:vDirection];
    SKAction *moveAction = [SKAction moveByX:distance.dx y:distance.dy duration:0.1];
    [tile runAction: moveAction];
}
-(BOOL)tile:(NRTile*)tile isMovableOneFieldIntoDirection:(CGVector)vDirection {
    
    CGPoint newCoordinates = [NRTile translatePoint:tile.coordinates intoDirection:vDirection];
    
    if (        [self coordinatesInRightRange:newCoordinates]
        &&      ([self.gameData.tileMatrix tileAtCoordinates:newCoordinates]        == nil
        ||       ([self.gameData.tileMatrix tileAtCoordinates:newCoordinates].value  == tile.value
        &&          [self.gameData.tileMatrix tileAtCoordinates:newCoordinates].hasJustBeenCombined == NO)))
        return YES;
    return NO;
}
-(BOOL)coordinatesInRightRange:(CGPoint)coordinates {
    return
    coordinates.x <= 3.0 &&
    coordinates.x >= 0 &&
    coordinates.y <= 3.0 &&
    coordinates.y >= 0;
}
-(BOOL)noFurtherTurnPossible {
    if ([self.gameData.tileMatrix isFullWithTiles]) {
        
        NRTile *currentTile;
        CGVector vDirection = CGVectorMake(1, 0);
        
        for (int x = 0; x < 4; x++) {
        for (int y = 0; y < 4; y++) {
        for (int directionCount = 0; directionCount < 4; directionCount++) {
            currentTile = [self.gameData.tileMatrix tileAtCoordinates:CGPointMake((float)x, (float)y)];
            if ([self tile:currentTile isMovableOneFieldIntoDirection:vDirection])
                    return NO;
            vDirection = [NRTile clockwiseDirectionOf:vDirection];
        }
        }
        }
        return YES;
    }
    return NO;
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

#pragma mark Test Methods
//Do not delete before shipping to the Appstore!!!
-(void)insertTestTileWithCoordinates:(CGPoint)coordinates andValue:(NSInteger)value {
    NRTile *testTile = [[NRTile alloc] initBackWithCoordinates:coordinates];
    [testTile setValue:value];
    [self.gameData.tileMatrix insertTile:testTile atCoordinates:coordinates];
    [self addChild:testTile];
}

@end


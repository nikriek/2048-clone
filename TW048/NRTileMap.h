//
//  NRMapTile.h
//  TW048
//
//  Created by Niklas Riekenbrauck on 21.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "NRBackgroundMap.h"


typedef struct Direction Direction;

typedef void (^NewScoreBlock)(NSInteger newScore, NSInteger offset);
typedef void (^FinishedGameBlock)(BOOL success,NSInteger score);

@interface NRTileMap : NRBackgroundMap

-(void)setNewTileAtRandomFreePosition;
-(void)createTwoTestTilesAtPositions:(CGPoint)position1 and:(CGPoint)position2;


-(void)performedSwipeGestureInDirection:(UISwipeGestureRecognizerDirection)sDirection;

@property (nonatomic, copy) NewScoreBlock newScoreBlock;
@property (nonatomic, copy) FinishedGameBlock finishedGameBlock;

@end

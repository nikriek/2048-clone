//
//  NRMapTile.h
//  TW048
//
//  Created by Niklas Riekenbrauck on 21.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck & Georg Zänker. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GZGameData.h"


typedef void (^NewScoreBlock)(NSInteger newScore, NSInteger offset);

typedef void (^GameLostBlock)(NSInteger score);
typedef void (^GameWonBlock) (NSInteger score, NSInteger winType);

@interface NRTileMap : SKNode

-(void)setUpNewGame;
-(void)performedSwipeGestureInDirection:(UISwipeGestureRecognizerDirection)sDirection;

@property (nonatomic, copy) NewScoreBlock newScoreBlock;

@property (nonatomic, copy) GameLostBlock gameLostBlock;
@property (nonatomic, copy) GameWonBlock gameWonBlock;

@property (nonatomic, retain) GZGameData *gameData;

#pragma mark Test Methods
//Do not delete before shipping to the Appstore!!!
-(void)insertTestTileWithCoordinates:(CGPoint)coordinates andValue:(NSInteger)value;

@end

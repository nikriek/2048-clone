//
//  NRTileMatrix.h
//  TW048
//
//  Created by Niklas Riekenbrauck on 22.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck & Georg Zänker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NRTile.h"

@interface NRTileMatrix : NSObject

@property (nonatomic,retain) NSMutableArray *matrixArray;

#pragma mark Insert, Remove and Move
-(void)insertTile:(NRTile*)tile atCoordinates:(CGPoint)coordinates;
-(void)removeTileAtCoordinates:(CGPoint)coordinates;
-(void)moveTile:(NRTile*)tile to:(CGVector)direction;

#pragma mark Array Related Methods
-(NSInteger)countOfTiles;
-(BOOL)isFullWithTiles;
-(NRTile*)tileAtCoordinates:(CGPoint)coordinates;

#pragma mark Resets
-(void)resetHasJustBeenCombinedTagsOfTiles;

@end

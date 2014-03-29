//
//  NRTileMatrix.h
//  TW048
//
//  Created by Niklas Riekenbrauck on 22.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NRTile.h"

@interface NRTileMatrix : NSObject

@property (nonatomic,retain) NSMutableArray *matrixArray;


-(NRTile*)tileAtCoordinates:(CGPoint)coordinates;

-(void)insertTile:(NRTile*)tile atCoordinates:(CGPoint)coordinates;

-(void)removeTileAtCoordinates:(CGPoint)coordinates;

-(NSInteger)countOfTiles;

-(void)moveTile:(NRTile*)tile to:(CGVector)direction;

+(BOOL)coordinatesInRightRange:(CGPoint)coordinates;

@end

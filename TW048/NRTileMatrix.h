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


-(NRTile*)tileAtCoordinates:(CGPoint)position;

-(void)insertTile:(NRTile*)tile atCoordinates:(CGPoint)position;

-(void)removeTileAtCoordinates:(CGPoint)position;

-(NSInteger)countOfTiles;

-(CGPoint)coordinatesOfTile:(NRTile*)tile;

-(void)moveTile:(NRTile*)tile from:(CGPoint)oldPosition to:(CGPoint)newPosition;

+(BOOL)coordinatesInRightRange:(CGPoint)coordinates;
@end

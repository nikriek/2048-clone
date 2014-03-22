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

-(NRTile*)tileAtPosition:(CGPoint)position;

-(void)insertTile:(NRTile*)tile atPosition:(CGPoint)position;

-(void)removeTileAtPosition:(CGPoint)position;

-(NSInteger)countOfTiles;

-(CGPoint)positionOfTile:(NRTile*)tile;

@end

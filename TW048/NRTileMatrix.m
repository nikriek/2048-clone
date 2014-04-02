//
//  NRTileMatrix.m
//  TW048
//
//  Created by Niklas Riekenbrauck on 22.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck & Georg Zänker. All rights reserved.
//

#import "NRTileMatrix.h"

@implementation NRTileMatrix

@synthesize matrixArray;

- (instancetype)init
{
    self = [super init];
    if (self) {
        matrixArray = [NSMutableArray new];
        for (int i = 0; i < 16; i++) {
            [matrixArray addObject:[NSNull null]];
        }
    }
    return self;
}

#pragma mark Insert, Remove and Move

-(void)insertTile:(NRTile*)tile atCoordinates:(CGPoint)newCoordinates {
    matrixArray[(NSInteger)newCoordinates.x * 4 + (NSInteger)newCoordinates.y] = tile;
    [self tileAtCoordinates:newCoordinates].coordinates = newCoordinates;
}
-(void)removeTileAtCoordinates:(CGPoint)coordinates {
    matrixArray[(NSInteger)coordinates.x * 4 + (NSInteger)coordinates.y] = [NSNull null];
}
-(void)moveTile:(NRTile*)oldTile to:(CGVector)direction {
    CGPoint oldCoordinates = oldTile.coordinates;
    CGPoint newCoordinates = [NRTile translatePoint:oldTile.coordinates intoDirection:direction];
    
    [self insertTile:oldTile atCoordinates:newCoordinates];
    [self removeTileAtCoordinates:oldCoordinates];
}

#pragma mark Array Related Methods

-(NSInteger)countOfTiles {
    NSInteger count = 0;
    for (id obj in matrixArray) {
        if ([obj isMemberOfClass:[NRTile class]]) {
            count++;
        }
    }
    return count;
}
-(BOOL)isFullWithTiles {
    if ([self countOfTiles] == 16)
        return YES;
    return NO;
}
-(NRTile*)tileAtCoordinates:(CGPoint)coordinates {
    
    id obj = matrixArray[(NSInteger)coordinates.x * 4 + (NSInteger)coordinates.y];
    if ([obj isMemberOfClass:[NRTile class]]) {
        return (NRTile*)obj;
    } else {
        return nil;
    }
    
}

#pragma mark Resets

-(void)resetHasJustBeenCombinedTagsOfTiles {
    NRTile *tempTile;
    for (int i = 0; i < matrixArray.count; i++) {
        if (matrixArray[i] != [NSNull null]) {
            tempTile = matrixArray[i];
            tempTile.hasJustBeenCombined = NO;
            matrixArray[i] = tempTile;
        }
    }
}

@end

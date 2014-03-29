//
//  NRTileMatrix.m
//  TW048
//
//  Created by Niklas Riekenbrauck on 22.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
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

#pragma mark - Tile matrix related methods

-(NRTile*)tileAtCoordinates:(CGPoint)coordinates {
    
    if ([NRTileMatrix coordinatesInRightRange:coordinates]) {
        id obj = matrixArray[(NSInteger)coordinates.x * 4 + (NSInteger)coordinates.y];
        if ([obj isMemberOfClass:[NRTile class]]) {
            return (NRTile*)obj;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
    
}

-(NSInteger)countOfTiles {
    NSInteger count = 0;
    for (id obj in matrixArray) {
        if ([obj isMemberOfClass:[NRTile class]]) {
            count++;
        }
    }
    return count;
}

-(void)insertTile:(NRTile*)tile atCoordinates:(CGPoint)newCoordinates {
    matrixArray[(NSInteger)newCoordinates.x * 4 + (NSInteger)newCoordinates.y] = tile;
    [self tileAtCoordinates:newCoordinates].coordinates = newCoordinates;
}
-(void)removeTileAtCoordinates:(CGPoint)coordinates {
    matrixArray[(NSInteger)coordinates.x * 4 + (NSInteger)coordinates.y] = [NSNull null];
}
-(void)moveTile:(NRTile*)oldTile to:(CGVector)direction {
    CGPoint oldCoordinates = oldTile.coordinates;
    CGPoint newCoordinates = [self shiftPoint:oldTile.coordinates oneUnitWithDirection:direction];
    
    [self insertTile:oldTile atCoordinates:newCoordinates];
    [self removeTileAtCoordinates:oldCoordinates];
}

+(BOOL)coordinatesInRightRange:(CGPoint)coordinates {
    return
        coordinates.x <= 3.0 &&
        coordinates.x >= 0 &&
        coordinates.y <= 3.0 &&
        coordinates.y >= 0;
}
-(CGPoint)shiftPoint:(CGPoint)point oneUnitWithDirection:(CGVector)direction {
    return CGPointMake(point.x + direction.dx, point.y + direction.dy);
}

@end

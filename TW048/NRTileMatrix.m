//
//  NRTileMatrix.m
//  TW048
//
//  Created by Niklas Riekenbrauck on 22.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "NRTileMatrix.h"

@implementation NRTileMatrix {
    NSMutableArray *tileMatrix;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        tileMatrix = [NSMutableArray new];
        for (int i = 0; i < 16; i++) {
            [tileMatrix addObject:[NSNull null]];
        }
    }
    return self;
}

#pragma mark - Tile matrix related methods

-(NRTile*)tileAtCoordinates:(CGPoint)position {
    
    if ([NRTileMatrix coordinatesInRightRange:position]) {
        id obj = tileMatrix[(NSInteger)position.x * 4 + (NSInteger)position.y];
        if ([obj isMemberOfClass:[NRTile class]]) {
            id test = obj;
            return (NRTile*)obj;
        } else {
            id test = nil;
            return nil;
        }
    } else {
        return nil;
    }
    
}

-(void)insertTile:(NRTile*)tile atCoordinates:(CGPoint)position {
    if ([NRTileMatrix coordinatesInRightRange:position]) {
        tileMatrix[(NSInteger)position.x * 4 + (NSInteger)position.y] = tile;
    }    
}

-(void)removeTileAtCoordinates:(CGPoint)position {
    if ([NRTileMatrix coordinatesInRightRange:position]) {
        tileMatrix[(NSInteger)position.x * 4 + (NSInteger)position.y] = [NSNull null];
    }
}

-(NSInteger)countOfTiles {
    NSInteger count = 0;
    for (id obj in tileMatrix) {
        if ([obj isMemberOfClass:[NRTile class]]) {
            count++;
        }
    }
    return count;
}

-(CGPoint)coordinatesOfTile:(NRTile*)tile {
    for (int i = 0; i < tileMatrix.count;i++) {
        NRTile *iTile = tileMatrix[i];
        if (iTile == tile) {
            CGFloat yCoordinate = (CGFloat)(i % 4);
            CGFloat xCoordinate = ((CGFloat)i - yCoordinate) / 4.0;
            return CGPointMake(xCoordinate, yCoordinate);
        }
    }
    return CGPointMake(-1.0, -1.0);;
}

-(void)moveTile:(NRTile*)tile from:(CGPoint)oldPosition to:(CGPoint)newPosition {
    if ([NRTileMatrix coordinatesInRightRange:newPosition]) {
        if (tile == [self tileAtCoordinates:oldPosition]) {
            [self insertTile:tile atCoordinates:newPosition];
            [self removeTileAtCoordinates:oldPosition];
        }
    }
}

+(BOOL)coordinatesInRightRange:(CGPoint)coordinates {
    return
        coordinates.x <= 3.0 &&
        coordinates.x >= 0 &&
        coordinates.y <= 3.0 &&
        coordinates.y >= 0;
}

@end

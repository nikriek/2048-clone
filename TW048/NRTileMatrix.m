//
//  NRTileMatrix.m
//  TW048
//
//  Created by Niklas Riekenbrauck on 22.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "NRTileMatrix.h"
#import "NRBackgroundMap.h"

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

-(NRTile*)tileAtPosition:(CGPoint)position {
    
    if ([NRTileMatrix positionInRightRange:position]) {
        id obj = matrixArray[(NSInteger)position.x * 4 + (NSInteger)position.y];
        if ([obj isMemberOfClass:[NRTile class]]) {
            return (NRTile*)obj;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
    
}

-(void)insertTile:(NRTile*)tile atPosition:(CGPoint)position {
    if ([NRTileMatrix positionInRightRange:position]) {
        matrixArray[(NSInteger)position.x * 4 + (NSInteger)position.y] = tile;
    }    
}

-(void)removeTileAtPosition:(CGPoint)position {
    
    if ([NRTileMatrix positionInRightRange:position]) {
        matrixArray[(NSInteger)position.x * 4 + (NSInteger)position.y] = [NSNull null];
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

-(CGPoint)positionOfTile:(NRTile*)tile {
    for (int i = 0; i < matrixArray.count;i++) {
        NRTile *iTile = matrixArray[i];
        if (iTile == tile) {
            CGFloat yCoordinate = (CGFloat)(i % 4);
            CGFloat xCoordinate = ((CGFloat)i - yCoordinate) / 4.0;
            return CGPointMake(xCoordinate, yCoordinate);
        }
    }
    return CGPointMake(-1.0, -1.0);;
}


-(void)moveTile:(NRTile*)tile from:(CGPoint)oldPosition to:(CGPoint)newPosition {
    if ([NRTileMatrix positionInRightRange:newPosition]) {
        if (tile == [self tileAtPosition:oldPosition]) {
            [self insertTile:tile atPosition:newPosition];
            [self removeTileAtPosition:oldPosition];
        }
    }
}

+(BOOL)positionInRightRange:(CGPoint)position {
    return
        position.x <= 3.0 &&
        position.x >= 0 &&
        position.y <= 3.0 &&
        position.y >= 0;
}

@end

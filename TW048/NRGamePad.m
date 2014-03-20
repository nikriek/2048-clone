//
//  NRGamePad.m
//  2048
//
//  Created by Niklas Riekenbrauck on 19.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "NRGamePad.h"
#import "NRTile.h"

static const NSInteger GAME_PAD_SIZE = 4;

@implementation NRGamePad {
    NSArray *tiles;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSMutableArray *row = [NSMutableArray new];
        for (int i = 0; i < GAME_PAD_SIZE; i++) {
            NSMutableArray *column = [NSMutableArray new];
            for (int i = 0; i < GAME_PAD_SIZE; i++) {
                
            }
            [row addObject:column];
        }
        tiles = row.copy;
    }
    return self;
}
-(void)swipedInDirection:(Direction)direction withScore:(void(^)(NSInteger newScore))score {
    //
    if (direction == kDirectionUp) {
        for (int x = 0 ; x < GAME_PAD_SIZE; x++) {
                for (int y = 1 ; y < GAME_PAD_SIZE; y++) {
                    if ([self tileAtPoint:CGPointMake(x, y)] != nil) {
                        NSInteger tempY = y;
                        NSInteger animationCounter = 0;
                        while (true) {
                            if ([self tileAtPoint:CGPointMake(x, tempY - 1)] == nil) {
                                animationCounter++;
                                [self addTile: [self tileAtPoint:CGPointMake(x, y)] atPosition:CGPointMake(x, tempY - 1)];
                            } else if ([self tileAtPoint:CGPointMake(x, tempY - 1)].currentValue ==
                                       [self tileAtPoint:CGPointMake(x, y)].currentValue){
                                animationCounter++;
                                [self combineTileAtPoint:CGPointMake(x, tempY - 1) withTileAtPoint:CGPointMake(x, y)];
                            } else {
                                break;
                            }
                        }
                    }
                    
                }
        }
    }
    
    // Generate new tile on random position
    while (YES) {
        NSUInteger xPosition = arc4random_uniform(GAME_PAD_SIZE);
        NSUInteger yPosition = arc4random_uniform(GAME_PAD_SIZE);
        if ([self tileAtPoint:CGPointMake(xPosition, yPosition)] == nil) {
            NRTile *tile = [NRTile new];
            tile.currentValue = 2;
            [self addTile:tile atPosition:CGPointMake(xPosition, yPosition)];
        } else {
            break;
        }
    }
}

-(void)combineTileAtPoint:(CGPoint)point1 withTileAtPoint:(CGPoint)point2 {
    NRTile *tile1 = [self tileAtPoint:point1];
    NRTile *tile2 = [self tileAtPoint:point2];
    tile1.currentValue += tile2.currentValue;
    [self removeTileAtPosition:point2];
}

-(void)removeTileAtPosition:(CGPoint)point {
    if ((NSInteger)point.x < GAME_PAD_SIZE &&
        (NSInteger)point.x >= 0 &&
        (NSInteger)point.y < GAME_PAD_SIZE &&
        (NSInteger)point.y >= 0)
    {
        tiles[(NSInteger)point.x][(NSInteger)point.y] = nil;
    }
}

-(void)addTile:(NRTile*)tile atPosition:(CGPoint)point {
    tiles[(NSInteger)point.x][(NSInteger)point.y] = tile;
}

-(NRTile*)tileAtPoint:(CGPoint)point {
    // Coordinates correspond to 2D-array position
    if ((NSInteger)point.x < GAME_PAD_SIZE &&
        (NSInteger)point.x >= 0 &&
        (NSInteger)point.y < GAME_PAD_SIZE &&
        (NSInteger)point.y >= 0)
    {
        return tiles[(NSInteger)point.x][(NSInteger)point.y];
    } else {
        return nil;
    }
}

@end

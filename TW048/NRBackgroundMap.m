//
//  NRMap.m
//  TW048
//
//  Created by Niklas Riekenbrauck on 21.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "NRBackgroundMap.h"
#import "NRTile.h"

@implementation NRBackgroundMap

-(void)generate {
    for (int y = 0; y < 4; y++) {
        for (int x = 0; x < 4; x++) {
            CGFloat xCoordinate = (CGFloat)x;
            CGFloat yCoordinate = (CGFloat)y;
            CGPoint position = [self positionForTileWithCoordinates:CGPointMake(xCoordinate, yCoordinate)];
            NRTile *tile = [[NRTile alloc] initBackWithPosition:position];
            [self addChild:tile];
        }
    }
}

-(CGPoint)positionForTileWithCoordinates:(CGPoint)coordinates {
    /*
     Position
     | 0;3 |     |     |     |
     | 0;2 |     |     |     |
     | 0;1 |     |     |     |
     | 0;0 | 1;0 | 2;0 | 3;0 |
     */
    
    //Calculate X
    CGFloat xCoordinate = 8.0 + coordinates.x * 8.0 + coordinates.x * 60.0;
    
    //Calculate y
    CGFloat yCoordinate = 8.0 + coordinates.y * 8.0 + coordinates.y * 60.0;;
    
    return CGPointMake(xCoordinate, yCoordinate);
}

-(CGSize)deltaForCoordinates:(CGPoint)coordinates1 andCoordinates:(CGPoint)coordinates2 {
    if (coordinates1.x == coordinates2.x) {
        CGFloat height = [self positionForTileWithCoordinates:coordinates2].y -
                                [self positionForTileWithCoordinates:coordinates1].y;
        return CGSizeMake(0.0, height);
    } else if(coordinates1.y == coordinates2.y) {
        CGFloat width = [self positionForTileWithCoordinates:coordinates2].x -
        [self positionForTileWithCoordinates:coordinates1].x;
        return CGSizeMake(width, 0.0);
    } else {
        return CGSizeMake(0, 0);
    }

}

@end

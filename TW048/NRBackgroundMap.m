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
            NRTile *tile = [[NRTile alloc] init];
            CGFloat xCoordinate = (CGFloat)x;
            CGFloat yCoordinate = (CGFloat)y;
            CGPoint position = [self positionForTileWithCoordinates:CGPointMake(xCoordinate, yCoordinate)];
            [tile setPath:CGPathCreateWithRoundedRect(CGRectMake(position.x, position.y, 60.0,60.0), 4, 4, nil)];
            tile.lineWidth = 0.0;
            [self addChild:tile];
        }
    }
}

-(CGPoint)positionForTileWithCoordinates:(CGPoint)coordinates {
    //Calculate X
    CGFloat xCoordinate = 8.0 + coordinates.x * 8.0 + coordinates.x * 60.0;
    
    //Calculate y
    CGFloat yCoordinate = 8.0 + coordinates.y * 8.0 + coordinates.y * 60.0;;
    
    return CGPointMake(xCoordinate, yCoordinate);
}


@end

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
            CGPoint coordinates = CGPointMake(xCoordinate, yCoordinate);
            NRTile *tile = [[NRTile alloc] initBackWithCoordinates:coordinates];
            [self addChild:tile];
        }
    }
}

@end

//
//  GZGameData.m
//  TW048
//
//  Created by Georg Zänker on 02.04.14.
//  Copyright (c) 2014 Niklas Riekenbrauck & Georg Zänker. All rights reserved.
//

#import "GZGameData.h"

@implementation GZGameData

-(id)initDefault {
    self = [super init];
    if (self) {
        self.gameLost = NO;
        self.gameWon =  NO;
        self.gameWonType = 2048;
        self.score      = 0;
        
        self.tileMatrix = [NRTileMatrix new];
    }
    return self;
}

@end

//
//  GZGameData.h
//  TW048
//
//  Created by Georg Zänker on 02.04.14.
//  Copyright (c) 2014 Niklas Riekenbrauck & Georg Zänker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NRTileMatrix.h"

@interface GZGameData : NSObject

@property (nonatomic) BOOL      gameLost;
@property (nonatomic) BOOL      gameWon;
@property (nonatomic) NSInteger gameWonType;
@property (nonatomic) NSInteger score;

@property (nonatomic, retain) NRTileMatrix *tileMatrix;

-(id)initDefault;

@end

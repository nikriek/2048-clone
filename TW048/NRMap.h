//
//  NRMap.h
//  TW048
//
//  Created by Niklas Riekenbrauck on 21.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface NRMap : SKNode

@property (nonatomic) CGSize gridSize;

-(void)generate;
-(CGPoint)positionForTileWithCoordinates:(CGPoint)coordinates;

@end

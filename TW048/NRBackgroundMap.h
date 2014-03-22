//
//  NRMap.h
//  TW048
//
//  Created by Niklas Riekenbrauck on 21.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface NRBackgroundMap : SKNode

-(void)generate;
-(CGPoint)positionForTileWithCoordinates:(CGPoint)coordinates;
-(CGSize)deltaForCoordinates:(CGPoint)coordinates1 andCoordinates:(CGPoint)coordinates2;
@end

//
//  NRMapTile.h
//  TW048
//
//  Created by Niklas Riekenbrauck on 21.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "NRBackgroundMap.h"
#import "SKAction+Direction.h"

@interface NRTileMap : NRBackgroundMap

-(void)setNewTileAtRandomPosition;

-(void)performedSwipeGestureInDirection:(Direction)direction;

@end

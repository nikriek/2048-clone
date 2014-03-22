//
//  NRMyScene.h
//  TW048
//

//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKAction+Direction.h"
@interface NRGameScene : SKScene

-(void)performedSwipeGestureInDirection:(Direction)direction;

@end

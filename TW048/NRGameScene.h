//
//  NRMyScene.h
//  TW048
//

//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface NRGameScene : SKScene

typedef enum Direction:NSInteger {
    kDirectionUp,
    kDirectionDown,
    kDirectionLeft,
    kDirectionRight
} Direction;

-(void)performedSwipeGestureInDirection:(Direction)direction;

@end

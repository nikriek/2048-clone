//
//  NRGamePad.h
//  2048
//
//  Created by Niklas Riekenbrauck on 19.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum Direction:NSInteger {
    kDirectionUp,
    kDirectionRight,
    kDirectionDown,
    kDirectionLeft
    
} Direction;

@interface NRGamePad : NSObject

-(void)swipedInDirection:(Direction)direction withScore:(void(^)(NSInteger newScore))score;

@end

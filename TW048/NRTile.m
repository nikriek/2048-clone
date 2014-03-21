//
//  NRTile.m
//  TW048
//
//  Created by Niklas Riekenbrauck on 21.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "NRTile.h"

@implementation NRTile

@synthesize currentValue = _currentValue;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.currentValue = 0;
        
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue"];
        label.position = CGPointMake(30.0,30.0);
        label.text = [NSString stringWithFormat:@"%i",self.currentValue];
    }
    return self;
}
-(void)setCurrentValue:(NSInteger)currentValue {
    _currentValue = currentValue;

    switch (self.currentValue) {
        case 0:
            self.strokeColor = self.fillColor = [UIColor colorWithRed:238.0/255.0 green:228.0/255.0 blue:218.0/255.0 alpha:0.35];
            break;
        case 2:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xeee4da);
            break;
        case 4:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xede0c8);
            break;
        case 8:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xf2b179);
            break;
        case 16:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xf59563);
            break;
        case 32:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xf67c5f);
            break;
        case 64:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xf65e3b);
            break;
        case 128:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xedcf72);
            break;
        case 256:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xedcc61);
            break;
            
        case 512:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xedc850);
            break;
        
        case 1024:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xedc53f);
            break;
        
        case 2048:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xedc22e);
            break;
        default:
            self.strokeColor = self.fillColor = UIColorFromRGB(0x3c3a32);
            break;
    }
}

@end

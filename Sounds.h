//
//  Sounds.h
//  TW048
//
//  Created by Georg Zänker on 22.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum Soundtype:NSInteger {
    kFailure,
    kSuccess,
    kSwipe,
    kPop
} Soundtype;

@interface Sounds: NSObject

- (void)playSoundOfType:(Soundtype)soundtype;

- (void)playBackgroundSound;
- (void)stopBackgroundSound;
- (BOOL)backgroundSoundOn;

@end

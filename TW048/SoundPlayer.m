//
//  Sounds.m
//  TW048
//
//  Created by Georg Zänker on 22.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "SoundPlayer.h"

#import <AVFoundation/AVFoundation.h>

@interface SoundPlayer ()
@property (nonatomic) AVAudioPlayer *soundPlayer;
@property (nonatomic) AVAudioPlayer *backgroundMusicPlayer;
@end

@implementation SoundPlayer

-(void)playSoundOfType:(Soundtype)soundtype{
    
    NSError *error;
    NSURL *soundURL;
    
    switch (soundtype) {
        case kFailure:
            soundURL =[[NSBundle mainBundle] URLForResource:@"138490__randomationpictures__powerdown-2" withExtension:@"wav"];
            break;
        case kSuccess:
            soundURL =[[NSBundle mainBundle] URLForResource:@"171671__fins__success-1" withExtension:@"wav"];
            break;
        case kSwipe:
            soundURL =[[NSBundle mainBundle] URLForResource:@"73601__willc2-45220__swoop-thick-01" withExtension:@"aif"];
            break;
        case kPop:
            soundURL =[[NSBundle mainBundle] URLForResource:@"47498__carlsablowedwards__mouthpop-02" withExtension:@"wav"];
            break;
        default:
            break;
    }
    
    self.soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
    self.soundPlayer.volume = 0.2f;
    [self.soundPlayer prepareToPlay];
    [self.soundPlayer play];
    
    if ( error )
    {
        NSLog(@"Error: %@", error.localizedDescription);
    }
}

+(NSString*)soundNameOfType:(Soundtype)type {
    
    switch (type) {
        case kFailure:
            return @"138490__randomationpictures__powerdown-2.wav";
            break;
        case kSuccess:
            return @"171671__fins__success-1.wav";
            break;
        case kSwipe:
            return @"73601__willc2-45220__swoop-thick-01.aif";
            break;
        case kPop:
            return @"47498__carlsablowedwards__mouthpop-02.wav";
            break;
        default:
            break;
    }
}

-(void)playBackgroundSound {
    
    // Play some lovely background music
    NSError *error;
    NSURL *backgroundMusicURL =[[NSBundle mainBundle] URLForResource:@"157846_darkmast49_fightscene (mp3cut.net)" withExtension:@"wav"];
    _backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = -1;
    self.backgroundMusicPlayer.volume = 0.2f;
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];
    
    if ( error )
    {
        NSLog(@"Error: %@", error.localizedDescription);
    }
}
- (void)stopBackgroundSound {
    [self.backgroundMusicPlayer stop];
}
- (BOOL)backgroundSoundOn {
    return self.backgroundMusicPlayer.playing;
}

@end

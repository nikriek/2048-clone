//
//  NRViewController.m
//  TW048
//
//  Created by Niklas Riekenbrauck on 20.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "NRViewController.h"
#import "NRMyScene.h"

@import AVFoundation;

@interface NRViewController ()
@property (nonatomic) AVAudioPlayer *backgroundMusicPlayer;
@end

@implementation NRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.showsDrawCount = YES;
    skView.showsPhysics = YES;

    
    // Create and configure the scene.
    SKScene * scene = [NRMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Play some lovely background music
    NSError *error;
    NSURL *backgroundMusicURL =[[NSBundle mainBundle] URLForResource:@"The Binary Code Song" withExtension:@"mp3"];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = -1;
    self.backgroundMusicPlayer.volume = 0.2f;
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];
    
    if ( error )
    {
        NSLog(@"Error: %@", error.localizedDescription);
    }
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end

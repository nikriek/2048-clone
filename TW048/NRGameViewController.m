//
//  NRViewController.m
//  TW048
//
//  Created by Niklas Riekenbrauck on 20.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "NRGameViewController.h"
#import "NRGameScene.h"
#import <QuartzCore/QuartzCore.h>
#import "SoundPlayer.h"
#import "NRGameOverSheetViewController.h"

@implementation NRGameViewController {
    NRGameScene * scene;
    SoundPlayer *soundPlayer;
}
@synthesize scoreLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Configure form sheet
    [[MZFormSheetBackgroundWindow appearance] setBackgroundBlurEffect:YES];
    [[MZFormSheetBackgroundWindow appearance] setBlurRadius:5.0];
    [[MZFormSheetBackgroundWindow appearance] setBackgroundColor:[UIColor clearColor]];
    
    // SoundPlayer
    soundPlayer = [SoundPlayer new];
    [soundPlayer playBackgroundSound];
    

    //Make round corners
    self.scoreBackgroundView.layer.cornerRadius = 4.0;
    self.scoreBackgroundView.layer.masksToBounds = YES;
    self.bestBackgroundView.layer.cornerRadius = 4.0;
    self.bestBackgroundView.layer.masksToBounds = YES;
    self.gamepadView.layer.cornerRadius = 8.0;
    self.gamepadView.layer.masksToBounds = YES;
    
    [self prepareGame];

}

-(void)prepareGame {

    self.scoreLabel.text = @"0";

    // Configure the view.
    SKView * skView = (SKView *)self.gamepadView;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.showsPhysics = YES;
    skView.showsDrawCount = YES;
    
    //make property weak to use it in blocks
    __weak typeof(self) weakSelf = self;

    // Create and configure the scene.
    scene = [NRGameScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [scene.mapTiles setNewScoreBlock:^(NSInteger newScore, NSInteger offset) {
        //Actions for new score
        [weakSelf updateScore:newScore withScoreOffset:offset];
    }];
    
    [scene.mapTiles setFinishedGameBlock:^(BOOL success, NSInteger score) {
        //[soundPlayer stopBackgroundSound];
        [weakSelf showPopUpWithScore:score andSuccess:success];
    }];

    // Present the scene.
    [skView presentScene:scene];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(void)showPopUpWithScore:(NSInteger)score andSuccess:(BOOL)success {
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"sheet"];
    
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:vc];
    
    formSheet.shouldCenterVertically = YES;
    //formSheet.shouldDismissOnBackgroundViewTap = YES;
    
    formSheet.willPresentCompletionHandler = ^(UIViewController *presentedFSViewController) {
        NRGameOverSheetViewController *viewController = (NRGameOverSheetViewController *)presentedFSViewController;
        viewController.score = score;
        if (success) {
            viewController.statusTextLabel.text = @"You win!";
            [scene runAction:[SKAction playSoundFileNamed:[SoundPlayer soundNameOfType:kSuccess]
                                        waitForCompletion:NO]];
        } else {
            viewController.statusTextLabel.text = @"You win!";
            [scene runAction:[SKAction playSoundFileNamed:[SoundPlayer soundNameOfType:kFailure]
                                        waitForCompletion:NO]];
            viewController.statusTextLabel.text = @"Game over!";
        }
        viewController.scoreTextLabel.text = [NSString stringWithFormat:@"You scored %i points",(int)score];
    };
    
    [self mz_presentFormSheetController:formSheet animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
        
    }];
    
}

-(void)updateScore:(NSInteger)score withScoreOffset:(NSInteger)offset {
    self.scoreLabel.text = [NSString stringWithFormat:@"%i",(int)score];
}

- (IBAction)madeSwipeGesture:(UISwipeGestureRecognizer *)sender {
    
    //[self showPopUpWithScore:100 andSuccess:YES];
    
    for (UISwipeGestureRecognizer *recognizer in self.swipeGestureRecognizerCollection)
        if (sender.direction == recognizer.direction)
            [scene.mapTiles performedSwipeGestureInDirection:sender.direction];
}

-(void)viewDidDisappear:(BOOL)animated {
    [soundPlayer stopBackgroundSound];
}
@end

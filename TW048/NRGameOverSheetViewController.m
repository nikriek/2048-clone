//
//  NRGameOverSheetViewController.m
//  TW048
//
//  Created by Niklas Riekenbrauck on 22.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "NRGameOverSheetViewController.h"
#import "MZFormSheetController.h"
#import <Social/Social.h>

@interface NRGameOverSheetViewController ()

@end

@implementation NRGameOverSheetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.restartButton.layer.cornerRadius = 4.0;
    self.restartButton.layer.masksToBounds = YES;
    self.tweetButton.layer.cornerRadius = 4.0;
    self.tweetButton.layer.masksToBounds = YES;
    self.facebookButton.layer.cornerRadius = 4.0;
    self.facebookButton.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushedRestart:(UIButton *)sender {
    MZFormSheetController *parent = (MZFormSheetController*)[self mz_parentTargetViewController];
    [parent mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController *formSheetController) {

    }];
        
}


- (IBAction)pushedTweet:(UIButton *)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:[NSString stringWithFormat:@"I scored %i points in 2048 for iPhone. 2048 can be downloaded from http://nikriek.de/2048-ios-game",(int)self.score]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}

- (IBAction)pushedFacebook:(UIButton *)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [controller setInitialText:[NSString stringWithFormat:@"I scored %i points in 2048 for iPhone. 2048 can be downloaded from http://nikriek.de/2048-ios-game",(int)self.score]];
        [self presentViewController:controller animated:YES completion:Nil];
    }
}
@end

//
//  LiveModeViewController.m
//  Projet
//
//  Created by Claire Detilleux on 04/02/13.
//  Copyright (c) 2013 ISMIN-M&S. All rights reserved.
//

#import "LiveModeViewController.h"

@interface LiveModeViewController ()

@end

@implementation LiveModeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Forcer le landscape
    return UIDeviceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)playButton:(id)sender {
}

- (IBAction)pauseButton:(id)sender {
}

- (IBAction)recButton:(id)sender {
}

- (IBAction)rewButton:(id)sender {
}

- (IBAction)ffButton:(id)sender {
}

@end

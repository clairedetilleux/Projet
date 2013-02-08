//
//  LectureModeViewController.m
//  Projet
//
//  Created by Claire Detilleux on 04/02/13.
//  Copyright (c) 2013 ISMIN-M&S. All rights reserved.
//

#import "LectureModeViewController.h"

@interface LectureModeViewController ()

@end

@implementation LectureModeViewController
@synthesize temps;


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setTemps:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Forcer le landscape
    return UIDeviceOrientationIsLandscape(interfaceOrientation);
}

/***************** Gestion du timer *****************/

- (IBAction)rewButton:(id)sender {
} // rexButton()

- (IBAction)stopButton:(id)sender {
} // stopButton()



- (NSDictionary *)userInfo {
    return @{ @"StartDate" : [NSDate date] };
} // userInfo()
- (void)targetMethod:(NSTimer*)theTimer {
    NSDate *startDate = [[theTimer userInfo] objectForKey:@"StartDate"];
    NSLog(@"Timer started on %@", startDate);
} // targetMethod()


/* Mise en route du timer */
- (IBAction)playButton:(id)sender {
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                        target:self
                                      selector:@selector(targetMethod:)
                                      userInfo:[self userInfo]
                                       repeats:NO];
     

     
     // Afficher le temps dans le label sur la view
     //this.text = [NSString stringWithFormat:@"%@", _tps];
} // playButton()




    



- (IBAction)pauseButton:(id)sender {
} // pauseButton()

- (IBAction)ffButton:(id)sender {
} // ffButton()


@end

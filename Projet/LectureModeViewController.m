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
@synthesize label;
@synthesize dateFormatter;





- (void)viewDidLoad
{
    [super viewDidLoad];
}





- (void)viewDidUnload
{
    [self setLabel:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Forcer le landscape
    return UIDeviceOrientationIsLandscape(interfaceOrientation);
}

#pragma marks - Timer Methods

- (NSDictionary *)userInfo {
    return @{ @"StartDate" : [NSDate date] };
} // userInfo()

- (void)targetMethod:(NSTimer*)theTimer {
    NSDate *startDate = [[theTimer userInfo] objectForKey:@"StartDate"];
    NSLog(@"Timer started on %@", startDate);
    
    
    NSDate *today = [[NSDate alloc] init];
    NSString *currentTime = [self.dateFormatter stringFromDate: today];
    self.label.text = currentTime;
} // targetMethod()


# pragma marks - Timer Manager Methods

/***************** Gestion du timer *****************/

- (IBAction)rewButton:(id)sender {
} // rewButton()

- (IBAction)stopButton:(id)sender {

} // stopButton()

- (IBAction)playButton:(id)sender {
    
    NSDate *today = [[NSDate alloc] init];
    dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"HH : mm : ss.S"];
    
    NSString *currentTime = [self.dateFormatter stringFromDate: today];
    self.label.text = currentTime;
    
    
    pollingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                    target:self
                                                  selector:@selector(targetMethod:)
                                                  userInfo:[self userInfo]
                                                   repeats:YES];
} // playButton()


- (IBAction)pauseButton:(id)sender {
    [pollingTimer invalidate];
    pollingTimer = nil;
} // pauseButton()

- (IBAction)ffButton:(id)sender {
} // ffButton()





@end

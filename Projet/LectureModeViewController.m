//
//  LectureModeViewController.m
//  Projet
//
//  Created by Claire Detilleux on 04/02/13.
//  Copyright (c) 2013 ISMIN-M&S. All rights reserved.
//

#import "LectureModeViewController.h"

@interface LectureModeViewController ()


@property (strong, nonatomic) NSTimer *stopWatchTimer;      // Store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate;            // Stores the date of the click on the start button


@end

@implementation LectureModeViewController
@synthesize tenSecLabel = _tenSecLabel;
@synthesize fiveSecLabel = _fiveSecLabel;
@synthesize stopwatchLabel;


- (void)viewDidLoad
{
    [self.view setBackgroundColor:
     [[UIColor alloc]
      initWithPatternImage:[UIImage imageNamed:@"Background2.png"]]];
    
    //UIImage* background = [[UIImage imageNamed:@"Background.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    //self.view.backgroundColor = background;
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setStopwatchLabel:nil];
    [self setTenSecLabel:nil];
    [self setFiveSecLabel:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Forcer landscape
    return UIDeviceOrientationIsLandscape(interfaceOrientation);
}

#pragma marks - Timer Methods
- (void)updateTimer
{
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    
    NSString *timeStringDebugTimerDate = [dateFormatter stringFromDate:timerDate];
    NSLog(timeStringDebugTimerDate);
    
   
    if([timeStringDebugTimerDate isEqualToString:@"00:00:05.0"]){
        self.fiveSecLabel.text = @"hourra !!!!!";
    } else if([timeStringDebugTimerDate isEqualToString:@"00:00:10.0"]){
        self.tenSecLabel.text = @"Youpiiiii !!!";
    }
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.stopwatchLabel.text = timeString;
} //updateTimer

# pragma marks - Timer Manager Methods

- (IBAction)rewButton:(id)sender {
} // rewButton

- (IBAction)stopButton:(id)sender {
    [self.stopWatchTimer invalidate];
    self.stopWatchTimer = nil;
    [self updateTimer];
} // stopButton

- (IBAction)playButton:(id)sender {
    self.startDate = [NSDate date];
    
    // Create the stop watch timer that fires every 100 ms
    self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                           target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];
    
} // playButton


- (IBAction)pauseButton:(id)sender {
} // pauseButton

- (IBAction)ffButton:(id)sender {
} // ffButton()




@end

//
//  LiveModeViewController.m
//  Projet
//
//  Created by Claire Detilleux on 04/02/13.
//  Copyright (c) 2013 ISMIN-M&S. All rights reserved.
//

#import "LiveModeViewController.h"


@interface LiveModeViewController ()

@property (strong, nonatomic) NSTimer *stopWatchTimer;      // Store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate;            // Stores the date of the click on the start button

@property (strong, nonatomic) NSDate *ffDate;               // Stores the date of the click on the ff button

@property (strong, nonatomic) NSDate *piste;               // Stores the date of the click on the piste1 button

@end

@implementation LiveModeViewController
@synthesize changerTitreField = changerTitreField;
@synthesize longPressButton1;

/*@synthesize doubleTap = _doubleTap;
@synthesize doubleTap2 = _doubleTap2;*/
@synthesize stopwatchLabel;


int playButtonClicked;
bool popup = NO;
UIView *view;
UIButton *changeTitleButton;
bool isLocked = NO;
int numberOfTap = 2;
int count = 0;
bool isLongClicked = NO;


- (void)viewDidLoad
{
    
    [self.view setBackgroundColor:
     [[UIColor alloc]
      initWithPatternImage:[UIImage imageNamed:@"Background2.png"]]];

    // Server adress
    /*url = [NSURL URLWithString:@"http://ip.du.serveur/blablabla?actionneur=boutonn&action=start"];
     
     request = [[NSMutableURLRequest alloc] initWithURL:url];*/
    
    // Change value
    //[request setHTTPMethod :@"POST"];
    //[request setValue:<#(NSString *)#> forHTTPHeaderField:<#(NSString *)#>];
   
    sequence = [[NSMutableArray alloc] init];
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setStopwatchLabel:nil];
    [self setChangerTitreField:nil];
    [self setLongPressButton1:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Force landscape
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
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.stopwatchLabel.text = timeString;
} //updateTimer


# pragma marks - Timer Manager Methods

- (IBAction)playButton:(id)sender {
    playButtonClicked = 1;
    
    self.startDate = [NSDate date];
    
    // Create the stop watch timer that fires every 100 ms
    self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                           target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];
} // startButton()

- (IBAction)pauseButton:(id)sender {
    playButtonClicked = 0;
    NSLog(@"sequence: %@", sequence);
    
    // Stores the value of the array at index n (caution : the indexes start at 0)
    //NSLog(@"tab : %@", [sequence objectAtIndex:0]);
    
    
    [self.stopWatchTimer invalidate];
    self.stopWatchTimer = nil;
    [self updateTimer];
} // pauseButton()

#pragma marks - Piste Button

- (IBAction)pisteButton:(UIButton*) sender {
    NSLog(@"Button clicked");
    self.piste = [NSDate date];
    // Stores the time elapsed since the click on the play button
    NSTimeInterval timeIntervalPiste = [_piste timeIntervalSinceDate:self.startDate];
    NSDate *timerPiste1Date = [NSDate dateWithTimeIntervalSince1970:timeIntervalPiste];
    
    // Create a date formatter
    NSDateFormatter *datePisteFormatter = [[NSDateFormatter alloc] init];
    [datePisteFormatter setDateFormat:@"HH:mm:ss.SSS"];
    [datePisteFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
        
    // Stores the date of click on a track button
    NSString *clickTime = [datePisteFormatter stringFromDate:timerPiste1Date];
   
    // The array stores the events
    
    //  Send play request
    if(playButtonClicked == 1){
        // The title stores in the array is the on on the button
        // This array (1x2) stores this event 
        NSArray * singleEventArray = [[NSArray alloc] init];
        singleEventArray = [NSArray arrayWithObjects: clickTime, sender.currentTitle, nil];
        count++;
        [sequence insertObject:singleEventArray atIndex:count-1];
        NSLog(@"sequence: %@", sequence);
        
    }
} // pisteButton()



# pragma  marks - Gesture reconizer

- (IBAction)moveButton:(UIPanGestureRecognizer *)recognizer{
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
} 

- (IBAction)changeTitle:(UILongPressGestureRecognizer *)recognizer{
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        if(recognizer.numberOfTouches == 1){
            NSLog(@"numberOfTouches : %d", recognizer.numberOfTouches);
            view = [recognizer view];
            [(UIButton*)view currentTitle];
            
            if (!popup) {
                popup = YES;
                changeTitleAlert = [[UIAlertView alloc] initWithTitle:@"Change Title"
                                                              message:@"\n\n"
                                                             delegate:self
                                                    cancelButtonTitle:@"Submit"
                                                    otherButtonTitles:nil];
                
                changeTitleField = [[UITextField alloc] initWithFrame:CGRectMake(15, 35, 250, 30)];
                changeTitleField.backgroundColor = [UIColor clearColor];
                changeTitleField.textColor = [UIColor whiteColor];
                changeTitleField.font = [UIFont systemFontOfSize:15];
                changeTitleField.text = [(UIButton*)view currentTitle];
                [changeTitleAlert addSubview:changeTitleField];
                [changeTitleAlert show];
            }
        } else if(recognizer.numberOfTouches == 2){            
            if(!isLocked){
                NSLog(@"lock");

                UIImage* liveModeLockedButton = [[UIImage imageNamed:@"ipad-button-red.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
                [(UIButton*)[recognizer view] setBackgroundImage:liveModeLockedButton forState:UIControlStateNormal];
                isLocked = YES;
                
                // Send play request
                
            } else {
                NSLog(@"not lock");

                UIImage* liveModeButton = [[UIImage imageNamed:@"ipad-button-grey.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
                [(UIButton*)[recognizer view] setBackgroundImage:liveModeButton forState:UIControlStateNormal];
                
                UIImage* liveModePressedButton = [[UIImage imageNamed:@"ipad-button-grey-pressed.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
                [[UIButton appearance] setBackgroundImage:liveModePressedButton forState:UIControlStateHighlighted];
                isLocked = NO;
            }
        }
    }
} // changeTitle()




- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex : (NSInteger)buttonIndex
{
    [(UIButton*)view setTitle:changeTitleField.text forState:UIControlStateNormal];
    NSLog(@"close button clicked");
    popup=NO;
} //alertView()




- (IBAction)longPress:(UILongPressGestureRecognizer *)recognizer {

    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        if(recognizer.numberOfTouches == 1){
            
            
            NSLog(@"numberOfTouches : %d", recognizer.numberOfTouches);
            view = [recognizer view];
            [(UIButton*)view currentTitle];
            
            if (!popup) {
                popup = YES;
                changeTitleAlert = [[UIAlertView alloc] initWithTitle:@"Change Title"
                                                              message:@"\n\n"
                                                             delegate:self
                                                    cancelButtonTitle:@"Submit"
                                                    otherButtonTitles:nil];
                
                changeTitleField = [[UITextField alloc] initWithFrame:CGRectMake(15, 35, 250, 30)];
                changeTitleField.backgroundColor = [UIColor clearColor];
                changeTitleField.textColor = [UIColor whiteColor];
                changeTitleField.font = [UIFont systemFontOfSize:15];
                changeTitleField.text = [(UIButton*)view currentTitle];
                [changeTitleAlert addSubview:changeTitleField];
                [changeTitleAlert show];
            }
        } else if(recognizer.numberOfTouches == 12){
            NSLog(@"double touch");
            
            if(!isLocked){
                UIImage* liveModeLockedButton = [[UIImage imageNamed:@"ipad-button-red.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
                
                [(UIButton*)[recognizer view] setBackgroundImage:liveModeLockedButton forState:UIControlStateNormal];
                isLocked = YES;
                
                // Send play request
                
            } else {
                UIImage* liveModeButton = [[UIImage imageNamed:@"ipad-button-grey.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
                [(UIButton*)[recognizer view] setBackgroundImage:liveModeButton forState:UIControlStateNormal];
                isLocked = NO;
            }
            
            
        }
    }

}
@end

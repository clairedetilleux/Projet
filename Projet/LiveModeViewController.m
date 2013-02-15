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

@property (strong, nonatomic) NSDate *piste1;               // Stores the date of the click on the piste1 button





@end

@implementation LiveModeViewController
@synthesize pisteButton1 = _pisteButton1;
@synthesize pisteButton2 = _pisteButton2;
@synthesize stopwatchLabel;


/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}*/

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setStopwatchLabel:nil];
    [self setPisteButton1:nil];
    [self setPisteButton2:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Forcer le landscape
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
    [dateFormatter setDateFormat:@"HH:mm:ss.S"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    
    NSString *timeStringDebugTimerDate = [dateFormatter stringFromDate:timerDate];
    NSLog(timeStringDebugTimerDate);
    
    
    if([timeStringDebugTimerDate isEqualToString:@"00:00:05.0"]){
        //self.fiveSecLabel.text = @"hourra !!!!!";
    } else if([timeStringDebugTimerDate isEqualToString:@"00:00:10.0"]){
        //self.tenSecLabel.text = @"Youpiiiii !!!";
    }
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.stopwatchLabel.text = timeString;
} //updateTimer


# pragma marks - Timer Manager Methods

/***************** Gestion du timer *****************/

- (IBAction)playButton:(id)sender {
    self.startDate = [NSDate date];
    
    // Create the stop watch timer that fires every 100 ms
    self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                           target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];
} // startButton()

- (IBAction)pauseButton:(id)sender {
    [self.stopWatchTimer invalidate];
    self.stopWatchTimer = nil;
    [self updateTimer];
} // pauseButton()

- (IBAction)recButton:(id)sender {
} // recButton()

- (IBAction)rewButton:(id)sender {
} // rewButton()

- (IBAction)ffButton:(id)sender {
} // ffButton()


#pragma marks - Piste Button

- (IBAction)pisteButton:(id)sender {
    
    self.piste1 = [NSDate date];
    
    // Récupère le temps passé depuis l'appuie sur playButton (temps affiché par le timer)
    NSTimeInterval timeIntervalPiste1 = [_piste1 timeIntervalSinceDate:self.startDate];
    NSDate *timerPiste1Date = [NSDate dateWithTimeIntervalSince1970:timeIntervalPiste1];
    
    // Create a date formatter
    NSDateFormatter *datePisteFormatter = [[NSDateFormatter alloc] init];
    [datePisteFormatter setDateFormat:@"HH:mm:ss.S"];
    [datePisteFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
        
    // Affiche le moment d'appuie sur le bouton de piste 1
    NSString *time = [datePisteFormatter stringFromDate:timerPiste1Date];
   
    // Création d'un tableau pour recueillir les évènements
    NSMutableArray * sequence = [[NSArray alloc] init];
    
    if(sender == _pisteButton1){
        NSLog(@"Bouton 1 appuyé !");
        NSLog(time);
        NSString * piste =  @"piste1";
        // Création d'un tableau 1x2 contenant cet évènement
        NSArray * tabPiste1 = [[NSArray alloc] init];
        tabPiste1 = [NSArray arrayWithObjects: time, piste, nil];
        sequence = [NSArray arrayWithArray:tabPiste1];
    } else if (sender == _pisteButton2){
        NSLog(@"Bouton 2 appuyé !");
        NSLog(time);
        NSString * piste =  @"piste2";
        // Création d'un tableau 1x2 contenant cet évènement
        NSArray * tabPiste2 = [[NSArray alloc] init];
        tabPiste2 = [NSArray arrayWithObjects: time, piste, nil];
        sequence = [NSArray arrayWithArray:tabPiste2];
    }
} // pisteButton()

@end

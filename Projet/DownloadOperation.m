//
//  DownloadOperation.m
//  MSToolTips
//
//  Created by Marian Paul on 12/09/12.
//  Copyright (c) 2012 Marian Paul. All rights reserved.
//

#import "DownloadOperation.h"
#import <Foundation/Foundation.h>

@interface DownloadOperation ()
- (void) callDelegateOnMainThread: (SEL) selector withArg: (id) arg secondArg: (id) secondArg;
@end

@implementation DownloadOperation
@synthesize request = _request, delegate = _delegate, localFileName = _localFileName;

- (id) initWithRequest:(NSMutableURLRequest *)request andDelegate:(id<DownloadDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.request = request;
        self.delegate = delegate;
    }
    return self;
}

- (id) initWithLocalFileName:(NSString *)fileName andDelegate:(id<DownloadDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.localFileName = fileName;
        self.delegate = delegate;
    }
    return self;
}

// This is the enter point for your operation. Please see the doc for further infos about that.
// Please also note that by default, the main method will be called on a separate thread.
// This means two important things :
//    • As NSOperation does handle multi thread for you, perform ONLY synchronous methods on main. If you perform asynchronous methods, NSOperation won't wait for you! This can be configured, but this is not the purpose for this course
//    • You are in a separate thread, so all the calls to warn the delegate, or in an extended way to impact the UI process HAS to be perform in the main thread. UIKit IS NOT thread safe

- (void) main
{
    // First, tell the delegate we are starting
    [self callDelegateOnMainThread:@selector(downloadOperation:didStartLoadingRequest:) withArg:self secondArg:self.request];
    
    // We have two options. First one is a pseudo download of JSON: we load it locally
    NSData *jsonData = nil;
    if (_localFileName)
    {
        // First, get the file path. NSBundle mainBundle is in fact the path for the compiled resource
        NSString *filePath = [[NSBundle mainBundle] pathForResource:_localFileName ofType:@"json"];
        // Then get the data associated
        jsonData = [NSData dataWithContentsOfFile:filePath];
    }
    else
    {
        // Load the data using synchronous connection methods
        NSURLResponse *response = nil;
        NSError *error = nil;
        jsonData = [NSURLConnection sendSynchronousRequest:self.request
                                         returningResponse:&response // Yeah, double pointer, enjoy your C courses ;)
                                                     error:&error];
        if (error)
        {
            [self callDelegateOnMainThread:@selector(downloadOperation:didFailWithError:) withArg:self secondArg:error];
            // Return immediately, there is no reason to continue
            return;
        }
        
        // We do not use NSURLResponse, this is just to show you how it works. We could do this instead: (this is the power of nil compare to other languages: having a nil (or NULL) pointer does not trigger an exception)
        //        NSData *returnedData = [NSURLConnection sendSynchronousRequest:self.request
        //                                                     returningResponse:nil
        //                                                                 error:&error];
        
        // NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    }
    
    // We are here with some string data which should look like a json. We are gonna use some method to create a dictionary or an array from that
    NSError *jsonError = nil;
    // You need to add <Foundation/Foundation.h>
    id object = [NSJSONSerialization JSONObjectWithData:jsonData
                                                options:NSJSONReadingAllowFragments
                                                  error:&jsonError];
    
    if (jsonError)
        [self callDelegateOnMainThread:@selector(downloadOperation:didFailWithError:) withArg:self secondArg:jsonError];
    else
        [self callDelegateOnMainThread:@selector(downloadOperation:didLoadObject:) withArg:self secondArg:object];
}

#pragma mark - Main thread calls

// Deactivate some fuck*** warnings from ARC and potential perform leaks
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (void) _callDelegate: (SEL) selector withArg: (id) arg secondArg: (id) secondArg
{
    NSAssert([NSThread isMainThread], @"not the main thread ...");
    if([_delegate respondsToSelector: selector])
    {
        if(arg != nil)
        {
            [self.delegate performSelector: selector withObject: arg withObject: secondArg];
        }
        else
        {
            [self.delegate performSelector: selector withObject: secondArg];
        }
    }
}
#pragma clang diagnostic pop

- (void) callDelegateOnMainThread: (SEL) selector withArg: (id) arg secondArg: (id) secondArg
{
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    float systemVersionF = [systemVersion floatValue];
    if (systemVersionF >= 4.0 ) {
        dispatch_async(dispatch_get_main_queue(), ^(void)
                       {
                           [self _callDelegate: selector withArg: arg secondArg: secondArg];
                       });
    }
    else {
        [self _callDelegate: selector withArg: arg secondArg: secondArg];
    }
    
}



@end

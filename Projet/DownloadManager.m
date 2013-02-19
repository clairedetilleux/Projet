//
//  DownloadManager.m
//  MSToolTips
//
//  Created by Marian Paul on 12/09/12.
//  Copyright (c) 2012 Marian Paul. All rights reserved.
//

#import "DownloadManager.h"
#import "DownloadOperation.h"

@implementation DownloadManager

- (id) init
{
    self = [super init];
    if (self)
    {
        // Initialize the operation queue
        _operationQueue = [[NSOperationQueue alloc] init];
        [_operationQueue setMaxConcurrentOperationCount:1]; // Do not set too much for this value, this could lead to bad performance
    }
    return self;
}

- (void)loadRequest:(NSMutableURLRequest *)request withDelegate:(id<DownloadDelegate>)delegate
{
    DownloadOperation *op = [[DownloadOperation alloc] initWithRequest:request
                                                           andDelegate:delegate];
    // Simply add the operation to the queue.
    // You do not choose when it will be fired, it the queue which does handle that for you.
    // Please note that you can change the priorities of the queue.
    [_operationQueue addOperation:op];
}

- (void) loadLocalFileName:(NSString*)filename withDelegate:(id<DownloadDelegate>)delegate
{
    DownloadOperation *op = [[DownloadOperation alloc] initWithLocalFileName:filename
                                                                 andDelegate:delegate];
    [_operationQueue addOperation:op];
}

// This is one singleton implementation which use Grand Central Dispatch also know as GCD
#pragma mark - Singleton methods
+ (DownloadManager*)shared
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

@end

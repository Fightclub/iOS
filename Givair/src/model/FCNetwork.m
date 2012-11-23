//
//  FCNetwork.m
//  Givair
//
//  Created by Peter Tsoi on 11/22/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCNetwork.h"

#import "FCAppDelegate.h"

@implementation FCConnection

@synthesize delegate = mDelegate;

- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate networkDelegate:(FCNetwork *)network startImmediately:(BOOL)startImmediately {
    self = [super initWithRequest:request delegate:AppDelegate.network startImmediately:startImmediately];
    if (self) {
        mDelegate = delegate;
    }
    return self;
}

- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate {
    self = [self initWithRequest:request delegate:delegate networkDelegate:AppDelegate.network startImmediately:YES];
    if (self) {

    }
    return self;
}

@end


@implementation FCNetwork

- (id)init{
    self = [super init];
    if (self) {
        mActiveConnections = CFDictionaryCreateMutable(kCFAllocatorDefault,
                                                       0,
                                                       &kCFTypeDictionaryKeyCallBacks,
                                                       &kCFTypeDictionaryValueCallBacks);
    }
    return self;
}

- (FCConnection *)dataAtURL:(NSURL *)url delegate:(id<FCConnectionDelegate>) delegate{
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    FCConnection * conn = [[FCConnection alloc] initWithRequest:request delegate:delegate networkDelegate:self startImmediately:YES];
    CFDictionaryAddValue(mActiveConnections,
                         (__bridge const void *)conn,
                         (__bridge const void *)[NSMutableData data]);
    return conn;
}

#pragma mark - NSURLConnection

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (CFDictionaryContainsKey(mActiveConnections, (__bridge const void *)connection)) {
        NSMutableData * connectionData = CFDictionaryGetValue(mActiveConnections, (__bridge const void *)connection);
        [connectionData appendData:data];
    } else
        NSLog(@"Response was never created...");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    FCConnection * conn = (FCConnection*)connection;
    if (CFDictionaryContainsKey(mActiveConnections, (__bridge const void *)conn)) {
        NSMutableData * connectionData = CFDictionaryGetValue(mActiveConnections, (__bridge const void *)conn);
        [conn.delegate connection:conn finishedDownloadingData:connectionData];
        CFDictionaryRemoveValue(mActiveConnections, (__bridge const void *)conn);
    } else
        NSLog(@"Response was never created...");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    FCConnection * conn = (FCConnection*)connection;
    if (CFDictionaryContainsKey(mActiveConnections, (__bridge const void *)conn)) {
        [conn.delegate connection:conn failedWithError:error];
        CFDictionaryRemoveValue(mActiveConnections, (__bridge const void *)conn);
    } else
        NSLog(@"Response was never created...");
}

@end

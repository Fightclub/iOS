//
//  FCNetwork.h
//  Givair
//
//  Created by Peter Tsoi on 11/22/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FCNetwork;
@class FCConnection;

@protocol FCConnectionDelegate

- (void)connection:(FCConnection *)connection finishedDownloadingData:(NSData *)data;
- (void)connection:(FCConnection *)connection failedWithError:(NSError *)error;

@end

@interface FCConnection : NSURLConnection {
    id<FCConnectionDelegate> mDelegate;
}

@property (nonatomic) id<FCConnectionDelegate> delegate;

- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate networkDelegate:(FCNetwork *)network startImmediately:(BOOL)startImmediately;
- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate;

@end

@interface FCNetwork : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
    CFMutableDictionaryRef mActiveConnections;
}

- (FCConnection *)dataAtURL:(NSURL *)url delegate:(id<FCConnectionDelegate>) delegate;

@end

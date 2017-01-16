//
//  FutebasConnection.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FutebasConnectionDelegate <NSObject>

@optional

-(void) dataReceived:(NSData*)data;
-(void) downloadedProgressWithProgressBytes:(long)progress andTotalBytes:(long)totalbytes onibusApiCallMethod:(id)callMethod;

@required

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
@end



@interface FutebasConnection : NSURLConnection

@property(nonatomic, strong) NSMutableData *dataReceived;
@property(nonatomic, strong) NSURLConnection *connection;
@property (nonatomic) long requestExpectedLenght;

@property(nonatomic, weak) id <FutebasConnectionDelegate> delegate;
- (void)getRequest:(NSString*)url;
- (void)postRequest:(NSString*)url parameters:(NSMutableDictionary*)dict;


@end

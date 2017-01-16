//
//  FutebasConnection.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import "FutebasConnection.h"

@implementation FutebasConnection

static NSString* kBounds = @"KaksjIhDWiASDFklMFpjklWtpWRTOM30kslksDkl";



@synthesize delegate;
@synthesize connection;
@synthesize dataReceived;
@synthesize requestExpectedLenght;

- (id)init
{
    self = [super init];
    if (self) {
        dataReceived = [[NSMutableData alloc] init];
    }
    return self;
}

#pragma mark GET REQUEST
- (void)getRequest:(NSString*)url
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:30.0];
    
    [request setHTTPMethod:@"GET"];
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    [connection start];
    
}


#pragma mark POST REQUEST
- (void)postRequest:(NSString*)url parameters:(NSMutableDictionary*)dict
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:30.0];
    NSString* contentType = [NSString
                             stringWithFormat:@"multipart/form-data; boundary=%@", kBounds];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    
    [request setHTTPBody:[self generatePostBodyWithParameters:dict]];
    
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    [connection start];
    
}

- (NSMutableData *)generatePostBodyWithParameters:(NSMutableDictionary*)dict {
    NSMutableData *body = [NSMutableData data];
    
    NSString *endLine = [NSString stringWithFormat:@"\r\n--%@\r\n", kBounds];
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
    
    [self utfAppendBody:body data:[NSString stringWithFormat:@"--%@\r\n", kBounds]];
    
    for (id key in [dict keyEnumerator]) {
        
        if (([[dict objectForKey:key] isKindOfClass:[UIImage class]]) //trocar para UIIMAGE no iOS
            ||([[dict objectForKey:key] isKindOfClass:[NSData class]])) {
            
            [dataDictionary setObject:[dict objectForKey:key] forKey:key];
            continue;
            
        }
        
        [self utfAppendBody:body
                       data:[NSString
                             stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",
                             key]];
        [self utfAppendBody:body data:[dict objectForKey:key]];
        
        [self utfAppendBody:body data:endLine];
    }
    
    if ([dataDictionary count] > 0) {
        for (id key in dataDictionary) {
            NSObject *dataParam = [dataDictionary objectForKey:key];
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
            if ([dataParam isKindOfClass:[UIImage class]]) {
                
#else
                if ([dataParam isKindOfClass:[NSImage class]]) {
#endif
                    
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
                    NSData* imageData = UIImagePNGRepresentation((UIImage*)dataParam); //Para iOS
#else
                    NSData* imageData = [self PNGRepresentationOfImage:(NSImage*)dataParam];
#endif
                    [self utfAppendBody:body
                                   data:[NSString stringWithFormat:
                                         @"Content-Disposition: form-data; filename=\"%@\"\r\n", key]];
                    [self utfAppendBody:body
                                   data:@"Content-Type: image/png\r\n\r\n"];
                    [body appendData:imageData];
                } else {
                    NSAssert([dataParam isKindOfClass:[NSData class]],
                             @"dataParam must be a UIImage or NSData");
                    [self utfAppendBody:body
                                   data:[NSString stringWithFormat:
                                         @"Content-Disposition: form-data; filename=\"%@\"\r\n", key]];
                    [self utfAppendBody:body
                                   data:@"Content-Type: content/unknown\r\n\r\n"];
                    [body appendData:(NSData*)dataParam];
                }
                [self utfAppendBody:body data:endLine];
                
            }
        }
        return body;
    }
    
    
- (void)utfAppendBody:(NSMutableData *)body data:(NSString *)data {
    [body appendData:[data dataUsingEncoding:NSUTF8StringEncoding]];
}
    
#pragma mark NSUrlConnection Delegate
- (void)connection:(NSURLConnection *)aconnection didReceiveData:(NSData *)data
{
    [dataReceived appendData:data];
        
    if ([self.delegate respondsToSelector:@selector(downloadedProgressWithProgressBytes:andTotalBytes:onibusApiCallMethod:)]) {
        [self.delegate downloadedProgressWithProgressBytes:[dataReceived length] andTotalBytes:self.requestExpectedLenght onibusApiCallMethod:self];
    }
}
    
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if ([self.delegate respondsToSelector:@selector(dataReceived:)])
    {
        [self.delegate dataReceived:[NSData dataWithData:dataReceived]];
    }
}
    
- (void)connection:(NSURLConnection *)aconnection didReceiveResponse:(NSURLResponse *)response
{
    requestExpectedLenght = (long)response.expectedContentLength;
}
    
- (void) connection:(NSURLConnection *)_connection didFailWithError:(NSError *)error
{
    NSLog(@"erro: %@", error.description);
    [self.delegate connection:_connection didFailWithError:error];
}
    
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
willCacheResponse:(NSCachedURLResponse*)cachedResponse 
{
    return nil;
}

@end

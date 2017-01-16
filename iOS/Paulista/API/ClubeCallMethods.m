//
//  ClubeCallMethods.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import "ClubeCallMethods.h"

@implementation ClubeCallMethods



-(void)getAllClubes
{
    self.apiBeingCalled = apiGetClubes;
    
    [self.futebasConnection setDelegate:self];
    
    NSString *url = [self.endereco stringByAppendingString:@"paulista/clubes/"];
    
    [self.futebasConnection getRequest:url];
}

-(void)getClubeWithId:(NSString*)clubeId
{
    self.apiBeingCalled = apiGetClubes;
    
    [self.futebasConnection setDelegate:self];
    
    NSString *url = [self.endereco stringByAppendingString:@"paulista/clubes/"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:clubeId forKey:@"id"];
    
    [self.futebasConnection postRequest:url parameters:dict];
}

- (void)dataReceived:(NSData *)data
{
    if (self.apiBeingCalled == apiGetClubes) {
        [self processClubes:data];
    }
}

-(void)processClubes:(NSData*)data
{
    NSError *error;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if ([self.delegate respondsToSelector:@selector(clubesObtidosComSucessoComJson:)]) {
        [self.delegate clubesObtidosComSucessoComJson:json];
    }
}

@end

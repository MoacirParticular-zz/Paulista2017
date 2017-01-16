//
//  ArtilhariaCallMethods.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//
#import "ArtilhariaCallMethods.h"

@implementation ArtilhariaCallMethods

-(void)getArtilharia
{
    self.apiBeingCalled = apiGetArtilharia;
    
    [self.futebasConnection setDelegate:self];
    
    NSString *url = [self.endereco stringByAppendingString:@"paulista/artilharia/"];
    
    [self.futebasConnection getRequest:url];
}

- (void)dataReceived:(NSData *)data
{
    if (self.apiBeingCalled == apiGetArtilharia) {
        [self processArtilharia:data];
    }
}

-(void)processArtilharia:(NSData*)data
{
    NSError *error;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if ([self.delegate respondsToSelector:@selector(artilhariaObtidaComSucesso:)]) {
        [self.delegate artilhariaObtidaComSucesso:json];
    }
}



@end


//
//  JogoCallMethods.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import "JogoCallMethods.h"

@implementation JogoCallMethods


-(void)getAllJogos
{
    self.apiBeingCalled = apiGetJogos;
    
    [self.futebasConnection setDelegate:self];
    
    NSString *url = [self.endereco stringByAppendingString:@"paulista/jogos/"];
    
    [self.futebasConnection getRequest:url];
}

-(void)getJogoWithId:(NSString*)clubeId
{
    self.apiBeingCalled = apiGetJogos;
    
    [self.futebasConnection setDelegate:self];
    
    NSString *url = [self.endereco stringByAppendingString:@"paulista/Jogos/"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:clubeId forKey:@"id"];
    
    [self.futebasConnection postRequest:url parameters:dict];
}

- (void)dataReceived:(NSData *)data
{
    if (self.apiBeingCalled == apiGetJogos) {
        [self processJogos:data];
    }
}

-(void)processJogos:(NSData*)data
{
    NSError *error;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if ([self.delegate respondsToSelector:@selector(jogosObtidosComSucessoComJson:)]) {
        [self.delegate jogosObtidosComSucessoComJson:json];
    }
}

@end

//
//  ClassificacaoCallMethods.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import "ClassificacaoCallMethods.h"

@implementation ClassificacaoCallMethods


-(void)getClassificacaoPiratini
{
    qual = 1;
    self.apiBeingCalled = apiGetPiratini;
    
    [self.futebasConnection setDelegate:self];
    
    NSString *url = [self.endereco stringByAppendingString:@"paulista/piratini/"];
    
    [self.futebasConnection getRequest:url];
}

- (void)dataReceived:(NSData *)data
{
    switch (qual) {
        case 1:
            if (self.apiBeingCalled == apiGetPiratini) {
                [self processPiratini:data];
            }
            break;
            
        case 2:
            if (self.apiBeingCalled == apiGetFarroupilha) {
                [self processFarroupilha:data];
            }
            break;
            
        case 3:
            if (self.apiBeingCalled == apiGetGeral) {
                [self processGeral:data];
            }
            break;
            
        default:
            break;
    }
}

-(void)processPiratini:(NSData*)data
{
    NSError *error;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if ([self.delegate respondsToSelector:@selector(piratiniObtidoComSucesso:)]) {
        [self.delegate piratiniObtidoComSucesso:json];
    }
}

-(void)getClassificacaoFarroupilha
{
    qual = 2;
    self.apiBeingCalled = apiGetFarroupilha;
    
    [self.futebasConnection setDelegate:self];
    
    NSString *url = [self.endereco stringByAppendingString:@"paulista/farroupilha/"];
    
    [self.futebasConnection getRequest:url];
}

-(void)processFarroupilha:(NSData*)data
{
    NSError *error;

    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if ([self.delegate respondsToSelector:@selector(farroupilhaObtidoComSucesso:)]) {
        [self.delegate farroupilhaObtidoComSucesso:json];
    }
}

-(void)getClassificacaoGeral
{
    qual = 3;
    self.apiBeingCalled = apiGetGeral;
    
    [self.futebasConnection setDelegate:self];
    
    NSString *url = [self.endereco stringByAppendingString:@"paulista/geral/"];
    
    [self.futebasConnection getRequest:url];
}

-(void)processGeral:(NSData*)data
{
    NSError *error;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if ([self.delegate respondsToSelector:@selector(geralObtidoComSucesso:)]) {
        [self.delegate geralObtidoComSucesso:json];
    }
}



@end

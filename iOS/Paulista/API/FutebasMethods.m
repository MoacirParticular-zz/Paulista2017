//
//  FutebasMethods.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import "FutebasMethods.h"




@implementation FutebasMethods

@synthesize apiBeingCalled;
@synthesize delegate;
@synthesize futebasConnection;
@synthesize endereco;


- (id)init
{
    self = [super init];
    if (self) {
        self.futebasConnection = [[FutebasConnection alloc] init];
        self.endereco = @"http://www.blusistemas.com.br/";
    }
    return self;
}

- (id)initWithDelegate:(id)_delegate
{
    self = [super init];
    if (self) {
        self.futebasConnection = [[FutebasConnection alloc] init];
        self.delegate = _delegate;
        self.endereco = @"http://www.blusistemas.com.br/";
    }
    return self;
}

//#pragma mark Criacao das chamadas
//
//-(void)getCidades
//{
//    self.apiBeingCalled = apiGetCidades;
//    
//    [futebasConnection setDelegate:self];
//    
//    NSString *url = [endereco stringByAppendingString:@"silk/cidades.php"];
//    
//    [futebasConnection getRequest:url];
//}



#pragma mark Tratamento do retorno das chamadas

- (void)dataReceived:(NSData *)data
{
    ///implementar o tratamento para
    
//    if (apiBeingCalled == apiGetCidades) {
//        [self processCidades:data];
//    }
//    else if (apiBeingCalled == apiGetHorarios)
//    {
//        [self processHorarios:data];
//    }
}



//-(void)downloadedProgressWithProgressBytes:(long)progress andTotalBytes:(long)totalbytes onibusApiCallMethod:(id)callMethod
//{
//    if ([self.delegate respondsToSelector:@selector(downloadedProgressWithProgressBytes:andTotalBytes:onibusApiCallMethod:)]) {
//        [self.delegate downloadedProgressWithProgressBytes:progress andTotalBytes:totalbytes onibusApiCallMethod:self];
//    }
//}

// Subindo exceçao, problema de conexao etc

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(connection:didFailWithError:)]) {
        [self.delegate connection:(NSURLConnection *)connection didFailWithError:(NSError *)error];
    }
}

@end

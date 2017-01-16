//
//  FutebasMethods.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FutebasConnection.h"


typedef enum apiCall {
    apiGetClubes,
    apiGetJogos,
    apiGetPiratini,
    apiGetArtilharia,
    apiGetFarroupilha,
    apiGetGeral,
} apiCall;

@protocol FutebasMethodsDelegate <NSObject>

@optional


@required

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;

@end

@interface FutebasMethods : NSObject <FutebasConnectionDelegate>{
    
}

@property (nonatomic, strong) FutebasConnection *futebasConnection;
@property (nonatomic) int apiBeingCalled;
@property (nonatomic, weak) id <FutebasMethodsDelegate> delegate;

@property (nonatomic, strong) NSString* endereco;


-(id)initWithDelegate:(id)_delegate;
-(void) dataReceived:(NSData *)data;
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;


@end

//
//  ClubeCallMethods.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import "FutebasMethods.h"


@protocol ClubeMethodsDelegate <NSObject>

@optional

-(void)clubesObtidosComSucessoComJson:(NSDictionary*)json;

@end


@interface ClubeCallMethods : FutebasMethods

@property (nonatomic, weak) id <FutebasMethodsDelegate, ClubeMethodsDelegate> delegate;

-(void)getAllClubes;
-(void)getClubeWithId:(NSString*)clubeId;

@end

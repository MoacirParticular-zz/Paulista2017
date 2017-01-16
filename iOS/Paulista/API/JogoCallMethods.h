//
//  JogoCallMethods.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import "FutebasMethods.h"



@protocol JogoMethodsDelegate <NSObject>

@optional

-(void)jogosObtidosComSucessoComJson:(NSDictionary*)json;

@end


@interface JogoCallMethods : FutebasMethods

@property (nonatomic, weak) id <FutebasMethodsDelegate, JogoMethodsDelegate> delegate;

-(void)getAllJogos;
-(void)getJogoWithId:(NSString*)clubeId;

@end
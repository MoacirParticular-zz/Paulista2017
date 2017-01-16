//
//  ArtilhariaCallMethods.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import "FutebasMethods.h"

@protocol ArtilhariaCallMethodsDelegate <NSObject>

@optional

-(void)artilhariaObtidaComSucesso:(NSDictionary*)json;

@end


@interface ArtilhariaCallMethods : FutebasMethods

@property (nonatomic, weak) id <FutebasMethodsDelegate, ArtilhariaCallMethodsDelegate> delegate;

-(void)getArtilharia;

@end


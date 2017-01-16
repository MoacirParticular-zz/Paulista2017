//
//  ClassificacaoCallMethods.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//
#import "FutebasMethods.h"

@protocol ClassificacaoCallMethodsDelegate <NSObject>

@optional

-(void)piratiniObtidoComSucesso:(NSDictionary*)json;
-(void)farroupilhaObtidoComSucesso:(NSDictionary*)json;
-(void)geralObtidoComSucesso:(NSDictionary*)json;

@end

@interface ClassificacaoCallMethods : FutebasMethods {
    int qual;
}

@property (nonatomic, weak) id <FutebasMethodsDelegate, ClassificacaoCallMethodsDelegate> delegate;

-(void)getClassificacaoPiratini;
-(void)getClassificacaoFarroupilha;
-(void)getClassificacaoGeral;

@end

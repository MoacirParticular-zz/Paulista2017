//
//  Artilharia.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Artilharia : NSManagedObject

@property (nonatomic, retain) NSNumber * codigo;
@property (nonatomic, retain) NSNumber * codigoJogador;
@property (nonatomic, retain) NSString * nomeEscudo;
@property (nonatomic, retain) NSString * nomeJogador;
@property (nonatomic, retain) NSNumber * numeroGols;
@property (nonatomic, retain) NSNumber * posicao;
@property (nonatomic, retain) NSNumber * posicaoArray;

@end

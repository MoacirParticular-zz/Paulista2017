//
//  Classificacao.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Clube;

@interface Classificacao : NSManagedObject

@property (nonatomic, retain) NSNumber * codigo;
@property (nonatomic, retain) NSNumber * derrotas;
@property (nonatomic, retain) NSString * dsgrupo;
@property (nonatomic, retain) NSNumber * empates;
@property (nonatomic, retain) NSNumber * jogos;
@property (nonatomic, retain) NSNumber * nrGolsContra;
@property (nonatomic, retain) NSNumber * nrGolsMarcados;
@property (nonatomic, retain) NSNumber * nrVitorias;
@property (nonatomic, retain) NSNumber * pontosGanhos;
@property (nonatomic, retain) NSNumber * posicao;
@property (nonatomic, retain) NSNumber * saldoGols;
@property (nonatomic, retain) Clube *clube;

@end

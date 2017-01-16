//
//  Rodada.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Jogo, Turno;

@interface Rodada : NSManagedObject

@property (nonatomic, retain) NSNumber * codigo;
@property (nonatomic, retain) NSDate * dataFim;
@property (nonatomic, retain) NSDate * dataInicio;
@property (nonatomic, retain) NSString * descricao;
@property (nonatomic, retain) NSString * estagio;
@property (nonatomic, retain) NSString * tipo;
@property (nonatomic, retain) NSSet *jogos;
@property (nonatomic, retain) Turno *turno;
@end

@interface Rodada (CoreDataGeneratedAccessors)

- (void)addJogosObject:(Jogo *)value;
- (void)removeJogosObject:(Jogo *)value;
- (void)addJogos:(NSSet *)values;
- (void)removeJogos:(NSSet *)values;

@end

//
//  Turno.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Jogo, Rodada;

@interface Turno : NSManagedObject

@property (nonatomic, retain) NSNumber * codigo;
@property (nonatomic, retain) NSString * descricao;
@property (nonatomic, retain) NSSet *jogos;
@property (nonatomic, retain) NSSet *rodadas;
@end

@interface Turno (CoreDataGeneratedAccessors)

- (void)addJogosObject:(Jogo *)value;
- (void)removeJogosObject:(Jogo *)value;
- (void)addJogos:(NSSet *)values;
- (void)removeJogos:(NSSet *)values;

- (void)addRodadasObject:(Rodada *)value;
- (void)removeRodadasObject:(Rodada *)value;
- (void)addRodadas:(NSSet *)values;
- (void)removeRodadas:(NSSet *)values;

@end

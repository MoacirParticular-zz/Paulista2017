//
//  Clube.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Classificacao, Jogo;

@interface Clube : NSManagedObject

@property (nonatomic, retain) NSNumber * codigo;
@property (nonatomic, retain) NSString * escudo;
@property (nonatomic, retain) NSString * grupo;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * sigla;
@property (nonatomic, retain) Classificacao *classificaoPiratini;
@property (nonatomic, retain) NSSet *jogos;
@end

@interface Clube (CoreDataGeneratedAccessors)

- (void)addJogosObject:(Jogo *)value;
- (void)removeJogosObject:(Jogo *)value;
- (void)addJogos:(NSSet *)values;
- (void)removeJogos:(NSSet *)values;

@end

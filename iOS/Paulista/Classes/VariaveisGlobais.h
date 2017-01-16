//
//  VariaveisGlobais.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VariaveisGlobais : NSObject

+(NSString*) const_PrimeiroTurno;
+(NSString*) const_SegundoTurno;
+(NSString*) const_Final;
+(NSArray *) sortedJogosByName:(NSArray*)jogos campoId:(NSString*) campoId;
+(NSArray *) sortedJogosByName:(NSArray*)jogos campoId:(NSString*) campoId campoId2:(NSString*) campoId2;
+(NSArray *) sortedPiratiniByPosicao:(NSArray*)classificacao campoId:(NSString*) campoId;

@end

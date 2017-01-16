//
//  VariaveisGlobais.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//
#import "VariaveisGlobais.h"

@implementation VariaveisGlobais


+(NSString*) const_PrimeiroTurno {
    return @"Turno";
}

+(NSString*) const_SegundoTurno {
    return @"Returno";
}

+(NSString*) const_Final {
    return @"Finais";
}

+(NSArray *)sortedJogosByName:(NSArray*)jogos campoId:(NSString*) campoId {
    NSSortDescriptor *sortNameDescriptor = [[NSSortDescriptor alloc] initWithKey:campoId ascending:YES] ;
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortNameDescriptor, nil];
    
    return [jogos sortedArrayUsingDescriptors:sortDescriptors];
}

+(NSArray *)sortedJogosByName:(NSArray*)jogos campoId:(NSString*) campoId campoId2:(NSString*) campoId2{
    NSSortDescriptor *sortNameDescriptor = [[NSSortDescriptor alloc] initWithKey:campoId ascending:YES] ;
    NSSortDescriptor *sortNameDescriptor2 = [[NSSortDescriptor alloc] initWithKey:campoId2 ascending:YES] ;
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortNameDescriptor,sortNameDescriptor2 , nil];
    
    return [jogos sortedArrayUsingDescriptors:sortDescriptors];
}

+(NSArray *) sortedPiratiniByPosicao:(NSArray*)classificacao campoId:(NSString*) campoId {
    NSSortDescriptor *sortNameDescriptor = [[NSSortDescriptor alloc] initWithKey:campoId ascending:YES] ;
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortNameDescriptor, nil];
    
    return [classificacao sortedArrayUsingDescriptors:sortDescriptors];
}

@end

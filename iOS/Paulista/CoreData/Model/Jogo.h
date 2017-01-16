//
//  Jogo.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Clube, Rodada, Turno;

@interface Jogo : NSManagedObject

@property (nonatomic, retain) NSNumber * codigo;
@property (nonatomic, retain) NSDate * data;
@property (nonatomic, retain) NSNumber * golsMandante;
@property (nonatomic, retain) NSNumber * golsVisitante;
@property (nonatomic, retain) Clube *mandante;
@property (nonatomic, retain) Rodada *rodada;
@property (nonatomic, retain) Turno *turno;
@property (nonatomic, retain) Clube *visitante;

@end

//
//  DAOTurno.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Turno.h"

@interface DAOTurno : NSObject

+(Turno*)fetchTurnoWithCode:(int)codigo;
+(NSArray*)fetchAllTurno;

@end

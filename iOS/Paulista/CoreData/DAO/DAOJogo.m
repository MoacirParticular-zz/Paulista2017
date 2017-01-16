//
//  DAOJogo.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//
#import "DAOJogo.h"
#import "AppDelegate.h"

@implementation DAOJogo



+(void)parseAndInsertObjectsWithJson:(NSDictionary*)json;
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSMutableArray *rodadasArray = [json objectForKey:@"Rodadas"];
    
    for (NSDictionary *dictRodada in rodadasArray) {
        Rodada *rodada = [DAORodada fetchRodadaWithCode:[[dictRodada objectForKey:@"codigo"] intValue]];
        
        if (rodada == nil) {
            rodada = [NSEntityDescription insertNewObjectForEntityForName:@"Rodada" inManagedObjectContext:context];
            rodada.codigo = [NSNumber numberWithInteger:[[dictRodada objectForKey:@"codigo"] integerValue]];
            rodada.dataInicio = [NSDate dateWithTimeIntervalSince1970:[[dictRodada objectForKey:@"datainicio"] doubleValue]];
            rodada.dataFim = [NSDate dateWithTimeIntervalSince1970:[[dictRodada objectForKey:@"dataFim"] doubleValue]];
            rodada.estagio = [dictRodada objectForKey:@"rodadaEstagio"];
            rodada.tipo = [dictRodada objectForKey:@"rodadaTipo"];
            rodada.descricao = [dictRodada objectForKey:@"rodadaNome"];
        }
        else
        {
            rodada.codigo = [NSNumber numberWithInteger:[[dictRodada objectForKey:@"codigo"] integerValue]];
            rodada.dataInicio = [NSDate dateWithTimeIntervalSince1970:[[dictRodada objectForKey:@"datainicio"] doubleValue]];
            rodada.dataFim = [NSDate dateWithTimeIntervalSince1970:[[dictRodada objectForKey:@"dataFim"] doubleValue]];
            rodada.estagio = [dictRodada objectForKey:@"rodadaEstagio"];
            rodada.tipo = [dictRodada objectForKey:@"rodadaTipo"];
            rodada.descricao = [dictRodada objectForKey:@"rodadaNome"];
        }
        
        for (NSDictionary *dictJogo in [dictRodada objectForKey:@"jogos"]) {
            
            Jogo *jogo = [DAOJogo fetchJogoWithCode:[[dictJogo objectForKey:@"codigo"] intValue]];
            
            if (jogo == nil) {
                jogo = [NSEntityDescription insertNewObjectForEntityForName:@"Jogo" inManagedObjectContext:context];
                
                jogo.rodada = rodada;
                jogo.codigo = [NSNumber numberWithInteger:[[dictJogo objectForKey:@"codigo"] integerValue]];
                jogo.data   = [NSDate dateWithTimeIntervalSince1970:[[dictJogo objectForKey:@"data"] doubleValue]];
                
                if([[dictJogo objectForKey:@"golsMandante"] isEqual: [NSNull null]]) {
                    jogo.golsMandante = nil;
                } else {
                    jogo.golsMandante = [NSNumber numberWithInteger:[[dictJogo objectForKey:@"golsMandante"] integerValue]];
                }
                
                if([[dictJogo objectForKey:@"golsVisitante"] isEqual: [NSNull null]]) {
                    jogo.golsVisitante = nil;
                } else {
                    jogo.golsVisitante = [NSNumber numberWithInteger:[[dictJogo objectForKey:@"golsVisitante"] integerValue]];
                }
            }
            else
            {
                jogo.rodada = rodada;
                jogo.codigo = [NSNumber numberWithInteger:[[dictJogo objectForKey:@"codigo"] integerValue]];
                jogo.data   = [NSDate dateWithTimeIntervalSince1970:[[dictJogo objectForKey:@"data"] doubleValue]];

                if([[dictJogo objectForKey:@"golsMandante"] isEqual: [NSNull null]]) {
                    jogo.golsMandante = nil;
                } else {
                    jogo.golsMandante = [NSNumber numberWithInteger:[[dictJogo objectForKey:@"golsMandante"] integerValue]];
                }
                
                if([[dictJogo objectForKey:@"golsVisitante"] isEqual: [NSNull null]]) {
                    jogo.golsVisitante = nil;
                } else {
                    jogo.golsVisitante = [NSNumber numberWithInteger:[[dictJogo objectForKey:@"golsVisitante"] integerValue]];
                }
            }
            
            NSDictionary *dictMandante = [dictJogo objectForKey:@"Mandante"];
    
            if (dictMandante != nil) {
                Clube * clube = [DAOClube fetchClubeWithCode:[[dictMandante objectForKey:@"codigo"] intValue]];
                if (clube == nil) {
                    clube = [NSEntityDescription insertNewObjectForEntityForName:@"Clube" inManagedObjectContext:context];
                    clube.codigo = [NSNumber numberWithInteger:[[dictMandante objectForKey:@"codigo"] integerValue]];
                    clube.nome = [dictMandante objectForKey:@"nome"];
                    clube.escudo = [dictMandante objectForKey:@"escudo"];
                    clube.sigla = [dictMandante objectForKey:@"sigla"];
                    clube.grupo = [dictMandante objectForKey:@"dsgrupo"];
                }
                else
                {
                    clube.codigo = [NSNumber numberWithInteger:[[dictMandante objectForKey:@"codigo"] integerValue]];
                    clube.nome = [dictMandante objectForKey:@"nome"];
                    clube.escudo = [dictMandante objectForKey:@"escudo"];
                    clube.sigla = [dictMandante objectForKey:@"sigla"];
                    clube.grupo = [dictMandante objectForKey:@"dsgrupo"];
                }
                jogo.mandante = clube;
            }
    
            NSDictionary *dictVisitante = [dictJogo objectForKey:@"Visitante"];
    
            if (dictVisitante != nil) {
                Clube * clube = [DAOClube fetchClubeWithCode:[[dictVisitante objectForKey:@"codigo"] intValue]];
                if (clube == nil) {
                    clube = [NSEntityDescription insertNewObjectForEntityForName:@"Clube" inManagedObjectContext:context];
                    clube.codigo = [NSNumber numberWithInteger:[[dictVisitante objectForKey:@"codigo"] integerValue]];
                    clube.nome = [dictVisitante objectForKey:@"nome"];
                    clube.escudo = [dictVisitante objectForKey:@"escudo"];
                    clube.sigla = [dictVisitante objectForKey:@"sigla"];
                    clube.grupo = [dictVisitante objectForKey:@"dsgrupo"];
                }
                else
                {
                    clube.codigo = [NSNumber numberWithInteger:[[dictVisitante objectForKey:@"codigo"] integerValue]];
                    clube.nome = [dictVisitante objectForKey:@"nome"];
                    clube.escudo = [dictVisitante objectForKey:@"escudo"];
                    clube.sigla = [dictVisitante objectForKey:@"sigla"];
                    clube.grupo = [dictVisitante objectForKey:@"dsgrupo"];
                }
                jogo.visitante = clube;
            }
    
            NSDictionary *dictTurno = [dictJogo objectForKey:@"Turno"];
    
        //    NSLog(@"%@", dictTurno);
            if (dictTurno != nil) {
                Turno *turno = [DAOTurno fetchTurnoWithCode:[[dictTurno objectForKey:@"codigo"] intValue]];
        
                if (turno == nil) {
                    turno = [NSEntityDescription insertNewObjectForEntityForName:@"Turno" inManagedObjectContext:context];
                    turno.codigo = [NSNumber numberWithInteger:[[dictTurno objectForKey:@"codigo"] integerValue]];
                    turno.descricao = [dictTurno objectForKey:@"nome"];
                }
                else
                {
                    turno.codigo = [NSNumber numberWithInteger:[[dictTurno objectForKey:@"codigo"] integerValue]];
                    turno.descricao = [dictTurno objectForKey:@"nome"];
                }
                jogo.turno = turno;
                rodada.turno = turno;
            }
        }
    }

    NSError *saveError;

    [context save:&saveError];
}


+(Jogo*)fetchJogoWithCode:(int)codigo
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest * allJogo = [[NSFetchRequest alloc] init];
    [allJogo setEntity:[NSEntityDescription entityForName:@"Jogo" inManagedObjectContext:context]];
    
    NSError * readError = nil;
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"codigo == %i", codigo];
    [allJogo setPredicate:predicate];
    
    NSArray *fetchArray = [context executeFetchRequest:allJogo error:&readError];
    
    if (fetchArray.count > 0) {
        return [fetchArray objectAtIndex:0];
    }
    else
    {
        return nil;
    }
}

+(NSArray*)fetchAllJogos
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest * allClubes = [[NSFetchRequest alloc] init];
    [allClubes setEntity:[NSEntityDescription entityForName:@"Jogo" inManagedObjectContext:context]];
    
    NSError * readError = nil;
    
    NSArray *fetchArray = [context executeFetchRequest:allClubes error:&readError];
    
    return fetchArray;
}

@end

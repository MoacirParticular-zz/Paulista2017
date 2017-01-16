//
//  DAOPiratini.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//
#import "DAOPiratini.h"
#import "AppDelegate.h"
#import "DAOClube.h"
#import "Clube.h"

@implementation DAOPiratini

+(Piratini*)fetchPiratiniWithCode:(int)codigo
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest * allPiratini = [[NSFetchRequest alloc] init];
    [allPiratini setEntity:[NSEntityDescription entityForName:@"Piratini" inManagedObjectContext:context]];
    
    NSError * readError = nil;
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"codigo == %i", codigo];
    [allPiratini setPredicate:predicate];
    
    NSArray *fetchArray = [context executeFetchRequest:allPiratini error:&readError];
    
    if (fetchArray.count > 0) {
        return [fetchArray objectAtIndex:0];
    }
    else
    {
        return nil;
    }
}

+(NSArray*)fetchAllPiratini
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest * allPiratini = [[NSFetchRequest alloc] init];
    [allPiratini setEntity:[NSEntityDescription entityForName:@"Piratini" inManagedObjectContext:context]];
    
    //    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"pontosGanhos" ascending:NO];
    //    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"nrVitorias" ascending:NO];
    //    NSSortDescriptor *sortDescriptor3 = [[NSSortDescriptor alloc] initWithKey:@"saldoGols" ascending:NO];
    //    NSSortDescriptor *sortDescriptor4 = [[NSSortDescriptor alloc] initWithKey:@"nrGolsMarcados" ascending:NO];
    //    NSSortDescriptor *sortDescriptor5 = [[NSSortDescriptor alloc] initWithKey:@"clube.nome" ascending:YES];
    //
    //    [allPiratini setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, sortDescriptor2, sortDescriptor3, sortDescriptor4, sortDescriptor5, nil]];
    
    
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"posicao" ascending:YES];
    NSSortDescriptor *sortDescriptor5 = [[NSSortDescriptor alloc] initWithKey:@"clube.nome" ascending:YES];
    
    [allPiratini setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, sortDescriptor5, nil]];
    
    NSError * readError = nil;
    
    NSArray *fetchArray = [context executeFetchRequest:allPiratini error:&readError];
    
    return fetchArray;
}

+(void)parseAndInsertObjectsWithJson:(NSDictionary*)json;
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSMutableArray *piratiniArray = [json objectForKey:@"Classificacao"];
    
//    NSLog(@"%@", piratiniArray);
    
    for (NSDictionary *dictPiratini in piratiniArray) {
        Piratini *piratini = [DAOPiratini fetchPiratiniWithCode:[[dictPiratini objectForKey:@"codigo"] intValue]];
        
        if (piratini == nil) {
            piratini = [NSEntityDescription insertNewObjectForEntityForName:@"Piratini" inManagedObjectContext:context];
            piratini.codigo = [NSNumber numberWithInteger:[[dictPiratini objectForKey:@"codigo"] integerValue]];
            piratini.pontosGanhos = [NSNumber numberWithInteger:[[dictPiratini objectForKey:@"pontosganhos"] integerValue]];
            piratini.nrVitorias = [NSNumber numberWithInteger:[[dictPiratini objectForKey:@"nrvitorias"] integerValue]];
            piratini.saldoGols = [NSNumber numberWithInteger:[[dictPiratini objectForKey:@"saldogols"] integerValue]];
            piratini.nrGolsMarcados = [NSNumber numberWithInteger:[[dictPiratini objectForKey:@"nrgolsmarcados"] integerValue]];
            piratini.dsgrupo = [dictPiratini objectForKey:@"grupo"];
            piratini.posicao = [NSNumber numberWithInteger:[[dictPiratini objectForKey:@"posicao"] integerValue]];
            piratini.nrGolsContra = [NSNumber numberWithInteger:[[dictPiratini objectForKey:@"nrgolscontra"] integerValue]];
            piratini.empates = [NSNumber numberWithInteger:[[dictPiratini objectForKey:@"empates"] integerValue]];
            piratini.derrotas = [NSNumber numberWithInteger:[[dictPiratini objectForKey:@"derrotas"] integerValue]];
            piratini.jogos = [NSNumber numberWithInteger:[[dictPiratini objectForKey:@"jogos"] integerValue]];
        }
        else
        {
            piratini.pontosGanhos = [NSNumber numberWithInteger:[[dictPiratini objectForKey:@"pontosganhos"] integerValue]];
            piratini.nrVitorias = [NSNumber numberWithInteger:[[dictPiratini objectForKey:@"nrvitorias"] integerValue]];
            piratini.saldoGols = [NSNumber numberWithInteger:[[dictPiratini objectForKey:@"saldogols"] integerValue]];
            piratini.nrGolsMarcados = [NSNumber numberWithInteger:[[dictPiratini objectForKey:@"nrgolsmarcados"] integerValue]];
            piratini.dsgrupo = [dictPiratini objectForKey:@"grupo"];
            piratini.posicao = [NSNumber numberWithInteger:[[dictPiratini objectForKey:@"posicao"] integerValue]];
            piratini.nrGolsContra = [NSNumber numberWithInteger:[[dictPiratini objectForKey:@"nrgolscontra"] integerValue]];
            piratini.empates = [NSNumber numberWithInteger:[[dictPiratini objectForKey:@"empates"] integerValue]];
            piratini.derrotas = [NSNumber numberWithInteger:[[dictPiratini objectForKey:@"derrotas"] integerValue]];
            piratini.jogos = [NSNumber numberWithInteger:[[dictPiratini objectForKey:@"jogos"] integerValue]];
        }
        
        Clube *clube = [DAOClube fetchClubeWithCode:[[dictPiratini objectForKey:@"codigo"] intValue]];
        
        if (clube == nil)
        {
            NSDictionary *dictClube = [dictPiratini objectForKey:@"clube"];
            clube = [NSEntityDescription insertNewObjectForEntityForName:@"Clube" inManagedObjectContext:context];
            clube.codigo = [NSNumber numberWithInteger:[[dictClube objectForKey:@"codigo"] integerValue]];
            clube.nome = [dictClube objectForKey:@"nome"];
            clube.escudo = [dictClube objectForKey:@"escudo"];
            clube.sigla = [dictClube objectForKey:@"sigla"];
        }
        
        [piratini setClube:clube];
        
    }
    
    NSError *saveError;
    
    [context save:&saveError];
}

@end

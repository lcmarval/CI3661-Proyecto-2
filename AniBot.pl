% Proyecto 2 Lab. Lenguajes de Progrmación
% integrantes:   Luis Marval 12-10620
%              Angel Morante 13-10931

:- dynamic(anime/1).
:- dynamic(genero/1).
:- dynamic(generoAnime/2).
:- dynamic(rating/2).
:- dynamic(popularidad/2).

anime(X) :- member(X,["Dragon Ball", "Naruto", "Bleach", "HunterXHunter", "Hamtaro", "Full Metal Alchemist"]).

genero(X) :- member(X,["Aventura", "Shoujo", "Shounen", "Kodomo", "Seinen", "Josei", "Ficción",
                    "Fantasía", "Mecha", "Sobrenatural", "Magia", "Gore"]).

generoAnime("Naruto",["Shounen","Aventura"]).
generoAnime("Dragon Ball",["Shounen"]).
generoAnime("Bleach",["Shounen", "Sobrenatural"]).
generoAnime("HunterXHunter",["Seinen", "Aventura"]).
generoAnime("Hamtaro",["Kodomo"]).
generoAnime("Full Metal Alchemist",["Shounen", "Magia"]).

rating("Dragon Ball",3).
rating("Naruto",1).
rating("Bleach",4).
rating("HunterXHunter",5).
rating("Hamtaro",2).
rating("Full Metal Alchemist",4).

popularidad("Dragon Ball",7).
popularidad("Naruto",5).
popularidad("Bleach",8).
popularidad("HunterXHunter",3).
popularidad("Hamtaro",10).
popularidad("Full Metal Alchemist",1).

% agregar anime. 
agregarAnime:- read(Anime), assert(anime(Anime)).

% imprimir lista
imprimirLista([]):- !.
imprimirLista([C|L]):- write(", "),write(C),imprimirLista(L).

% Sugerencias: dado un anime retornar animes del mismo genero.
sugerencias(A,L):- anime(A), !, generoAnime(A,G).

% funcion genero: recibir un genero y regresar un conjunto de animes.
% capaz es inecesario, pero vemos que el genero exista. Rev como manejar error
listadoGenero:- read(G), genero(G),!, 
findall( Anime, generoAnime(Anime, [G]), ListaA), 
                write("Estos son los animes de genero "), write(ListaA) . 
 
% Mejores ratings: 
% mejores(ListaRespuestas):- findall( Anime, rating(Anime, 5) , ListaRespuestas).
mejores:- findall( Anime, rating(Anime, 5) , ListaRespuestas), 
          write("Estos son los animes con mejores ratings"), imprimirLista(ListaRespuestas).

% funcion conoces: para al pasar un anime determinar si esta
% en la base de conocimientos y en caso de no ser asi agregar.
estaAnime(An):- anime(An), !, write("Lo conozco perro "),
write(An), write(" tiene rating "), rating(An,R), write(R), 
write(" y genero "), generoAnime(An,Gen), write(Gen), 
write(" , ademas es "), popularidad(An,Pop), popIntString(Pop). 

estaAnime(An):- write(" Ni idea de que me hablas bro, cual es su rating y genero? "), nl,
read(R), write(R), write("genero"), read(Gadi), genero(Gadi),!, write(Gadi), assert(anime(An)), 
assert(generoAnime(An,Gadi)), assert(rating(An,R)),assert(popularidad(An,1)).

% interesante, pero popularidad 
popIntString(P):- (P==1;P==2), write("Muy Poco Conocido"),!;
                  (P==3;P==4;P==5), write("Poco Conocido"),!;
                  (P==6;P==7), write("Conocido"),!;
                  (P==8;P==9), write("Muy Conocido"),!;
                   P==10, write("Bastante Conocido"),!.

%  variable Popularidad Mensaje
%      1 – 2    “Muy poco conocido”
muyPocoConocido:- findall( Anime, popularidad(Anime, 1); popularidad(Anime, 2), ListaMuyPoco), 
                  write("Estos son los muy poco conocidos "), write(ListaMuyPoco).
%      3 – 5     “Poco conocido”
pocoConocido:- findall( Anime, popularidad(Anime, 3); popularidad(Anime, 4); popularidad(Anime, 5), ListaPoco), 
               write("Estos son los poco conocidos "), write(ListaPoco).
%      6 – 7       “Conocido”
conocido:- findall( Anime, popularidad(Anime, 6); popularidad(Anime, 7), ListaCon), 
           write("Estos son los conocidos "), write(ListaCon).
%      8 – 9     “Muy conocido”
muyConocido:- findall( Anime, popularidad(Anime, 8); popularidad(Anime, 9), ListaMuyCon), 
              write("Estos son los muy conocidos "), write(ListaMuyCon).
%        10    “Bastante conocido”
bastanteConocido:- findall( Anime, popularidad(Anime, 10), ListaBastante), 
                  write("Estos son los bastante conocidos "), write(ListaBastante).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main
%anibot:- 
readList(L):- read_line_to_codes(user_input,Cs), atom_codes(A, Cs), atomic_list_concat(L, ' ', A).

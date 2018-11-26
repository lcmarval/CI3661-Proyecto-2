% Proyecto 2 Lab. Lenguajes de Progrmación
% integrantes:   Luis Marval 12-10620
%              Angel Morante 13-10931

% Hacer las bases de conocimiento dinamicas, para poder agregar elementos.
:- dynamic(anime/1).
:- dynamic(genero/1).
:- dynamic(generoAnime/2).
:- dynamic(rating/2).
:- dynamic(popularidad/2).

% Bases de conocimientos.
anime(X) :- member(X,["Dragon Ball", "Naruto", "Bleach", "HunterXHunter", "Hamtaro", 
	                "Full Metal Alchemist","Shingeki No Kyojin", "Swort Art Online", 
	                "One Piece", "Ghost in the Shell", "Kuroko no Basket", "Ace of Diamond",
	                "Gintama", "Toradora", "Hajime no Ippo"]).

genero(Y) :- member(Y,["Aventura", "Shoujo", "Shounen", "Kodomo", "Seinen", "Josei", "Ficción",
                    "Fantasía", "Mecha", "Sobrenatural", "Magia", "Gore", "Acción", "Drama", 
                    "Comedia", "Deportes", "Romance"]).

generoAnime("Naruto",["Shounen","Aventura"]).
generoAnime("Dragon Ball",["Shounen"]).
generoAnime("Bleach",["Shounen", "Sobrenatural"]).
generoAnime("HunterXHunter",["Seinen", "Aventura"]).
generoAnime("Hamtaro",["Kodomo"]).
generoAnime("Full Metal Alchemist",["Shounen", "Magia"]).
generoAnime("Shingeki No Kyojin",["Acción"]).
generoAnime("Swort Art Online",["Drama", "Comedia"]).
generoAnime("One Piece",["Acción", "Drama"]).
generoAnime("Ghost in the Shell", ["Ficción"]).
generoAnime("Kuroko no Basket", ["Drama", "Deportes"]).
generoAnime("Ace of Diamond", ["Drama", "Deportes"]).
generoAnime("Gintama", ["Comedia"]).
generoAnime("Toradora", ["Romance"]).
generoAnime("Hajime no Ippo", ["Acción", "Deportes"]).

rating("Dragon Ball",3).
rating("Naruto",1).
rating("Bleach",4).
rating("HunterXHunter",5).
rating("Hamtaro",2).
rating("Full Metal Alchemist",4).
rating("Shingeki No Kyojin",4).
rating("Swort Art Online",3).
rating("One Piece",5).
rating("Ghost in the Shell",1).
rating("Kuroko no Basket",2).
rating("Ace of Diamond", 1).
rating("Gintama", 3).
rating("Toradora" ,2).
rating("Hajime no Ippo", 1).

popularidad("Dragon Ball",7).
popularidad("Naruto",5).
popularidad("Bleach",8).
popularidad("HunterXHunter",3).
popularidad("Hamtaro",10).
popularidad("Full Metal Alchemist",1).
popularidad("Shingeki No Kyojin",9).
popularidad("Swort Art Online",6).
popularidad("One Piece",7).
popularidad("Ghost in the Shell",2).
popularidad("Kuroko no Basket",4).
popularidad("Ace of Diamond", 3).
popularidad("Gintama", 3).
popularidad("Toradora", 2).
popularidad("Hajime no Ippo", 1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funciones:
%
% imprimir lista
imprimirLista([]):- !.
imprimirLista([C|L]):- write(", "),write(C),imprimirLista(L).

% funcion genero: recibir un genero y regresar un conjunto de animes.
% Vemos que el genero exista. 
listaGenero(Genero,Lanime):- genero(Genero), !, 
        findall( Anim, (generoAnime(Anim,ListGenero),member(Genero,ListGenero)), Lanime). 

% en caso que Genero no este en genero(X)
listaGenero(_,[]):- write(" El genero no pertenece a los que conozco").

listaRating(Genero,Lr):-  
  findall( (Anim,R), (generoAnime(Anim,ListGenero),member(Genero,ListGenero),rating(Anim,R)), Lr). 

listaPopularidad(Genero,Lp):-  
  findall( (Anim,P), (generoAnime(Anim,ListGenero),member(Genero,ListGenero),popularidad(Anim,P)), Lp).

listaPyR(Genero,LpYr):-
  findall( (Anim,Y ), (generoAnime(Anim,ListGenero),member(Genero,ListGenero),popularidad(Anim,P),rating(Anim,R),Y is P+R), LpYr).

% Se Ordena por rating y/o popularidad. 
listaGeneroOrd(Lista,ListaOrd):- listaGeneroOrd(Lista,@>,ListaOrd).
listaGeneroOrd(Lista,Ord,ListaOrd):- sort(2,Ord,Lista,ListaOrd).

% Funcion para poder mostar los animés con X número de estrellas 
% dentro de cierto género (el género es un estado del chatbot que se debe conocer).
animeEstrellas(Genero,X,La):- listaGenero(Genero,Lg),
        findall( Anime, (member(Anime,Lg),rating(Anime, X)) , La). 
          %write("Estos son los animes con "), write(X), 
          %write(" estrellas de genero "), write(Genero), imprimirLista(La).

% Funcion para poder mostrar los animés buenos poco conocidos. 
% Aquí se hace referencia a rating alto con popularidad baja.
aBuenoPoco(Lista):- 
  findall(Anime, (rating(Anime,R),R>3,popularidad(Anime,P),P<6), Lista).  

% Funcion para poder agregar a la base de datos un anime con su género y rating, 
% si no está en la misma. La popularidad es opcional especificarla al agregarlo y por defecto es 1.
estaAnime(An):- anime(An), !, write("Lo conozco perro "),
write(An), write(" tiene rating "), rating(An,R), write(R), 
write(" y genero "), generoAnime(An,Gen), write(Gen), 
write(" , ademas es "), popularidad(An,Pop), popIntString(Pop). 

estaAnime(An):- write(" Ni idea de que me hablas bro, cual es su rating? "), nl,
read(R), nl, write("y su genero? "), read(Gadi), genero(Gadi),!, write(Gadi), assert(anime(An)), 
assert(generoAnime(An,Gadi)), assert(rating(An,R)),assert(popularidad(An,1)).

% Para devolver mensaje. 
popIntString(P):- (P==1;P==2), write("muy poco conocido"),!;
                  (P==3;P==4;P==5), write("poco conocido"),!;
                  (P==6;P==7), write("conocido"),!;
                  (P==8;P==9), write("muy conocido"),!;
                   P==10, write("bastante conocido"),!.

% Funcion para subir la popularidad del anime si los usuarios preguntan por él 5 o más veces.

% Predicado que actualiza la cantidad de veces que se ha preguntado por un anime.
consultado(Anime,N) :- retract(consultado(Anime, N)), Consultas is N+1, assert(preguntado(Anime,Consultas)), !.

% Predicado que reinicia el valor de Veces a 0 cuando ya se ha preguntado 5 veces por un anime.
pregCero(Anime) :- retract(preguntado(Anime, _)), VecesNuevo is 0, assertz(preguntado(Anime,VecesNuevo)), !.

% Predicado que aumenta en uno (1) la popularidad de un anime dado
subirPop(Anime) :- preguntado(Anime, Veces), Veces > 4, retract(popularidad(Anime, Nivel)), NivelNuevo is Nivel+1, assertz(popularidad(Anime,NivelNuevo)), pregCero(Anime), !.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main
aniBot:- write("Bienvenido soy AniBot hablame: -> "),
             repeat,
                readln(X), nl,
                emitirRespuestaAutomata(X, Respuesta),
                transform_to_string(Respuesta, Salida),
                write(Salida),
            se_salio(Salida),
            !.
            
:- aniBot,nl,nl.
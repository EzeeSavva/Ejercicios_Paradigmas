tweet(id, contenido, fecha(dia, mes,anio)).

usuario(username, nombre, clasificacion).

clasificacion(premium).
clasificacion(administrador).
clasificacion(normales).

darLike(idTweet, persona).
darDislike(idTweet, persona).

sigueA(usuario, otroUsuario). %%El otro usuario sigue a usuario.

estaRegistrado(username, nombre).

tweet(15, "Viva peron, carajo!!!", fecha(10, 12, 2011)).

posteo(15, elfedi).

tweet(3, "Prolog?", fecha(4, 12, 2011)).

posteo(3, maiiiii).

sigueA(elfedi, maiiiii).

darDislike(15, maiiiii).

usuario(_, ale,_, _).

tweet(1, "CABANI TE CRUSO Y SOS POYO", fecha(4,11,2023)).

darDislike(15, maiiiii).

posteo(1, luchitocabj).

retweet(15, luchitocabj).

darLike(1, xxxjoacoxxx).

vioElPost(1, mili).

vioElPost(1, rama).

tweet(2, "quien para un lol?", fecha(1,1,2012)).

posteo(2, camilazzati).

sigueA(camilazzati, catalapridaaa).

% 2).
tweetValido(IdTweet):-
    tweet(IdTweet, Contenido, _),
    string_length(Contenido, Largo),
    Largo <= 140.

%3. 
ratio(IdTweet, Ratio):-
    tweet(IdTweet,_,_),
    findall(_, darLike(IdTweet, _), ListaLikes),
    length(ListaLikes, TotalLikes),
    findall(_, darDislike(IdTweet, _), ListaDislikes),
    length(ListaDislikes, TotalDislikes),
    Ratio is (TotalLikes - TotalDislikes).


%4.
esTroll(Usuario):-
    postRagebait(Usuario).

esTroll(Usuario):-
    postFacto(Usuario).

postRagebait(Usuario):-
    usuario(Usuario,_,premium),
    posteo(IdTweet, Usuario),
    tweet(IdTweet, Contenido,_),
    ends_with("?", Contenido). 

postFacto(Usuario):-
    usuario(Usuario,_,Clasificacion),
    posteo(IdTweet,Usuario),
    tweet(IdTweet,_,_),
    Clasificacion /= administrador,
    not tweetValido(IdTweet),
    ratio(IdTweet, Ratio),
    Ratio < 0.


%5.

estanEntongados(Usuario, OtroUsuario):-
    esTroll(Usuario),
    esTroll(OtroUsuario),
    seSiguen(Usuario,OtroUsuario),
    seLikearonPosts(Usuario,OtroUsuario).
    

seSiguen(Usuario,OtroUsuario):-
    sigueA(Usuario, OtroUsuario),
    sigueA(OtroUsuario,Usuario).

seLikearonPosts(Usuario,OtroUsuario):-
    forall(posteo(IdTweet,Usuario), darLike(IdTweet,OtroUsuario)),
    forall(posteo(IdTweet2,OtroUsuario), darLike(IdTweet2,Usuario)).

%6.
grokEstoEsPosta(IdTweet, Usuario):-
    esTroll(Usuario).

grokEstoEsPosta(IdTweet, Usuario):-
    tweet(IdTweet, Contenido, _),
    words(Contenido, ListaPalabras),
    member(Palabra, ListaPalabras),
    gradoDecerteza(Palabra,NumeroCerteza),
    NumeroCerteza > 9.
    




    




    







 

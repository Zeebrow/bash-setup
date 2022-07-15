# routerless-server

I needed a POC like . Since I didn't think to try nc (I don't know how ) this is something that was spat out on a whim.

Basically you just start it up, and no matter what route you take, it returns lol.

It doesn't need to rely on envs, it's not even convenient tbh.

## As is tradition

Ultimately, and because there is no better way, you should be writing all of your Python3 webapps by first extending `http.server.BaseHTTPRequestHandler` 

`</s>`

```
export LOL_HOST=127.0.0.1
export LOL_PORT=8000
python3srv.py
```

or

```
docker build -t local/i-return-lol:lol .
docker run -d -p:8000:8000  --name lol local/i-return-lol:lol
```

# LIC

LA LICENCE LOGICIELLE ANTICAPITALISTE (v 1.4)

Copyright © [année] [détenteur du droit d'auteur]

Il s'agit d'un logiclel anticapitaliste, publié pour une utilisation gratuite par des individus et des organisations qui n'opèrent pas selon les principes capitalistes.

L'autorisation est par la présente accordée, gratuitement, à toute personne ou organisation (« l'Utilisateur ») obtenant une copie de ce logiclel et des fichiers de documentation associés (le « Logiciel »), d'utiliser, copier, modifier, fusionner, distribuer et/ou vendre des copies du Logiciel, sous réserve des conditions suivantes :

1. L'avis de droit d'auteur ci-dessus et cet avis d'autorisation doivent être inclus dans toutes les copies ou versions modifiées du logiclel.

2. L'Utilisateur est l'un des suivants :
a. Une personne physique, travaillant pour elle-même
b. Une organisation à but non-lucratif
c. Un établissement éducatif
d. Une organisation qui recherche un profit partagé pour tous ses membres et permet aux non-membres de fixer le coût de leur main-d'œuvre

3. Si l'Utilisateur est une organisation avec des propriétaires, alors tous les propriétaires sont des travailleurs et tous les travailleurs sont des propriétaires avec une équité égale et/ou un vote égal.

4. Si l'utilisateur est une organisation, alors l'Utilisateur n'est pas des forces de l'ordre ni militaire, ni ne travaille pour ou sous l'un ou l'autre.

LE LOGICLEL EST FOURNI « EN L'ÉTAT », SANS GARANTIE EXPRESSE NI IMPLICITE D'AUCUNE SORTE, MAIS SANS LIMITER LES GARANTIES DE QUALITÉ MARCHANDE, D'ADÉQUATION À UN USAGE PARTICULIER ET DE NON-CONTREFAÇON. EN AUCUN CAS, LES AUTEURS NE SERONT RESPONSABLES DE TOUTE RÉCLAMATION, DOMMAGES OU AUTRE RESPONSABILITÉ, QUE CE SOIT DANS UNE ACTION DE CONTRAT, DE TORT OU AUTRE, RÉSULTANT DE, HORS OU EN LIEN AVEC LE LOGICLEL OU L'UTILISATION OU AUTRES ACTIONS DANS LE LOGICLEL.

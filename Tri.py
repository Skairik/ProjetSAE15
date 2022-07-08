import os
import numpy as np
import typing

#______________A MODIFIER_____________________________________
#Chemin du fichier texte à traiter
fichiertxt="C:\\Users\\atom\\Programmes\\user.txt"
#Chemin du fichier csv qui sera enregistrer
fichiercsv="C:\\Users\\atom\\Programmes\\test.csv"

#_____________________________________________________________

try:
    with open(fichiertxt, encoding="utf8") as fh:
        res=fh.read()
except:
        print("Le fichier n'existe pas %s", os.path.abspath("--"))
ress=res.split('\n')
tableau_evenements=np.array([])
fic=open(fichiercsv,"w")
test = 0
nbrdouble = 0
evenement="Nom ; OU ; DC ; Statut"
fic.write(evenement + "\n")
characters = "Nigay Users"
for event in ress:
    #Vérification bonne ligne
    texte = event.split(",")
    if len(texte) > 1:
        test = 1
    else :
        test = 0
    #Si ligne correspond au ligne qui a les données
    if test == 1 :
        #Remise à zero des variables
        nom =''
        OU=''
        DC=''
        nbrdouble = nbrdouble + 1
        #ALL
        for i in texte :
            splitegal = i.split("=")
            splitegal[1] = splitegal[1].replace(characters,"")
            if splitegal[0] == "CN":
                nom=splitegal[1]
            if splitegal[0] == "OU":
                OU=OU + " " + splitegal[1]
            if splitegal[0] == "DC":
                DC=DC + " " + splitegal[1]
        evenement=nom + ';' + OU  + ';' + DC 
        fic.write(evenement + "\n")
fic.write(str(nbrdouble)+"doublons restants")

import os
import numpy as np
import typing
import datetime

try:
    with open("C:\Users\tmalosse\Documents\Programmes\user.txt", encoding="utf8") as fh:
        res=fh.read()
except:
        print("Le fichier n'existe pas %s", os.path.abspath("--"))
ress=res.split('\n')
tableau_evenements=np.array([])
fic=open("C:\Users\tmalosse\Documents\Programmes\test.csv","w")
test = 0
nbrdouble = 0
evenement="Nom ; OU ; DC "
fic.write(evenement + "\n")
characters = ":"
for event in ress:
    #Vérification bonne ligne
    texte = event.split(",")
    if len(texte) > 1:
        test = 1
    else :
        test = 0
    #Trie de la ligne contenant les infos sur la trame
    if test == 1 :
        #Remise à zero des variables
        nom =''
        OU=''
        DC=''
        nbrdouble = nbrdouble +1
        #ALL
        for i in texte :
            splitegal = i.split("=")
            if splitegal[0] == "CN":
                nom=splitegal[1]
            if splitegal[0] == "OU":
                OU=OU + splitegal[1]
            if splitegal[0] == "DC":
                DC=DC + splitegal[1]
        evenement=nom + ';' + OU  + ';' + DC 
        fic.write(evenement + "\n")
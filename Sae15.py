import os
import numpy as np
import typing
import datetime

try:
    with open("C:/Users/tommo/Documents/GitHub/ProjetSAE15/sae15.txt", encoding="utf8") as fh:
        res=fh.read()
except:
        print("Le fichier n'existe pas %s", os.path.abspath("--"))
ress=res.split('\n')
tableau_evenements=np.array([])
fic=open("C:/Users/tommo/Documents/GitHub/ProjetSAE15/test.csv","w")
test = 0
nbrtrame = 0
evenement="Heure ; Envoyeur ; Port ; Destinataire ; Flag ; Seq ; Ack ; Win ; Options ; Length"
fic.write(evenement + "\n")
characters = ":"
for event in ress:
    #Vérification bonne ligne
    texte = event.split(":")
    if len(texte) > 2:
        test = 1
    else :
        test = 0
    #Trie de la ligne contenant les infos sur la trame
    if test == 1 :
        seq = ''
        ack=''
        win=''
        option = ''
        length = ''
        testip1 = ''
        port =''
        destination = ''
        expediteur=''
        nbrtrame = nbrtrame +1
        #Ajout heure
        texte = event.split(' ')
        heure = texte[0]
        #Expediteur
        testip1=texte[2].split(".")
        if len(testip1) > 1 :
            if len(testip1)==2:
                expediteur=testip1[0]
                port = testip1[1]
            if len(testip1)==3:
                expediteur=testip1[0] +'.' + testip1[1]
                port = testip1[2]
            if len(testip1)==4:
                expediteur=testip1[0] +'.' + testip1[1] +'.' + testip1[2]
                port = testip1[3]
            if len(testip1)==5:
                expediteur=testip1[0] +'.' + testip1[1] +'.' + testip1[2] +'.' + testip1[3]
                port = testip1[4]
            if len(testip1) == 6 :
                expediteur=testip1[0] +'.' + testip1[1] +'.' + testip1[2] +'.' + testip1[3] +'.' + testip1[4]
                port = testip1[5]
            if len(testip1) == 7 :
                expediteur=testip1[0] +'.' + testip1[1] +'.' + testip1[2] +'.' + testip1[3] +'.' + testip1[4] +'.' + testip1[5]
                port = testip1[6]
            if len(testip1) == 8 :
                expediteur=testip1[0] +'.' + testip1[1] +'.' + testip1[2] +'.' + testip1[3] +'.' + testip1[4] +'.' + testip1[5] +'.' + testip1[6]
                port = testip1[7]
        else :
            expediteur=texte[2]
            port = ''
        #Destination
        destination = texte[4]
        destination = destination.replace(characters,"")
        #Flag
        texte=event.split("[")
        if len(texte) > 1:
            testflag=texte[1].split("]")
            flag=testflag[0]
        #seq et ack
        texte=event.split(",")
        if len(texte)>3:
            #Si commence par Seq
            if texte[1].startswith(" seq"):
                testseq=texte[1].split(" ")
                seq=testseq[2]
                ack=''
            #Si commence par ack sans Seq 
            if texte[1].startswith(" ack"):
                testack=texte[1].split(" ")
                ack=testack[2]
                seq=''
            #Ack avec seq avant
            if texte[2].startswith(" ack"):
                testack=texte[2].split(" ")
                ack=testack[2]
            #Win si pas ack ou pas Seq
            if texte[2].startswith(" win"):
                testwin=texte[2].split(" ")
                win=testwin[2]
            #Win si ack+seq
            if texte[3].startswith(" win"):
                testwin=texte[3].split(" ")
                win=testwin[2]
        else:
            seq = ''
            ack=''
            win=''
            option = ''
        #Pour lenght quand ni option ni 1 autre 
        if len(texte)==4:
            if texte[3].startswith(" length"):
                testlength=texte[3].split(" ")
                length = testlength[2]
                length = length.replace(characters,"")
        #Pour lenght quand pas d'option 
        if len(texte)==5:
            if texte[4].startswith(" length"):
                testlength=texte[4].split(" ")
                length = testlength[2]
                length = length.replace(characters,"")
        #Pour lenght avec option
        texte=event.split("]")
        if len(texte) > 2 :
            testlength = texte[2].split(" ")
            length = testlength[2]
            length = length.replace(characters,"")
        #Option si y'a 3 partie quand je split [ (flag et option)
        texte=event.split("[")
        if len(texte)>2:
            texte2=texte[2].split("]")
            option=texte2[0]
        else:
            option=''
        evenement=heure + ';' + expediteur  + ';' + port + ';' + destination + ';' + flag + ';' + seq + ';' + ack + ';' + win + ";" + option + ';'+ length
        fic.write(evenement + "\n")

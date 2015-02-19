#!/usr/bin/python

import math
import struct
import json

class forma():

    def __init__(self,x=0,y=0):
        self.x=int(x)
        self.y=int(y)
        self._nume="forma"

    def deseneaza(self):
        return("{0.getType}: x={0.x}, y={0.y}".format(self))

    def aria(self):pass

    @property
    def getType(self):
        return(self._nume)

    @property
    def getSpecs(self):
        return(self.x,self.y)

class dreptunghi(forma):

    def __init__(self,x,y,h,w):
        super().__init__(x,y)
        self.h=float(h)
        self.w=float(w)
        self._nume="dreptunghi"

    def aria(self):
        return(self.h*self.w)

    @property
    def getSpecs(self):
        #can we inherit x,y??
        return(self.x,self.y,self.h,self.w)

class patrat(dreptunghi):

    def __init__(self,x,y,h):
        super().__init__(x,y,h,h)
        self._nume="patrat"

    @property
    def getType(self):
        return("patrat")

    @property
    def getSpecs(self):
        return(self.x,self.y,self.h)
            
class cerc(forma):

    def __init__(self,x,y,r):
        super().__init__(x,y)
        self.r=float(r)
        self._nume="cerc"

    def aria(self):
        return(math.pi*pow(self.r,2))

    @property
    def getType(self):
        return("cerc")

    @property
    def getSpecs(self):
        return(self.x,self.y,self.r)

class scena():

    def __init__(self):
        self.lista=[]

    def deseneazaScena(self):
        """itereaza toate figurile de pe scena
        afiseaza figurile
        """
        for index,forma in enumerate(self.lista):
            print("{0}: {1}".format(index,forma.deseneaza()))
        
    def ariaTotala(self):
        ariaTotala=0
        for forma in self.lista:
            ariaTotala+=forma.aria()
        return ariaTotala

    def eliminareForma(self,nivel):
        """elimina toate formele <= nivel
        """
        for i in range(nivel+1):
            del self.lista[i]

    def adaugaForma(self,forma):
        self.lista.append(forma)

    def scoateForma(self,nivel):
        """scoate forma de pe scena si o returneaza
        """
        del self.lista[nivel]

    def salvezScena(self,filename):
        fh=open(filename,"w")
        for forma in self.lista:
            fh.write(forma.getType+",")
            for spec in forma.getSpecs:
                fh.write(str(spec)+",")
            fh.write("\n")
        fh.close()

    def restaurezScena(self,filename):
        listFromFile=[]
        fh=open(filename,"r")
        for line in fh:
            elems=line.split(",")
            elems.pop()#scoatem campul gol de dupa ultima virgula
            if (elems[0]=="forma"):
                listFromFile.append(forma(*elems[1:]))
            if (elems[0]=="dreptunghi"):
                listFromFile.append(dreptunghi(*elems[1:]))
            if (elems[0]=="patrat"):
                listFromFile.append(patrat(*elems[1:]))
            if (elems[0]=="cerc"):
                listFromFile.append(cerc(*elems[1:]))
        fh.close()
        self.lista=listFromFile

#main#
        
s=scena()
s.adaugaForma(dreptunghi(1,2,2,5))
s.adaugaForma(patrat(1,2,5))
s.adaugaForma(cerc(1,2,5.5))
s.adaugaForma(patrat(4,5,10))

s.deseneazaScena()
print(s.ariaTotala())

#s.salvezScena("./scena.csv")
f=open('./scena.json','w')
json.dump(s,f)
f.close()

z=scena()
#z.restaurezScena("./scena.csv")
f=open('./scena.json','r')
z=json.load(f)
f.close()

z.deseneazaScena()
print(z.ariaTotala())


import matplotlib.pyplot as plt
import pandas as pd
import os 
import sys
import warnings
warnings.filterwarnings("ignore")

def tryOpen(path, settings):
    try:
        f = open(path, settings)
    except FileNotFoundError:
        return None
    return f

def tryGetLine(file):
    l = file.readline().strip()
    return l

class Data:
    
    """
    Create class
    """
    def __init__(self, length=0, filename="", extension=""):
        self.length = length
        self.filename = filename
        self.extension = extension
        self.df = None
        self.names = [ None ] * max(self.length, 1)
        
    """
    Load Settings from path settings file
    """
    def LoadSettings(self, path="settings.ini"):
        f = tryOpen(path, "r")
        if not f or not self.ReadSettings(f):
            print("Incorrect format for file, appling default...")
            self.ApplyDefaultSettings()
        if f:
            f.close()
    
    """
    Read the settings from file-object
    return true if settings read
    return false if not enough lines and load default
    """
    def ReadSettings(self, file):
        # read length
        line = tryGetLine(file)
        if not line:
            return False
        self.length = int(line)
        self.names = [ None ] * max(self.length, 1)
        
        # read filename
        line = tryGetLine(file)
        if not line:
            return False
        self.filename = line
        
        # read extension
        line = tryGetLine(file)
        if not line:
            return False
        self.extension = line
        
        # read names
        for i in range(self.length):
            line = tryGetLine(file)
            if not line:
                self.names[i] = i
            self.names[i] = line
        return True
    
    """
    Applies default settings for object
    """
    def ApplyDefaultSettings(self):
        self.length = 5
        self.filename = "data"
        self.extension = "data"
        self.names = [str(i) for i in range(max(self.length, 1))]
        
    """
    Open data in panda data frame object
    """
    def OpenData(self):
        d = []
        for i in range(self.length):
            text = self.filename + str(i) + "." + self.extension
            arr = []
            f = tryOpen(text, "r")
            if f:
                for line in f:
                    arr.append(float(line))
                f.close()
            d.append(arr)
        self.df = (pd.DataFrame(data=d)).transpose()
        (self.df).columns = columns=self.names
    
    """
    Get statistical data
    """
    def PrintStat(self):
        mean = self.df.mean(axis=0).array
        std = self.df.std(axis=0).array
        var = self.df.var(axis=0).array
        print("{:14} {:10} {:10} {:10}".format("Host", "mean", "stand dev", "variance"))
        for i in range(self.length):
            print("{:15} {:<10.4f} {:<10.4f} {:<10.4f}".format(self.names[i], mean[i], std[i], var[i]))

    
    """
    Outpout histogram of datafram to .png
    """
    def OutpoutHistogram(self, path="histogram.png"):
        fig, ax = plt.subplots()
        (self.df).hist(ax=ax)
        fig.savefig(path)
        
    """
    Bloxpot histogram of datafram to .png
    """
    def OutpoutBloxpot(self, path="bloxpot.png"):
        fig, ax = plt.subplots()
        (self.df).boxplot(ax=ax)
        fig.savefig(path)


def main():
    data = Data()
    data.LoadSettings(sys.argv[1]) if len(sys.argv) > 1 else data.LoadSettings()
    data.OpenData()
    data.OutpoutHistogram()
    data.OutpoutBloxpot()
    
    data.PrintStat()
    
main()
import os, fnmatch

accept = 'n'


def entryQuestin():
    proj = input("Podaj ścieżkę do projektów: \n")
    smd_or_app = input("Edycja pliku smd czy app?\n")
    before = input("Jaki fragment zmieniamy?\n")
    after = input("Na co go zmieniamy?\n")
    print("------------")
    print(
        'Podałeś następujące parametry:\nŚcieżka:{}\nEdycja pliku:{}\nCo zmieniamy:{}\nNa co zmieniamy:{}'.format(
            proj, smd_or_app, before, after))
    return proj, smd_or_app, before, after


def showReplaceProject(proj, exept=[]):
    print("\nZmiany zostaną naniesione w środowiskach: ")
    for i in os.listdir(proj):
        if i in exept:
            continue
        else:
            print(i)


def checkCorrectParameters(proj, smd_or_app):
    if not os.path.exists(proj):
        print("Podałeś nieistniejącą ścieżkę")
        return False
    elif (smd_or_app != "smd") and (smd_or_app != "app"):
        print("Zły parametr smd lub app")
        return False
    elif (before == ""):
        print("Pusty parametr do zmiany")
        return False
    else:
        return True


def findReplace(directory, find, replace, filePattern):
    for path, dirs, files in os.walk(os.path.abspath(directory)):
        for filename in fnmatch.filter(files, filePattern):
            filepath = os.path.join(path, filename)
            with open(filepath) as f:
                s = f.read()
            s = s.replace(find, replace)
            with open(filepath, "w") as f:
                f.write(s)

def changeEnvironment():
    dropEnv = input("Podaj po spacji środowiska, w których nie dokonujesz zmian:\n")
    dropEnvList = dropEnv.split()
    return dropEnvList


def replaceMethod(smd_or_app, accept, replace=[]):
    if smd_or_app == "smd" and accept == "y":
        for i in os.listdir(proj):
            if i in replace:
                continue
            findReplace("{}/{}/neos".format(proj, i), "{}".format(before), "{}".format(after), "*.smd")
    elif smd_or_app == "app" and accept == "y":
        for i in os.listdir(proj):
            if i in replace:
                continue
            findReplace("{}/{}/teneum_client".format(proj, i), "{}".format(before), "{}".format(after), "*.app")


proj, smd_or_app, before, after = entryQuestin()

if checkCorrectParameters(proj,smd_or_app):
    showReplaceProject(proj)
    accept = input("Akceptujesz zmiany? [y/N]\n").lower()
else:
    print("\nParametry zostały podane niewłaściwie, spróbuj ponownie")
    entryQuestin()


if accept == 'y':
    replaceMethod(smd_or_app, accept)
else:
    change = input("Zmiany nie zostały zaakceptowane, chcesz dokonać korekty? [y/n]\n")
    if change == 'y':
        replace = changeEnvironment()
        showReplaceProject(proj, replace)
        accept = input("Akceptujesz zmiany? [y/N]\n").lower()
        replaceMethod(smd_or_app, accept, replace)
    else:
        print("Koniec")

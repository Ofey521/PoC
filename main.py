import os, fnmatch

print("Podaj ścieżkę do projektu")
proj = input()
print("Edycja pliku smd czy app?")
smd_or_app = input()
print("Co zmieniamy?")
before = input()
print("Na co zmieniamy?")
after = input()



def findReplace(directory, find, replace, filePattern):
    for path, dirs, files in os.walk(os.path.abspath(directory)):
        for filename in fnmatch.filter(files, filePattern):
            filepath = os.path.join(path, filename)
            with open(filepath) as f:
                s = f.read()
            s = s.replace(find, replace)
            with open(filepath, "w") as f:
                f.write(s)

if(smd_or_app == "smd"):
    for i in os.listdir(proj):
        if (i == ".DS_Store"):
            continue
        findReplace("{}/{}/neos".format(proj, i), "{}".format(before), "{}".format(after), "*.smd")
elif(smd_or_app == "app"):
    for i in os.listdir(proj):
        if (i == ".DS_Store"):
            continue
        findReplace("{}/{}/teneum_client".format(proj, i), "{}".format(before), "{}".format(after), "*.app")
else:
    print("Podałeś jakieś lipne wartości")
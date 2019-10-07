import sys

def parseData(dataToFill):
    parsedData = {}

    for data in dataToFill:
        keyVal = data.split(":")
	key = "{{{0}}}".format(keyVal[0])
	parsedData[key] = keyVal[1]

    return parsedData

def loadFileAsText(filePath):
    f = open(filePath,'r')
    contents = f.read()
    f.close()
    return contents

argumentList = sys.argv

if len(argumentList) <= 3:
    exit(-1)

templateFile = argumentList[1]
dataToFill = argumentList[2:]

data = parseData(dataToFill) 
template = loadFileAsText(templateFile)

for key, val in data.iteritems():
    template = template.replace(key, val)

print template

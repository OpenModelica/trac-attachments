import shutil
import os
from OMPython import OMCSessionZMQ

model="Buildings.Controls.OBC.ASHRAE.G36_PR1.AHUs.SingleZone.VAV.SetPoints.Supply"
parameters="(yHeaMax=0.7, yMin=0.3, TSupSetMax=303.15, TSupSetMin=289.15)"
omc = OMCSessionZMQ()
omc.sendExpression("loadModel(Buildings)")
omc.sendExpression("simulate({}, startTime=0, stopTime=3600, simflags=\"-csvInput reference_input.csv\", outputFormat=\"csv\")".format(model))
shutil.move("{}_res.csv".format(model), "reference.csv")

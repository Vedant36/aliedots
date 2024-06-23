#!/usr/bin/env python
import requests
import json
import sys
import os
import time
import pandas as pd

apifile = os.path.join(os.getenv("XDG_LIB_HOME",
                                 os.path.join(os.getenv("HOME"),
                                              ".local/lib")),
                       "private/neptune4_api.json")
datfile = os.getenv("HOME")+"/dox/_Other/datasets/np4/game_{}.json"
alliance_columns = ["Team Name", "Stars", "Ships", "Fleets",
                    "Eco", "Ind", "Sci", "B", "E", "M", "R", "W"]

if (len(sys.argv) < 3):
    print(f"Usage: {sys.argv[0]} [get|stat|log] <game_number>")
    os._exit(1)


def fetch_data(game_number, savefile, suppress_print=0):
    url = "https://np4.ironhelmet.com/api"

    with open(apifile, "r") as fp:
        api = json.load(fp)
    params = [i for i in api if i["game_number"] == game_number]
    if not params:
        print(f"I don't have an API key for game {sys.argv[2]}!")
        os._exit(1)

    response = requests.post(url, params=params[0])
    if (response.status_code == 200 and not suppress_print):
        print(f"Fetch successful. {len(response.text)} bytes fetched")
    data = json.loads(response.text)
    with open(savefile.format(game_number), "w") as fp:
        json.dump(data, fp, indent=4)
    return data


def alliance_stat(name, players):
    fields = list(0 for i in alliance_columns)
    fields[0] = name
    for i in players:
        fields[1] += i["totalStars"]
        fields[2] += i["totalStrength"]
        fields[3] += i["totalFleets"]
        fields[4] += i["totalEconomy"]
        fields[5] += i["totalIndustry"]
        fields[6] += i["totalScience"]
        fields[7]  = max(i["tech"]["0"]["level"], fields[7])
        fields[8]  = max(i["tech"]["1"]["level"], fields[8])
        fields[9]  = max(i["tech"]["2"]["level"], fields[9])
        fields[10] = max(i["tech"]["3"]["level"], fields[10])
        fields[11] = max(i["tech"]["5"]["level"], fields[11])
    return fields


if (sys.argv[1] == "get"):
    fetch_data(sys.argv[2], datfile)

elif (sys.argv[1] == "stat"):
    if not os.path.isfile(datfile):
        fetch_data(sys.argv[2], datfile)
    with open(datfile.format(sys.argv[2]), "r") as fp:
        data = json.load(fp)["scanning_data"]
    players = data["players"]
    data = []
    data.append(alliance_stat("Ours",   [players["1"], players["4"]]))
    data.append(alliance_stat("Yellow", [players["5"], players["6"]]))
    data.append(alliance_stat("Corner", [players["3"], players["8"]]))
    df = pd.DataFrame(data, columns=alliance_columns)
    print(df)

elif (sys.argv[1] == "log"):
    # incomplete. honestly dont wanna find their sleep schedules
    basedir = os.getenv("HOME") + "/.local/var/cache/np4"
    npdir = basedir+f"/{sys.argv[2]}"
    hour = time.localtime().tm_hour
    if not os.path.isdir(basedir):
        os.mkdir(basedir)
        if not os.path.isdir(npdir):
            os.mkdir(npdir)
    cur = fetch_data(sys.argv[2], npdir+f"/{hour}.json", 1)["scanning_data"]
    prevfile = npdir+f"/tmp/{(hour-1) % 24}.json"
    if not os.path.isfile(prevfile):
        os._exit(0)
    else:
        if os.path.getmtime(prevfile) - time.time() > 1000 * 3600 * 4:
            os._exit(0)
        with open(prevfile, "r") as fp:
            prev = json.load(fp)["scanning_data"]

    for i in range(cur["config"]["players"]):
        a =  cur["players"][str(i+1)]
        b = prev["players"][str(i+1)]
        if (a["totalFleets"] != b["totalFleets"] or
                a["totalEconomy"] != b["totalEconomy"] or
                a["totalIndustry"] != b["totalIndustry"] or
                a["totalScience"] != b["totalScience"]):
            print("{}, {}".format(i, hour - 1))

elif (sys.argv[1] == "plot"):
    import matplotlib.pyplot as plt
    df = pd.read_csv("~/.local/var/log/playerdata.csv", names=["player", "hour"])
    plt.scatter(df.player, df.hour)
    plt.show()

elif (sys.argv[1] == "diff"):
    basedir = os.getenv("HOME") + "/.local/var/cache/np4"
    npdir = basedir+f"/{sys.argv[2]}"
    with open(npdir+f"/{sys.argv[3]}.json", "r") as fp:
        prev = json.load(fp)["scanning_data"]
    with open(npdir+f"/{sys.argv[4]}.json", "r") as fp:
        cur = json.load(fp)["scanning_data"]
    for i in range(cur["config"]["players"]):
        a =  cur["players"][str(i+1)]
        b = prev["players"][str(i+1)]
        if (a["totalFleets"] != b["totalFleets"] or
                a["totalEconomy"] != b["totalEconomy"] or
                a["totalIndustry"] != b["totalIndustry"] or
                a["totalScience"] != b["totalScience"]):
            print("{}, {}".format(i, sys.argv[3]))

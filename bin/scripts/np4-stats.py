#!/usr/bin/env python
import requests
import json
import sys
import os
import time
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import math

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


def fetch_data(game_number, savefile, suppress_print=0, force_load=0):
    url = "https://np4.ironhelmet.com/api"
    datafile = savefile.format(game_number)

    if (not os.path.exists(datafile)
            or (time.time() - os.path.getmtime(datafile)) > 3600
            or force_load):
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

        with open(datafile, "w") as fp:
            json.dump(data, fp, indent=4)
    else:
        with open(datafile, "r") as fp:
            data = json.load(fp)
    return data


def alliance_stat(name, players):
    fields = list(0 for i in alliance_columns)
    fields[0] = name
    for i in players:
        tmp = i
        fields[1] += tmp["totalStars"]
        fields[2] += tmp["totalStrength"]
        fields[3] += tmp["totalFleets"]
        fields[4] += tmp["totalEconomy"]
        fields[5] += tmp["totalIndustry"]
        fields[6] += tmp["totalScience"]
        fields[7]  = max(tmp["tech"]["0"]["level"], fields[7])
        fields[8]  = max(tmp["tech"]["1"]["level"], fields[8])
        fields[9]  = max(tmp["tech"]["2"]["level"], fields[9])
        fields[10] = max(tmp["tech"]["3"]["level"], fields[10])
        fields[11] = max(tmp["tech"]["5"]["level"], fields[11])
    return fields


if (sys.argv[1] == "get"):
    fetch_data(sys.argv[2], datfile, force_load=1)

elif (sys.argv[1] == "stat"):
    scanning_data = fetch_data(sys.argv[2], datfile)["scanning_data"]
    players = scanning_data["players"]
    data = []
    data.append(alliance_stat("good", [players["1"], players["2"]]))
    data.append(alliance_stat("evil", [players["7"], players["8"]]))
    for i in range(scanning_data["config"]["players"]):
        if len(sys.argv) > 3:
            data.append(alliance_stat(players[str(i+1)]["alias"], [players[str(i+1)]]))
    df = pd.DataFrame(data, columns=alliance_columns)
    print(df.to_string())

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

elif (sys.argv[1] == "ships"):
    data = fetch_data(sys.argv[2], datfile)["scanning_data"];
    num_ticks = 20 if len(sys.argv) < 4 else int(sys.argv[3])
    ticks = np.arange(num_ticks)
    # np4's pallette
    colors = ["#0000ff", "#009fdf", "#40c000", "#ffc000",
              "#df5f00", "#c00000", "#c000c0", "#6000c0"]
    ax = plt.axes()
    ax.set_facecolor("grey")
    for i in data["players"]:
        tmp = data["players"][i]
        ships = tmp["totalStrength"]
        X = tmp["tech"]["2"]["level"]
        Y = tmp["totalIndustry"]
        y = ships + (Y * (X + 4))/24 * ticks
        plt.plot(ticks, y, color=colors[tmp["color"]], label=tmp["alias"])
    plt.legend()
    plt.show()

elif (sys.argv[1] == "res"):
    print("This scriptlet shows how many of each resource you can buy")
    data = fetch_data(sys.argv[2], datfile)["scanning_data"];
    players = data["players"]
    me = [i for i in players if (players[i]["alias"] == "Vedant36") or ("war" in players[i])]
    if (not me):
        print("I'm not there in this game")
        os._exit(1)
    me = int(me[0])
    cash = players[str(me)]["cash"] if len(sys.argv) < 4 else int(sys.argv[3])
    print(f"I have {cash} credits")
    stars = []
    for n,c in enumerate(data["stars"]):
        i = data["stars"][c]
        if i["puid"] == me:
            stars.append([int(c), i["r"], i["e"], i["i"], i["s"]])
    stars = np.asarray(stars)
    cost = [500, 1000, 4000]
    bought = [0, 0, 0]
    for j in [2,3,4]:
        cashtmp = cash
        startmp = stars.copy()
        while cashtmp > 0:
            minval, minidx = np.inf, 0
            for n,i in enumerate(startmp):
                val = cost[j-2] * (i[j] + 1) / i[1]
                if val < minval:
                    minval = val
                    minidx = n
            print(f'cost:{math.floor(minval):>3}, name:{data["stars"][str(stars[minidx][0])]["n"]}')
            if minval < cashtmp:
                startmp[minidx][j] += 1
                cashtmp -= math.floor(minval)
                bought[j-2] += 1
            else:
                break
        print(f"Bought {bought[j-2]}, left {cashtmp}")
    print(f"Bought max E{bought[0]} I{bought[1]} S{bought[2]}")

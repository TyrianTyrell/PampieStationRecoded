

/mob/proc/texttospeech(var/text)

	spawn(0)
		var/name2
		if (!name2)
			if(!src.ckey || src.ckey == "")
				name2 = "\ref[src]"
			else
				name2 = src.ckey
		var/list/voiceslist = list()

		voiceslist["msg"] = text
		voiceslist["ckey"] = name2
		var/params = list2params(voiceslist)

		text2file(params,"scripts/voicequeue.txt")

		shell("Code.exe")


/client/proc/texttospeech(var/text, var/clientkey)
	spawn(0)
		var/list/voiceslist = list()

		voiceslist["msg"] = text
		voiceslist["ckey"] = clientkey
		var/params = list2params(voiceslist)
		params = replacetext(params, "&", "^&")

		call("writevoice.dll", "writevoicetext")(params)
		shell("cmd /C echo [params]>>scripts\\voicequeue.txt")

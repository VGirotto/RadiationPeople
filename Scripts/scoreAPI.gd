#extends Node
#
#
##func createGame(game: String) -> None:
###	"""
###	Will create a game if a game by that name has not already been created
###	game is the name of your game
###	syntax: `createGame(GameName)`
###	returns: `None`
###	"""
##	try:
##		r = requests.post(
##			"http://galfar.dyndns.org:25577/reggame/?game={game}".format(game=game)
##		)
##	except Exception as e:
##		# Something went wrong!
##		print("Something went wrong! error: " + String(e))
##
##func createUser(game: String,user: String, args: dict) -> String:
###	"""
###	Will create a user if a user by that name has not already been created on that game
###	info:
###	game is the name of your game
###	user is the user that you're trying to set
###	args is the default values for ex. Highscore so {"Highscore": 999}
###	will return the secret for the created user if it succeded
###	will return "ERR" if it cannot connect to the api
###	if the user has already been created it will not return the secret key and instead it will return "already in the system! forgot secret? contact: galfar#1954"
###	syntax: `createUser(GameName, Username, Args)`
###	returns: `str`
###	"""
##
##	try:
##		r = requests.post(
##			"http://galfar.dyndns.org:25577/register/?game={game}&username={username}&args={args}".format(game=game,username=user,args=json.dumps(args))
##		)
##		return r.text
##	except Exception as e:
##		# Something went wrong!
##		print("Something went wrong! error: " + String(e))
##		return "ERR"
##
##func setHighScore(game: String, user: String, secret: String, data: dict) -> None:
###	"""
###	Sets a highscore of a game and user and secret
###	info:
###
###	game is the name of your game
###	user is the user that you're trying to set
###	secret is the secret that is generated when you create a user the secret key ONLY works with the user it was created with
###	data is the updated highscores you want to upload to the api
###	syntax: `setHighScore(GameName, Username, Secret, Data)`
###	returns: `None`
###	"""
##	try:
##		# formating the dict to json
##		data = json.dumps(data)
##		r = requests.post(
##			"http://galfar.dyndns.org:25577/?game={game}&user={user}&secret={secret}&highscore={data}".format(game=game, user=user, secret=secret, data=data)
##		)
##
##	except Exception as e:
##		# Something went wrong!
##		print("Something went wrong! error: " + String(e))
#
#func getHighScore(game: String):
##	"""
##	gets the highscore of a game
##	syntax: `getHighScore(game)`
##	returns: `dict`
##	"""
#	# gets every data, we want to pick only users data
#	# user can be only a string
#	# getting all data here
##	try:
#
#	var r = HTTPClient.connect_to_host("http://galfar.dyndns.org:25577/")
#
#	# formating it into dict from json
#	data = json.loads(r.content)
#
#	# getting users data
#	gamedata = data[game]
#
#	# returning the dictionary with high scores, yay!
#	return gamedata
#
##	except Exception as e:
##		# Something went wrong!
##		print("Something went wrong! error: " + String(e))
#
###Create's the Game
##createGame("GameName")
##
###Save the secret to a file and load it when the game starts so you can access that user
##secret = createUser("GameName", "User",{"Highscore": 0})
##
###will set the highscore to 10
##setHighScore("GameName", "Username", secret, {"Highscore": 10})
#
##Will get all the users highscores for that game
##getHighScore("GameName")

package classes {
	
	import flash.utils.setTimeout;
	import classes.kGAMECLASS;
	
	public class PlanetClass {

		private static var _planets:Array = new Array();
		public static function get planets():Array { return _planets;}
		
		private var _rooms:Array;
		public function get rooms():Array { return _rooms;}
		
		public var name:String;
		public var displayName:String;
		public var system:String;
		public var center:RoomClass;
		
		public function PlanetClass() {
			_rooms = new Array();
			_planets.push(this);
			center = null;
		}
		
		public static function loadPlanets(functionContainer:*):void {
			if(kGAMECLASS.planets == null) kGAMECLASS.planets = new Object();
			if(kGAMECLASS.rooms == null) kGAMECLASS.rooms = new Object();
			
			for each(var planetClass:Class in Planets.PLANETS) {
				var planetXML:XML = new XML(new planetClass);
				var planet:PlanetClass = new PlanetClass();
				planet.load(planetXML, functionContainer);
				kGAMECLASS.planets[planet.name] = planet;
			}
		}
		
		public function load(planetXML:XML, functionContainer:*):void {
			name = planetXML.Name;
			displayName = planetXML.DisplayName;
			system = planetXML.System;
			
			for each(var roomXML:XML in planetXML.Room) {
				var roomName:String = roomXML.attribute("name");
				if(rooms[roomName] != null) throw new Error("Room \"" + roomName + "\" in " + name + " already exists!");
				
				var room:RoomClass = new RoomClass(roomName);
				room.roomName = roomXML.Title.toString().replace("\\n", "\n");
				room.description = roomXML.Description;
				room.planet = this;
				
				
				if(roomXML.Function != undefined) {
					for each(var funcXML:XML in roomXML.Function) {
						var errorStage:int = 0;
						try {	
							errorStage = 0;
							var call:String = GLOBAL[funcXML.attribute("type")];
							
							errorStage = 1;
							var func:Function = functionContainer[roomXML.Function];

							room.addFunction(call, func);
						} catch(e:ReferenceError) {
							switch(errorStage) {
								case 0:
									trace("Function type \"" + funcXML.attribute("type") + "\" on room " + roomName + " does not exist");
									break;
								case 1:
									trace("Function \"" + roomXML.Function + "\" on " + functionContainer + " does not exist (" + roomName + ")");
									break;
							}
						}
					}
				}
				
				if(center == null) center = room;
				
				//Exits
				for each(var exitXML:XML in roomXML.Exit) {
					var to:String = exitXML.attribute("to");
					var type:String = exitXML.attribute("type");
					switch(type) {
						case "e":
							room.eastExit = to;
							break;
						case "w":
							room.westExit = to;
							break;
						case "n":
							room.northExit = to;
							break;
						case "s":
							room.southExit = to;
							break;
						case "in":
							room.inExit = to;
							if(exitXML.Text != undefined) room.inText = exitXML.Text;
							try {
								if(exitXML.Variable != undefined) room.inExit = functionContainer[exitXML.Variable];
							} catch(e:ReferenceError) {
								trace("Variable \"" + exitXML.Variable + "\" on " + functionContainer + " does not exist");
							}
							break;
						case "out":
							room.outExit = to;
							if(exitXML.Text != undefined) room.outText = exitXML.Text;
							try {
								if(exitXML.Variable != undefined) room.outExit = functionContainer[exitXML.Variable];
							} catch(e:ReferenceError) {
								trace("Variable \"" + exitXML.Variable + "\" on " + functionContainer + " does not exist");
							}
							break;
					}
					if(exitXML.Hidden != undefined) {
						trace("found hidden: " + room.name);
						room.hiddenExits.push(to);
					}
				}
				
				//Flags
				if(roomXML.Flag != undefined) {
					for each(var flagXML:XML in roomXML.Flag) {
						try {
							room.addFlag(GLOBAL[flagXML]);
						} catch(e:ReferenceError) {
							trace("Flag \"" + flagXML + "\" does not exist");
						}
					}
				} else {
					room.addFlag(GLOBAL.OUTDOOR);
				}
				rooms[room.name] = room;
				kGAMECLASS.rooms[room.name] = room;
			}
			
			var roomArr:Array = new Array();
			plotCoordinates(center, 0, 0, 0, roomArr);
			for each(var _room:RoomClass in rooms) {
				if(_room.x == 0 && _room.y == 0 && _room.z == 0 && _room != center) {
					if(_room.northExit && roomArr.indexOf(_room.northExit) != -1) {
						_room.x = _room.getExit("n").x;
						_room.y = _room.getExit("n").y - 1;
						_room.z = _room.getExit("n").z;
					}
					if(_room.southExit && roomArr.indexOf(_room.southExit) != -1) {
						_room.x = _room.getExit("s").x;
						_room.y = _room.getExit("s").y + 1;
						_room.z = _room.getExit("s").z;
					}
					if(_room.eastExit && roomArr.indexOf(_room.eastExit) != -1) {
						_room.x = _room.getExit("e").x - 1;
						_room.y = _room.getExit("e").y;
						_room.z = _room.getExit("e").z;
					}
					if(_room.westExit && roomArr.indexOf(_room.westExit) != -1) {
						_room.x = _room.getExit("w").x + 1;
						_room.y = _room.getExit("w").y;
						_room.z = _room.getExit("w").z;
					}
					if(_room.inExit && roomArr.indexOf(_room.inExit) != -1) {
						_room.x = _room.getExit("i").x;
						_room.y = _room.getExit("i").y;
						_room.z = _room.getExit("i").z - 1;
					}
					if(_room.outExit && roomArr.indexOf(_room.outExit) != -1) {
						_room.x = _room.getExit("o").x;
						_room.y = _room.getExit("o").y;
						_room.z = _room.getExit("o").z + 1;
					}
				}
				if(_room.x == 0 && _room.y == 0 && _room.z == 0 && _room != center) trace("BAD ROOM: " + _room.name + " Important? " + (RoomClass.needLoading.indexOf(_room) != -1))
			}
		}
		
		private function plotCoordinates(room:RoomClass, x:int, y:int, z:int, rooms:Array) {
			if(room == null) return;
			if(rooms.indexOf(room.name) != -1) return;
			room.x = x;
			room.y = y;
			room.z = z;
			rooms.push(room.name);
			if(room.northExit) plotCoordinates(room.getExit("n"), x, y + 1, z, rooms);
			if(room.southExit) plotCoordinates(room.getExit("s"), x, y - 1, z, rooms);
			if(room.eastExit) plotCoordinates(room.getExit("e"), x + 1, y, z, rooms);
			if(room.westExit) plotCoordinates(room.getExit("w"), x - 1, y, z, rooms);
			if(room.inExit) plotCoordinates(room.getExit("i"), x, y, z + 1, rooms);
			if(room.outExit) plotCoordinates(room.getExit("o"), x, y, z - 1, rooms);
		}
		
		public function getRoomById(id:int):RoomClass {
			for each(var room:RoomClass in rooms) {
				if(room.uid == id) return room;
			}
			return null;
		}

	}
	
}

class Planets {
	
	[Embed(source = "../rooms/LEAF.xml", mimeType = "application/octet-stream")]
	public static const LEAF:Class;
	
	[Embed(source = "../rooms/MHEN'GA.xml", mimeType = "application/octet-stream")]
	public static const MHENGA:Class;
		
	[Embed(source = "../rooms/NEW TEXAS.xml", mimeType = "application/octet-stream")]
	public static const NEW_TEXAS:Class;
	
	[Embed(source = "../rooms/PHOENIX.xml", mimeType = "application/octet-stream")]
	public static const PHOENIX:Class;
		
	[Embed(source = "../rooms/TARKUS.xml", mimeType = "application/octet-stream")]
	public static const TARKUS:Class;
		
	[Embed(source = "../rooms/TAVROS STATION.xml", mimeType = "application/octet-stream")]
	public static const TAVROS_STATION:Class;
	
	public static const PLANETS:Array = new Array(LEAF, MHENGA, NEW_TEXAS, PHOENIX, TARKUS, TAVROS_STATION);
}